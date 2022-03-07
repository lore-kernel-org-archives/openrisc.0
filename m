From: Stafford Horne <shorne@gmail.com>
Date: Mon, 7 Mar 2022 13:37:55 +0900
Subject: [OpenRISC] Call for help - OpenRISC D-Cache issue
Message-ID: <CAAfxs75Q+fkiagFc2hvMcJmudmAEL6y+-otObmr6ArBX9uOTbQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

I am trying to track down a dcache issue that is causing linux to be unstable.

Issue: https://github.com/openrisc/mor1kx/issues/146
Initial PR: https://github.com/openrisc/mor1kx/pull/147

This pull request reverts a change I put in last year to fix a D-Cache
issue[0]. I bisected to this and reverted it.  The issue last year was
with handling this instruction pattern produced by GCC:

From or1k-tests . test or1k-mmu
    2c7c:       c0 11 e8 00     l.mtspr r17,r29,0x0
    2c80:       c0 11 c8 00     l.mtspr r17,r25,0x0
    2c84:       d4 01 c8 20     l.sw 32(r1),r25
    2c88:       c0 11 b8 00     l.mtspr r17,r23,0x0
    2c8c:       c0 11 a8 00     l.mtspr r17,r21,0x0

After this PR linux is now stable, but our mmu test case handling
mtspr,sw,mtspr fails again.

The failure is that the store fails at 2c84 to update the D-Cache way
ram.  The subsequent load from D-Cache returns an incorrect stale
value and the test case fails.

[0] https://github.com/openrisc/mor1kx/issues/122

*Call for Help*
I have been trying to debug this by looking at the handshaking and
signals that habben between the LSU and the D-Cache.  For example:

In mor1k_lsu_cappuccino some signals:

   // Assert lsu_valid_o to progress pipeline past LSU operation if the LSU
   // operation is done and we are not waiting on tlb reloads or data cache
   // invalidations.
   assign lsu_valid_o = (lsu_ack | access_done) &
            !tlb_reload_busy & !dc_snoop_hit;

   // If we are writing we wait for the store buffer ack and
   // in case of dcache being busy we wait for data cache ack too
   assign lsu_ack = (ctrl_op_lsu_store_i | state == WRITE) ?
                     (ctrl_op_lsu_atomic_i ? write_done : store_buffer_ack) :
             (dbus_access ? dbus_ack : dc_ack);

   // Indicates if reads come from the data bus or data cache
   assign dbus_access = (!dc_access | tlb_reload_busy | ctrl_op_lsu_store_i) &
            (state != DC_REFILL) | (state == WRITE);

In mor1kx_dcache:

   assign cpu_ack_o = ((read | refill) & hit & !write_pending |
               refill_hit) & cpu_req_i & !snoop_hit;


To me these are pretty complicated condition statements, and I am
trying to document the best that I can and I have made some progress.
 The main problem I see is that when the LSU gets a request to write
to memory it will ack the request once the write is stored to the
store buffer.  It doesn't seem to take into account if the write to
the dcache is complete or not.

I will continue to look at this and try to figure out the best way to
add some d-cache write feedback to the LSU<->DCACHE interface.  But
some general questions:

  * Do any of you remember this very well can provide some pointers?
  * Are these complicated conditions normal?  Any tips on trying to
understand them better?


-Stafford
