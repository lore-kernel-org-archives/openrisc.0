From: BAndViG <bandvig@mail.ru>
Date: Sun, 21 Jan 2018 15:46:24 +0300
Subject: [OpenRISC] Linux4 does not boot on Atlys SoC
Message-ID: <AB8A0ACF1D594E2A874B40F24E1C27E9@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello all.
I'm trying to build and run Linux-4.x on SoC for FPGA (Digilent Atlys board 
in my case).
I build tool-chain by myself (no OpenADK or Buildroot were involved) step by 
step as described in OpenCores pages.
I use:
binutils - upstream from17-Dec-2017
uClibc-ng  - upstream from 27-Dec-2017
GCC-5.4.0-20170218 - from our github.com/openrisc/or1k-gcc repository
BusyBox -  upstream from 26-December-2017
Linux kernel and its headers - from Stafford's 
github.com/stffrdhrn/linux/tree/for-next .
The initramfs comes from Jonas' port of Linux-3.13 (I have copy of his 
openrisc.net repository) with replacement busybox and applet links. Linux 
kernel compiled without shadow GPRs support.

FPGA SoC is based on CAPPUCCINO pipeline. CPU operates on 50 MHz, so I 
edited arch/openrisc/boot/dts/or1ksim.dts to set clock-frequency to 50000000 
and increase memory size to 0x08000000.

Case #1. Mor1kx (CAPPUCCINO) is configured with  FEATURE_ATOMIC("ENABLED").
Linux boot  stalls just after "RPC: Registered tcp NFSv4.1 backchannel 
transport module." message. I suppose that next print should be "Serial: 
8250/16550 driver, 4 ports, IRQ sharing disabled" (as it was for 
Linux-3.13). After some time the following debug message appears:

swapper invoked oom-killer: gfp_mask=0x14000c0(GFP_KERNEL), nodemask=(null), 
order=0, oom_score_adj=0
CPU: 0 PID: 1 Comm: swapper Not tainted 
4.15.0-rc3-atlys-15055-g73acae67e363-dirty #19
Call trace:
[<(ptrval)>] 0xc0005bb0
[<(ptrval)>] 0xc02dd810
[<(ptrval)>] 0xc0099bec
[<(ptrval)>] 0xc009980c
[<(ptrval)>] 0xc009edb0
[<(ptrval)>] 0xc00d8fe4
[<(ptrval)>] 0xc00d92a4
[<(ptrval)>] 0xc00d9510
[<(ptrval)>] 0xc02e5f50
[<(ptrval)>] 0xc02e72d8
[<(ptrval)>] 0xc00b0dec
[<(ptrval)>] 0xc00b2468
[<(ptrval)>] 0xc0093ea8
[<(ptrval)>] ? 0xc0100b98
[<(ptrval)>] 0xc0097910
[<(ptrval)>] 0xc0097abc
[<(ptrval)>] 0xc00e13e4
[<(ptrval)>] ? 0xc0041b90
[<(ptrval)>] 0xc00e1694
[<(ptrval)>] 0xc00e1920
[<(ptrval)>] 0xc03cfd74
[<(ptrval)>] 0xc03cfe54
[<(ptrval)>] 0xc03cf9dc
[<(ptrval)>] 0xc03d07c0
[<(ptrval)>] ? 0xc03e5fe4
[<(ptrval)>] ? 0xc03d09f4
[<(ptrval)>] ? 0xc03ce290
[<(ptrval)>] 0xc03d0a24
[<(ptrval)>] ? 0xc03e6060
[<(ptrval)>] 0xc000422c
[<(ptrval)>] ? 0xc002a5fc
[<(ptrval)>] ? 0xc03ce290
[<(ptrval)>] 0xc03cee14
[<(ptrval)>] ? 0xc03ce290
[<(ptrval)>] ? 0xc02f7fa0
[<(ptrval)>] 0xc02f7fbc
[<(ptrval)>] ? 0xc00330b8
[<(ptrval)>] 0xc0007f80
Mem-Info:
active_anon:0 inactive_anon:0 isolated_anon:0
active_file:0 inactive_file:0 isolated_file:0
unevictable:0 dirty:0 writeback:0 unstable:0
slab_reclaimable:0 slab_unreclaimable:0
mapped:0 shmem:0 pagetables:0 bounce:0
free:176 free_pcp:4 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB 
unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB 
writeback:0kB shmem:0kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
Normal free:1408kB min:1408kB low:1760kB high:2112kB active_anon:0kB 
inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB 
writepending:0kB present:131072kB managed:124520kB mlocked:0kB 
kernel_stack:120kB pagetables:0kB bounce:0kB free_pcp:32kB local_pcp:32kB 
free_cma:0kB
lowmem_reserve[]: 0 0
Normal: 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB 
(U) 0*2048kB 0*4096kB 0*8192kB = 1408kB
0 total pagecache pages
16384 pages RAM
0 pages HighMem/MovableOnly
819 pages reserved
[ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj 
name
Kernel panic - not syncing: Out of memory and no killable processes...

---[ end Kernel panic - not syncing: Out of memory and no killable 
processes...

Case #2. Mor1kx is configured with FEATURE_ATOMIC("NONE").
Linux hangs up somewhere at the beginning, it even does not print initial 
message "Compiled-in FTD ...".

My hypothesizes:
1) Something wrong with UART driver initialization (from case #1)
2) Something wrong with atomic instructions implementation in CAPPUCCINO 
pipe (mostly from case #2, however it could be reason for case #1 too).

If I remember correctly it isn't possible to force simulation of atomic 
instructions at compile time in Linux-4.x. Instead, Linux-4.x should switch 
on such simulation by appropriate "instruction invalid" exception. However, 
it looks like the approach works in Stafford's development environment (I 
mean QEMU), but doesn't in HW- implemented pipe.

Is any idea which debug could be activated in kernel to speed up the problem 
fix? Or the only way is Verilator?

Was anybody successful with running Linux-4 on an FPGA SoC?

BR
Andrey Bacherov 

