From: Stafford Horne <shorne@gmail.com>
Date: Tue, 25 Apr 2017 23:18:27 +0900
Subject: [OpenRISC] [PATCH RFC] target/openrisc: Support non-busy idle
 state using PMR SPR
In-Reply-To: <f6a7d386-80a9-0cc3-e1ec-1b2058aa5bf9@twiddle.net>
References: <ab4f029c-8264-7d35-b0e0-9b35a8e80d9d@twiddle.net>
 <20170423215420.27098-1-shorne@gmail.com>
 <f6a7d386-80a9-0cc3-e1ec-1b2058aa5bf9@twiddle.net>
Message-ID: <20170425141827.GA2724@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Apr 25, 2017 at 12:11:00PM +0200, Richard Henderson wrote:
> On 04/23/2017 11:54 PM, Stafford Horne wrote:
> > The OpenRISC architecture has the Power Management Register (PMR)
> > special purpose register to manage cpu power states.  The interesting
> > modes are:
> > 
> >   * Doze Mode (DME) - Stop cpu except timer & pic - wake on interrupt
> >   * Sleep Mode (SME) - Stop cpu and all units - wake on interrupt
> >   * Suspend Model (SUME) - Stop cpu and all units - wake on reset
> > 
> > The linux kernel will set DME when idle.
> 
> And SUME would be, essentially, poweroff?  Perhaps at least for the purposes
> of QEMU; on real hardware one could press a button to assert reset and
> reboot.

Yes, that is what I am thinking, but I could add this later, after some
reviews with other OpenRISC folks.

> > Also, I don't know if its due to this patch of an issue with the timer
> > interrupts.  After applying this patch the timer interrupts do not trigger
> > until a keypress is make.  i.e. something like this...
> > 
> >    $ sleep 5
> >    <hangs forever until a key is pressed>
> ...
> > +            cpu_restore_state(cs, GETPC() + 4);
> 
> This isn't correct.  You want
> 
> 	cpu_restore_state(cs, GETPC());
> 	cs->env.pc += 4;
> 
> So what's happening is that you're re-executing the MTSPR and going back to
> sleep again.  Which probably explains the hang.

I have changed to the above, but I think its essentially the same.  It
resumes after the MTSPR in both cases.

I fixed this now though, you should see another patch.  The issue is the
timer events get ignored once the cpu is in halt state, I added a
qemu_cpu_kick() call in the timer hardware to wake up the cpu on timer
interrupts.  Not sure if thats the best way to do it, but it works 100%
now.

-Stafford
