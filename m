From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Thu, 28 Apr 2022 14:42:20 +0200
Subject: [OpenRISC] [PATCH] openrisc: define nop command for simulator
 reboot
In-Reply-To: <YmqAx31dtXCaNn7R@antec>
References: <20220428111139.1330966-1-Jason@zx2c4.com> <YmqAx31dtXCaNn7R@antec>
Message-ID: <YmqLrDfbEGP659EO@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Apr 28, 2022 at 08:55:51PM +0900, Stafford Horne wrote:
> On Thu, Apr 28, 2022 at 01:11:39PM +0200, Jason A. Donenfeld wrote:
> > The simulator defines `l.nop 1` for shutdown, but doesn't have anything
> > for reboot. Use 13 for this, which is currently unused, dubbed
> > `NOP_REBOOT`.
> > 
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Link: https://lore.kernel.org/all/YmnaDUpVI5ihgvg6 at zx2c4.com/
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  arch/openrisc/kernel/process.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> > index 3c0c91bcdcba..4cce95fa6eb5 100644
> > --- a/arch/openrisc/kernel/process.c
> > +++ b/arch/openrisc/kernel/process.c
> > @@ -52,6 +52,8 @@ void machine_restart(char *cmd)
> >  {
> >  	do_kernel_restart(cmd);
> >  
> > +	__asm__("l.nop 13");
> > +
> >  	/* Give a grace period for failure to restart of 1s */
> >  	mdelay(1000);
> >  
> > -- 
> > 2.35.1
> 
> This seems fair, probably it would be good to have a comment mentioninmg what
> the nop is for, fyi for context these are the nop numbers used to control
> simulations.
> 
>     #define NOP_NOP          0x0000      /* Normal nop instruction */
>     #define NOP_EXIT         0x0001      /* End of simulation */
>     #define NOP_REPORT       0x0002      /* Simple report */
>     /*#define NOP_PRINTF       0x0003       Simprintf instruction (obsolete)*/
>     #define NOP_PUTC         0x0004      /* JPB: Simputc instruction */
>     #define NOP_CNT_RESET    0x0005      /* Reset statistics counters */
>     #define NOP_GET_TICKS    0x0006      /* JPB: Get # ticks running */
>     #define NOP_GET_PS       0x0007      /* JPB: Get picosecs/cycle */
>     #define NOP_TRACE_ON     0x0008      /* Turn on tracing */
>     #define NOP_TRACE_OFF    0x0009      /* Turn off tracing */
>     #define NOP_RANDOM       0x000a      /* Return 4 random bytes */
>     #define NOP_OR1KSIM      0x000b      /* Return non-zero if this is Or1ksim */
>     #define NOP_EXIT_SILENT  0x000c      /* End of simulation, quiet version */
>     /* New! */
>     #define NOP_RESET        0x000d      /* Reset the cpu */

Right, that's where I got 13 from. By the way, the .tex file only
mentions ones up to 11, so at first I chose 12, and then saw this file.

> 
> I will queue this once we update the spec to define some of these, I am thinking
> if qemu should allow for the shutdown to work in user mode.
> 
> BTW, are you working specifically on openrisc? Or just setting up test
> environments for all architectures?

Trying to get OpenRISC up on https://build.wireguard.com/ . The other
architectures were simple, but OpenRISC is requiring some work...

Jason
