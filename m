From: Richard Henderson <rth@twiddle.net>
Date: Tue, 25 Apr 2017 12:11:00 +0200
Subject: [OpenRISC] [PATCH RFC] target/openrisc: Support non-busy idle
 state using PMR SPR
In-Reply-To: <20170423215420.27098-1-shorne@gmail.com>
References: <ab4f029c-8264-7d35-b0e0-9b35a8e80d9d@twiddle.net>
 <20170423215420.27098-1-shorne@gmail.com>
Message-ID: <f6a7d386-80a9-0cc3-e1ec-1b2058aa5bf9@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 04/23/2017 11:54 PM, Stafford Horne wrote:
> The OpenRISC architecture has the Power Management Register (PMR)
> special purpose register to manage cpu power states.  The interesting
> modes are:
> 
>   * Doze Mode (DME) - Stop cpu except timer & pic - wake on interrupt
>   * Sleep Mode (SME) - Stop cpu and all units - wake on interrupt
>   * Suspend Model (SUME) - Stop cpu and all units - wake on reset
> 
> The linux kernel will set DME when idle.

And SUME would be, essentially, poweroff?  Perhaps at least for the purposes of 
QEMU; on real hardware one could press a button to assert reset and reboot.

> Also, I don't know if its due to this patch of an issue with the timer
> interrupts.  After applying this patch the timer interrupts do not trigger
> until a keypress is make.  i.e. something like this...
> 
>    $ sleep 5
>    <hangs forever until a key is pressed>
...
> +            cpu_restore_state(cs, GETPC() + 4);

This isn't correct.  You want

	cpu_restore_state(cs, GETPC());
	cs->env.pc += 4;

So what's happening is that you're re-executing the MTSPR and going back to 
sleep again.  Which probably explains the hang.


r~
