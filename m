From: Stafford Horne <shorne@gmail.com>
Date: Sat, 25 Feb 2017 05:09:46 +0900
Subject: [OpenRISC] [PATCH v4 21/24] openrisc: head: Move init strings
 to rodata section
In-Reply-To: <d204faf6-23f4-73de-e643-9a9ba2d92205@southpole.se>
References: <cover.1487910170.git.shorne@gmail.com>
 <b53f4e075a96bac470a67e0110bad71cb74cdfe6.1487910170.git.shorne@gmail.com>
 <d204faf6-23f4-73de-e643-9a9ba2d92205@southpole.se>
Message-ID: <20170224200946.GT2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 24, 2017 at 10:28:46AM +0100, Jonas Bonn wrote:
> On 02/24/2017 05:32 AM, Stafford Horne wrote:
> > The strings used during the head/init phase of openrisc bootup were
> > stored in the executable section of the binary.
> > 
> > This causes compilation to fail when using CONFIG_DEBUG_INFO with
> > error:
> >   Error: unaligned opcodes detected in executable segment
> > 
> > Also, this patch removes unused strings.
> This should be two patches:  one that removes unused strings and one that
> switches the data section.
> 
> Works like "Also" usually indicate that you are doing too much in your patch
> and you need to split it up.

Hi Jonas,

Right, I'll split this one.  I was debating that due to the size. But
it would be right in this case.

Also, I use the word also a lot :)

-Stafford

> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   arch/openrisc/kernel/head.S | 12 +-----------
> >   1 file changed, 1 insertion(+), 11 deletions(-)
> > 
> > diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
> > index a22f1fc..573e131 100644
> > --- a/arch/openrisc/kernel/head.S
> > +++ b/arch/openrisc/kernel/head.S
> > @@ -1530,11 +1530,7 @@ ENTRY(_early_uart_init)
> >   	l.jr	r9
> >   	l.nop
> > -_string_copying_linux:
> > -	.string "\n\n\n\n\n\rCopying Linux... \0"
> > -
> > -_string_ok_booting:
> > -	.string "Ok, booting the kernel.\n\r\0"
> > +	.section .rodata
> >   _string_unhandled_exception:
> >   	.string "\n\rRunarunaround: Unhandled exception 0x\0"
> > @@ -1545,12 +1541,6 @@ _string_epc_prefix:
> >   _string_nl:
> >   	.string "\n\r\0"
> > -	.global	_string_esr_irq_bug
> > -_string_esr_irq_bug:
> > -	.string "\n\rESR external interrupt bug, for details look into entry.S\n\r\0"
> > -
> > -
> > -
> >   /* ========================================[ page aligned structures ]=== */
> >   /*
> 
> 
