From: Rob Landley <rob@landley.net>
Date: Thu, 29 Mar 2018 12:43:05 -0500
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <20180329152749.GC16141@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
 <20180329152749.GC16141@n2100.armlinux.org.uk>
Message-ID: <1ec5d19a-d649-38bd-ab89-868e1ad9dd7f@landley.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 03/29/2018 10:27 AM, Russell King - ARM Linux wrote:
> On Thu, Mar 29, 2018 at 09:37:52AM +1100, Oliver wrote:
>> On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
>>> LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
>>> what I can see, nothing selects it.  Therefore, the symbol is always
>>> disabled, and so the feature never gets used in mainline kernels.
>>>
>>> Brings up the obvious question - why is it there if it's completely
>>> unused?  (Maybe to cause confusion, and allowing a justification
>>> for __weak ?)
>>
>> IIRC Nick had some patches to do the arch enablement for powerpc, but
>> I'm not sure what happened to them though. I suspect it just fell down
>> Nick's ever growing TODO list.
> 
> I've given it a go on ARM, marking every linker-built table with KEEP()
> and comparing the System.map files.  The resulting kernel is around
> 150k smaller, which seems good.
> 
> However, it doesn't boot - and I don't know why.  Booting the kernel
> under kvmtool in a VM using virtio-console, I can find no way to get
> any kernel messages out of it.  Using lkvm debug, I can see that the
> PC is stuck inside die(), and that's the only information I have.

qemu-system-arm's "-s" option lets you hook to the hardware with gdb, as if
using one of those jtags that speaks gdbserver protocol. It stops waiting for
you to attach with 'target remote' it, then 'file vmlinux' to load the symbols...

The miniconfig and qemu invocation I use for arm64 are attached, tested with
2.11.0 on a 4.14 kernel. You should be able to just "qemu-aarch64.sh -s" and
then probably "target remote 127.0.0.1:1234"? (Been a while since I've used it,
don't have a cross-gdb for arm64 lying around...)

Sigh, I just tried -s and qemu 2.11.0 is _not_ waiting for gdb to attach on
arm64, despite what the docs say:

$ qemu-system-aarch64 --help | grep gdb
-gdb dev        wait for gdb connection on 'dev'
-s              shorthand for -gdb tcp::1234

Another random regression in qemu, gee what a surprise.

> It dies before bringing up the other CPUs, so it's a very early death.
> 
> I don't think other console types are available under ARM64.

I've often found useful the two line version of:

https://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/

Which is generally some variant of:

{char *XX = "blah"; while (*XX) {while (*SERIAL_STATUS_REGISTER & OUT_READY);
*SERIAL_OUT = *XX++;}}

(I.E. balu cheated not spinning checking the ready-for-next-byte bit, because
qemu's always angry.)

That trick lets you cut and paste a print statement into all sorts of early
hardware nonsense, on most architectures. You just have to look up
SERIAL_STATUS_REGISTER, OUT_OK_BIT, and SERIAL_OUT values for the serial port du
jour.

That said I've mostly used it in things like u-boot. I dunno at what point the
kernel's done enough setup that direct banging on registers would stop working.
(Works in the decompresion code, anyway.) And it assumes the port's set to the
right speed (usually left there by the bootloader)...

Rob
-------------- next part --------------
# make ARCH=arm64 allnoconfig KCONFIG_ALLCONFIG=aarch64.miniconf
# make ARCH=arm64 -j $(nproc)
# boot arch/arm64/boot/Image


CONFIG_MMU=y
CONFIG_ARCH_MULTI_V7=y
CONFIG_ARCH_VIRT=y
CONFIG_SOC_DRA7XX=y
CONFIG_ARCH_OMAP2PLUS_TYPICAL=y
CONFIG_ARCH_ALPINE=y
CONFIG_ARM_THUMB=y
CONFIG_VDSO=y
CONFIG_CPU_IDLE=y
CONFIG_ARM_CPUIDLE=y
CONFIG_KERNEL_MODE_NEON=y

CONFIG_SERIAL_AMBA_PL011=y
CONFIG_SERIAL_AMBA_PL011_CONSOLE=y

CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_DRV_PL031=y

CONFIG_NET_CORE=y
CONFIG_VIRTIO_NET=y

CONFIG_PCI=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_MMIO=y

CONFIG_ATA=y
CONFIG_ATA_SFF=y
CONFIG_ATA_BMDMA=y
CONFIG_ATA_PIIX=y

CONFIG_PATA_PLATFORM=y
CONFIG_PATA_OF_PLATFORM=y
CONFIG_ATA_GENERIC=y


# CONFIG_EMBEDDED is not set
CONFIG_EARLY_PRINTK=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_RD_GZIP=y

CONFIG_BLK_DEV_LOOP=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y

CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IPV6=y
CONFIG_NETDEVICES=y
#CONFIG_NET_CORE=y
#CONFIG_NETCONSOLE=y
CONFIG_ETHERNET=y

-------------- next part --------------
A non-text attachment was scrubbed...
Name: qemu-aarch64.sh
Type: application/x-shellscript
Size: 186 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180329/cf2fb75c/attachment-0001.bin>
