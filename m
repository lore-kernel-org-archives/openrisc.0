From: Stafford Horne <shorne@gmail.com>
Date: Wed, 25 Jan 2017 21:34:30 +0900
Subject: [OpenRISC] [Qemu-devel] [PATCH] target-openrisc: Fix exception
 handling status registers
In-Reply-To: <01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
References: <20170113215720.29598-1-shorne@gmail.com>
 <20170113220252.GE25986@lianli.shorne-pla.net>
 <CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
 <20170114080435.GF25986@lianli.shorne-pla.net>
 <20170120163918.GD7836@lianli.shorne-pla.net>
 <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
 <20170124102625.GF7836@lianli.shorne-pla.net>
 <01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
Message-ID: <20170125123430.GG7836@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jan 24, 2017 at 10:32:03AM -0800, Richard Henderson wrote:
> On 01/24/2017 02:26 AM, Stafford Horne wrote:
> > If you are having problems booting, both mainline (4.10-rc5) and
> > linux-next (i.e. next-201701124) should be able to boot. i.e.
> > 
> >   export ARCH=openrisc
> >   make defconfig   # defconfig works fine on qemu
> > 
> >   # make any updates to CONFIG_CROSS_COMPILE needed
> >   make
> > 
> >   # start qemu
> >   qemu-system-or32  -cpu or1200 -M or32-sim -kernel $LINUX/vmlinux \
> >    -serial stdio -nographic -monitor none
> > 
> > I just ran those commands with linu-next and my qemu patches and the
> > kernel can boot, but note fails to find init due to config missing
> > initramfs, which I figure you know thats expected.
> > 
> > Let me know what you tried and what problem you are having.
> 
> I've tried booting linux-next and mainline, both from yesterday.
> 
> According to the trace from qemu (-D z -d in_asm,exec), I execute
> 
> ./or32-softmmu/qemu-system-or32 -cpu or1200 -M or32-sim \
>     -kernel ~/work/linux/bld-or/vmlinux -append console=ttyS0 \
>     -serial stdio -nographic -monitor none \
>     -D z -d in_asm,exec,int,op_opt
> 
> ...
> Trace 0x7f501130a880 [0: c036c650] setup_cpuinfo
> Trace 0x7f501130a990 [0: c036c65c] setup_cpuinfo
> Trace 0x7f501130aaa0 [0: c0069774] panic
> ...
> Trace 0x7f5011312b70 [0: 000001fc]
> Trace 0x7f5011312b70 [0: 000001fc]
> 
> That last block repeats forever.
> 
> The qemu I'm using is
> 
>   git://github.com/rth7680/qemu.git tgt-or1k-2
> 
> which has your patch, l.lwa/swa, and a cleanup to the disassembly trace.
> 
> Looking at the kernel source I would hazard a guess that it's
> 
> >         cpu = of_find_compatible_node(NULL, NULL, "opencores,or1200-rtlsvn481");
> >         if (!cpu)
> >                 panic("No compatible CPU found in device tree...\n");
> 
> which suggests some large configuration error.

Hmm, I just tried your qemu branch and mine:

  git at github.com:stffrdhrn/qemu.git or1k-fix-sigill

Both of them were able to boot fine.

The opencores,or1200-rtlsvn481 cpu node is in the or1ksim device tree
definition.  Are you sure your kernel config has this in it?

  CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"

Could you send your kernel config?

I have attached mine, just in case.  For next-20170124

-Stafford
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.or1k-next-20170124.gz
Type: application/gzip
Size: 7343 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170125/0fea0c3a/attachment.bin>
