From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Thu, 29 Mar 2018 18:32:47 +0100
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <86zi2qrfgl.wl-marc.zyngier@arm.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
 <20180329152749.GC16141@n2100.armlinux.org.uk>
 <CAMuHMdXAckNiUQKT2WU6xaJjbECrifmH6fg_mET+h3iXf_RgDQ@mail.gmail.com>
 <20180329155827.GD16141@n2100.armlinux.org.uk>
 <86zi2qrfgl.wl-marc.zyngier@arm.com>
Message-ID: <20180329173247.GF16141@n2100.armlinux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Mar 29, 2018 at 05:53:14PM +0100, Marc Zyngier wrote:
> On Thu, 29 Mar 2018 16:58:27 +0100,
> Russell King - ARM Linux wrote:
> > 
> > On Thu, Mar 29, 2018 at 05:43:47PM +0200, Geert Uytterhoeven wrote:
> > > On Thu, Mar 29, 2018 at 5:27 PM, Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:
> > > > On Thu, Mar 29, 2018 at 09:37:52AM +1100, Oliver wrote:
> > > >> On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
> > > >> <linux@armlinux.org.uk> wrote:
> > > >> > On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
> > > >> >> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> > > >> >> > On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
> > > >> >> >> On 03/28/2018 10:26 AM, Shea Levy wrote:
> > > >> >> >>> Now only those architectures that have custom initrd free requirements
> > > >> >> >>> need to define free_initrd_mem.
> > > >> >> >> ...
> > > >> >> >>> --- a/arch/arc/mm/init.c
> > > >> >> >>> +++ b/arch/arc/mm/init.c
> > > >> >> >>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
> > > >> >> >>>  {
> > > >> >> >>>   free_initmem_default(-1);
> > > >> >> >>>  }
> > > >> >> >>> -
> > > >> >> >>> -#ifdef CONFIG_BLK_DEV_INITRD
> > > >> >> >>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> > > >> >> >>> -{
> > > >> >> >>> - free_reserved_area((void *)start, (void *)end, -1, "initrd");
> > > >> >> >>> -}
> > > >> >> >>> -#endif
> > > >> >> >>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > >> >> >>> index 3f972e83909b..19d1c5594e2d 100644
> > > >> >> >>> --- a/arch/arm/Kconfig
> > > >> >> >>> +++ b/arch/arm/Kconfig
> > > >> >> >>> @@ -47,6 +47,7 @@ config ARM
> > > >> >> >>>   select HARDIRQS_SW_RESEND
> > > >> >> >>>   select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> > > >> >> >>>   select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> > > >> >> >>> + select HAVE_ARCH_FREE_INITRD_MEM
> > > >> >> >>>   select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> > > >> >> >>>   select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> > > >> >> >>>   select HAVE_ARCH_MMAP_RND_BITS if MMU
> > > >> >> >>
> > > >> >> >> Isn't this why weak symbols were invented?
> > > >> >> >
> > > >> >> > Weak symbols means that we end up with both the weakly-referenced code
> > > >> >> > and the arch code in the kernel image.  That's fine if the weak code
> > > >> >> > is small.
> > > >> >>
> > > >> >> The kernel's been able to build with link time garbage collection since 2016:
> > > >> >>
> > > >> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
> > > >> >>
> > > >> >> Wouldn't that remove the unused one?
> > > >> >
> > > >> > Probably, if anyone bothered to use that, which they don't.
> > > >> >
> > > >> > LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
> > > >> > what I can see, nothing selects it.  Therefore, the symbol is always
> > > >> > disabled, and so the feature never gets used in mainline kernels.
> > > >> >
> > > >> > Brings up the obvious question - why is it there if it's completely
> > > >> > unused?  (Maybe to cause confusion, and allowing a justification
> > > >> > for __weak ?)
> > > >>
> > > >> IIRC Nick had some patches to do the arch enablement for powerpc, but
> > > >> I'm not sure what happened to them though. I suspect it just fell down
> > > >> Nick's ever growing TODO list.
> > > >
> > > > I've given it a go on ARM, marking every linker-built table with KEEP()
> > > > and comparing the System.map files.  The resulting kernel is around
> > > > 150k smaller, which seems good.
> > > >
> > > > However, it doesn't boot - and I don't know why.  Booting the kernel
> > > > under kvmtool in a VM using virtio-console, I can find no way to get
> > > > any kernel messages out of it.  Using lkvm debug, I can see that the
> > > > PC is stuck inside die(), and that's the only information I have.
> > > > It dies before bringing up the other CPUs, so it's a very early death.
> > > >
> > > > I don't think other console types are available under ARM64.
> > > 
> > > earlycon?
> > 
> > Through what - as I say above, I think the only thing that's present is
> > virtio-console, and the virtio stack only get initialised much later in
> > boot.
> > 
> > Eg, there's the memory-based virtio driver which interfaces any virtio
> > driver to a memory-based ring structures for communication with the host
> > (drivers/virtio/virtio_mmio.c) which is initialised at module_init()
> > time, and so isn't available for earlycon.
> > 
> > I don't think merely changing the module_init() calls in the appropriate
> > virtio bits will suffice - it's why I pointed out that it dies before
> > SMP initialisation, which also means that it dies before we start
> > running the initcalls for subsystems and drivers.
> > 
> > I'm not aware of there being an emulated UART in the guest's address
> > space, so serial based stuff doesn't work.
> 
> "earlycon=uart,mmio,0x3f8" is what you're looking for:

Does that also mean that we have a RTC at the standard PC IO addresses
as well, but in mmio space?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
