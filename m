From: Stafford Horne <shorne@gmail.com>
Date: Sat, 25 Feb 2017 05:31:51 +0900
Subject: [OpenRISC] [PATCH v4 19/24] openrisc: entry: Whitespace and
	comment cleanups
In-Reply-To: <7b063d8d-6462-fd1b-9b7c-4e4af4701a07@southpole.se>
References: <cover.1487910170.git.shorne@gmail.com>
 <bc9bb8b52d059efd339dc1bb649483cb8749ab02.1487910170.git.shorne@gmail.com>
 <7b063d8d-6462-fd1b-9b7c-4e4af4701a07@southpole.se>
Message-ID: <20170224203151.GV2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 24, 2017 at 10:45:08AM +0100, Jonas Bonn wrote:
> On 02/24/2017 05:32 AM, Stafford Horne wrote:
> > Cleanups to whitespace and add some comments. Reading through the delay
> > slot logic I noticed some things:
> >   - Delay slot instructions were not indented
> >   - Some comments are not lined up
> >   - Use tabs and spaces consistent with other code
> > 
> > No functional change
> 
> No, don't do this.  Whitespace cleanups like this make life difficult for
> people rebasing on your tree, as well as blunting useful tools like git
> blame.
> 
> I'm not against the indentation of the delay slot instructions; that seems
> sane and should be pretty transparent in a merge conflict.
> 
> The whitespace cleanup and tab-space toggling needs to go, though. These
> sorts of things are better fixed up when the code lines they apply to are
> changed for other, functional reasons.
> 
> I suggest you pull out the delay slot fixups into a separate patch and then
> just sit on the rest until you've discovered the pain of whitespace
> cleanup-inflicted merge conflicts and decide to just ditch them altogether.

Hi Jonas,

I agree here and definitely if I knew others were actively working on this
code I would be a bit more careful.  But the truth is I think its only me
right now.  If you have patches that will get a conflict due to this let me
know.

Also, all of our out of tree patches for this file are actually upstream
(as of this series now).

Also, for me, this was needed in order for me to read the code (i.e.
comments in the right place, and removing commented out lines) and fix the
bug in the next patch.

Nevertheless, if someone else thinks this should be left out Ill revert.

-Stafford

> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   arch/openrisc/kernel/entry.S | 38 ++++++++++++++++++--------------------
> >   1 file changed, 18 insertions(+), 20 deletions(-)
> > 
> > diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
> > index ba1a361..daae2a4 100644
> > --- a/arch/openrisc/kernel/entry.S
> > +++ b/arch/openrisc/kernel/entry.S
> > @@ -228,7 +228,7 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
> >   	 * DTLB miss handler in the CONFIG_GUARD_PROTECTED_CORE part
> >   	 */
> >   #ifdef CONFIG_OPENRISC_NO_SPR_SR_DSX
> > -	l.lwz   r6,PT_PC(r3)                  // address of an offending insn
> > +	l.lwz   r6,PT_PC(r3)               // address of an offending insn
> >   	l.lwz   r6,0(r6)                   // instruction that caused pf
> >   	l.srli  r6,r6,26                   // check opcode for jump insn
> > @@ -244,49 +244,47 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
> >   	l.bf    8f
> >   	l.sfeqi r6,0x12                    // l.jalr
> >   	l.bf    8f
> > -
> > -	l.nop
> > +	 l.nop
> >   	l.j     9f
> > -	l.nop
> > -8:
> > +	 l.nop
> > -	l.lwz   r6,PT_PC(r3)                  // address of an offending insn
> > +8: // offending insn is in delay slot
> > +	l.lwz   r6,PT_PC(r3)               // address of an offending insn
> >   	l.addi  r6,r6,4
> >   	l.lwz   r6,0(r6)                   // instruction that caused pf
> >   	l.srli  r6,r6,26                   // get opcode
> > -9:
> > +9: // offending instruction opcode loaded in r6
> >   #else
> > -	l.mfspr r6,r0,SPR_SR		   // SR
> > -//	l.lwz	r6,PT_SR(r3)		   // ESR
> > -	l.andi	r6,r6,SPR_SR_DSX	   // check for delay slot exception
> > -	l.sfeqi	r6,0x1			   // exception happened in delay slot
> > -	l.bnf	7f
> > -	l.lwz	r6,PT_PC(r3)		   // address of an offending insn
> > +	l.mfspr r6,r0,SPR_SR               // SR
> > +	l.andi  r6,r6,SPR_SR_DSX           // check for delay slot exception
> > +	l.sfeqi r6,0x1                     // exception happened in delay slot
> > +	l.bnf   7f
> > +	 l.lwz  r6,PT_PC(r3)               // address of an offending insn
> > -	l.addi	r6,r6,4			   // offending insn is in delay slot
> > +	l.addi	r6,r6,4                    // offending insn is in delay slot
> >   7:
> >   	l.lwz   r6,0(r6)                   // instruction that caused pf
> >   	l.srli  r6,r6,26                   // check opcode for write access
> >   #endif
> > -	l.sfgeui r6,0x33		   // check opcode for write access
> > +	l.sfgeui r6,0x33                   // check opcode for write access
> >   	l.bnf   1f
> >   	l.sfleui r6,0x37
> >   	l.bnf   1f
> >   	l.ori   r6,r0,0x1                  // write access
> >   	l.j     2f
> > -	l.nop
> > +	 l.nop
> >   1:	l.ori   r6,r0,0x0                  // !write access
> >   2:
> >   	/* call fault.c handler in or32/mm/fault.c */
> >   	l.jal   do_page_fault
> > -	l.nop
> > +	 l.nop
> >   	l.j     _ret_from_exception
> > -	l.nop
> > +	 l.nop
> >   /* ---[ 0x400: Insn Page Fault exception ]------------------------------- */
> >   EXCEPTION_ENTRY(_itlb_miss_page_fault_handler)
> > @@ -306,9 +304,9 @@ EXCEPTION_ENTRY(_insn_page_fault_handler)
> >   	/* call fault.c handler in or32/mm/fault.c */
> >   	l.jal   do_page_fault
> > -	l.nop
> > +	 l.nop
> >   	l.j     _ret_from_exception
> > -	l.nop
> > +	 l.nop
> >   /* ---[ 0x500: Timer exception ]----------------------------------------- */
> 
> 
