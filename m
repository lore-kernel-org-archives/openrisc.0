From: Stafford Horne <shorne@gmail.com>
Date: Sat, 25 Feb 2017 05:13:08 +0900
Subject: [OpenRISC] [PATCH v4 20/24] openrisc: entry: Fix delay slot
	detection
In-Reply-To: <188dcb34-4e8e-7636-e31d-2ae451dac2ff@southpole.se>
References: <cover.1487910170.git.shorne@gmail.com>
 <34caff307ead3a1b67a7226507082ace94e22875.1487910170.git.shorne@gmail.com>
 <188dcb34-4e8e-7636-e31d-2ae451dac2ff@southpole.se>
Message-ID: <20170224201308.GU2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 24, 2017 at 10:32:32AM +0100, Jonas Bonn wrote:
> On 02/24/2017 05:32 AM, Stafford Horne wrote:
> > Use execption SR stored in pt_regs for detection, the current SR is not
> > correct as the handler is running after return from exception.
> > 
> > Also, The code that checks for a delay slot uses a flag bitmask and then
> > wants to check if the result is not zero.  The test it implemented was
> > wrong.
> > 
> > Correct it by changing the test to check result against non zero.
> 
> This wants to be two patches as you are changing two different things.

Hi Jonas,

Technically yes, two things, but...

The logic is broken without both fixes.  It would be a nightmare for someone
to review these one-liners as two patches.

I would like to keep as one.

-Stafford

> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   arch/openrisc/kernel/entry.S | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
> > index daae2a4..bc65008 100644
> > --- a/arch/openrisc/kernel/entry.S
> > +++ b/arch/openrisc/kernel/entry.S
> > @@ -258,9 +258,9 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
> >   #else
> > -	l.mfspr r6,r0,SPR_SR               // SR
> > +	l.lwz   r6,PT_SR(r3)               // SR
> >   	l.andi  r6,r6,SPR_SR_DSX           // check for delay slot exception
> > -	l.sfeqi r6,0x1                     // exception happened in delay slot
> > +	l.sfne  r6,r0                      // exception happened in delay slot
> >   	l.bnf   7f
> >   	 l.lwz  r6,PT_PC(r3)               // address of an offending insn
> 
> 
