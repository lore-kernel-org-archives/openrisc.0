From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Thu, 29 Mar 2018 18:31:03 +0100
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <c91e8781-5f31-70e8-e7ef-1a80bd5d9454@landley.net>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <c91e8781-5f31-70e8-e7ef-1a80bd5d9454@landley.net>
Message-ID: <20180329173103.GE16141@n2100.armlinux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Mar 29, 2018 at 11:39:24AM -0500, Rob Landley wrote:
> 
> 
> On 03/28/2018 05:14 PM, Russell King - ARM Linux wrote:
> > On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
> >>
> >>
> >> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> >>> On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
> >>>> On 03/28/2018 10:26 AM, Shea Levy wrote:
> >>>>> Now only those architectures that have custom initrd free requirements
> >>>>> need to define free_initrd_mem.
> >>>> ...
> >>>>> --- a/arch/arc/mm/init.c
> >>>>> +++ b/arch/arc/mm/init.c
> >>>>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
> >>>>>  {
> >>>>>  	free_initmem_default(-1);
> >>>>>  }
> >>>>> -
> >>>>> -#ifdef CONFIG_BLK_DEV_INITRD
> >>>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> >>>>> -{
> >>>>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> >>>>> -}
> >>>>> -#endif
> >>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>>>> index 3f972e83909b..19d1c5594e2d 100644
> >>>>> --- a/arch/arm/Kconfig
> >>>>> +++ b/arch/arm/Kconfig
> >>>>> @@ -47,6 +47,7 @@ config ARM
> >>>>>  	select HARDIRQS_SW_RESEND
> >>>>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> >>>>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> >>>>> +	select HAVE_ARCH_FREE_INITRD_MEM
> >>>>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> >>>>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> >>>>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
> >>>>
> >>>> Isn't this why weak symbols were invented?
> >>>
> >>> Weak symbols means that we end up with both the weakly-referenced code
> >>> and the arch code in the kernel image.  That's fine if the weak code
> >>> is small.
> >>
> >> The kernel's been able to build with link time garbage collection since 2016:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
> >>
> >> Wouldn't that remove the unused one?
> > 
> > Probably, if anyone bothered to use that, which they don't.
> > 
> > LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
> > what I can see, nothing selects it.  Therefore, the symbol is always
> > disabled, and so the feature never gets used in mainline kernels.
> 
> It looks like there are per-architecture linker scripts that need to be updated?
> So if an architecture supports it, it's always done (well, it probes for the
> toolchain supporting the flag). And if the architecture doesn't support it, the
> linker script needs to be updated to mark sections with "I know nothing seems to
> reference this at the ELF level but keep it anyway, we're pulling an assembly
> trick".

It looks like it needs much more than just architecture changes as the
reason it fails on ARM is because the init thread structure is missing
due to missing KEEP()s in INIT_TASK_DATA().  Probably means it doesn't
work anywhere.

8<===
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] Fix LD_DEAD_CODE_DATA_ELIMINATION

LD_DEAD_CODE_DATA_ELIMINATION fails to boot on ARM because the linker
eliminates the init thread data from the bottom of the init threads
stack.  This causes recursive faults that end up overwriting parts
of the kernel before they can print any message.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 include/asm-generic/vmlinux.lds.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ab0e520d6fc..41af8a74aae4 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -279,8 +279,8 @@
 	VMLINUX_SYMBOL(__start_init_task) = .;				\
 	VMLINUX_SYMBOL(init_thread_union) = .;				\
 	VMLINUX_SYMBOL(init_stack) = .;					\
-	*(.data..init_task)						\
-	*(.data..init_thread_info)					\
+	KEEP(*(.data..init_task))					\
+	KEEP(*(.data..init_thread_info))				\
 	. = VMLINUX_SYMBOL(__start_init_task) + THREAD_SIZE;		\
 	VMLINUX_SYMBOL(__end_init_task) = .;
 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
