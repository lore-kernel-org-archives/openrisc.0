From: Stafford Horne <shorne@gmail.com>
Date: Fri, 29 Jul 2016 22:46:10 +0900
Subject: [OpenRISC] or1ksim linux booting problem
In-Reply-To: <CAO0TxARPSp+FORiaqjtv5-q8O6Gz_4f1J1ZsZNJ8L=+-wT+AHg@mail.gmail.com>
References: <CAO0TxARPSp+FORiaqjtv5-q8O6Gz_4f1J1ZsZNJ8L=+-wT+AHg@mail.gmail.com>
Message-ID: <CAAfxs77PNOhdZ6R2qEDX2L983BOX4vCcPob0W+facCMZ3E9DsQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Vidya,

It seems that some of your document links are a bit old, but you did
get the kernel booting.  The problem is this message:

> Failed to execute /init (error -13)
> Starting init: /sbin/init exists but couldn't execute it (error -13)

This is saying that your kernel could not find init.  Since you are
using github.com/openrisc/linux and probably using the default kernel
config "or1ksim_defconfig" it should be packaging up the init for you.

Did you edit the default config at all?

Can you try booting one of my kernels here?
http://shorne.noip.me/uploads/vmlinux-shorne

Also, you can find the latest docs for building software things here:
 http://openrisc.io/software#baremetal-software

There is a newer linux build instruction, but the one you were using seems ok.
 https://github.com/openrisc/tutorials/blob/master/docs/Linux.md

On another note, There should be little need to use repo
https://github.com/openrisc/or1k-src, it has been replaced by
https://github.com/openrisc/binutils-gdb now.

-Stafford

On Fri, Jul 29, 2016 at 1:33 PM, Vidya Govindan <vidya.mazhur@gmail.com> wrote:
> Hi All,
>
> I'm trying to boot linux on or1ksim platform using  Ubuntu 14.04 32bit
> version host machine.
> I have followed the steps in this link
> http://electria.metropolia.fi/2013/12/linux-on-de0-nano-part-i-simulator/
> I'm able to proceed till the step of bulding linux.
> After that when I try to boot linux on or1ksim I get the Linux kernel panic
> error.
> My boot log is as below:
>
>> Seeding random generator with value 0x288d4ad3
>> Insn MMU 0KB: 1 ways, 64 sets, entry size 1 bytes
>> Data MMU 0KB: 1 ways, 64 sets, entry size 1 bytes
>> Ethernet TAP type
>> Warning: ./arch/openrisc/or1ksim.cfg: Unrecognized parameter: sockif at
>> line 714; ignored.
>> Verbose on, simdebug off, interactive prompt off
>> Machine initialization...
>> Clock cycle: 10ns
>> No data cache.
>> No instruction cache.
>> BPB simulation off.
>> BTIC simulation off.
>> Or1ksim 2012-04-27
>> Building automata... done, num uncovered: 0/215.
>> Parsing operands data... done.
>> Warning: Failed to set TAP device tap0: Operation not permitted
>> UART at 0x90000000
>> Resetting Tick Timer.
>> Resetting Power Management.
>> Resetting PIC.
>> Starting at 0x00000000
>> loadcode: filename vmlinux  startaddr=00000000  virtphy_transl=00000000
>> Not COFF file format
>> ELF type: 0x0002
>> ELF machine: 0x005c
>> ELF version: 0x00000001
>> ELF sec = 28
>> Section: .text, vaddr: 0xc0000000, paddr: 0x0 offset: 0x00002000, size:
>> 0x0029d5a0
>> Section: .rodata, vaddr: 0xc029e000, paddr: 0x29e000 offset: 0x002a0000,
>> size: 0x0002ef88
>> Section: .eh_frame, vaddr: 0xc02ccf88, paddr: 0x2ccf88 offset: 0x002cef88,
>> size: 0x00050e60
>> Section: __ksymtab, vaddr: 0xc031dde8, paddr: 0x31dde8 offset: 0x0031fde8,
>> size: 0x000045d0
>> Section: __ksymtab_gpl, vaddr: 0xc03223b8, paddr: 0x3223b8 offset:
>> 0x003243b8, size: 0x00002f90
>> Section: __ksymtab_strings, vaddr: 0xc0325348, paddr: 0x325348 offset:
>> 0x00327348, size: 0x0001049e
>> Section: __param, vaddr: 0xc03357e8, paddr: 0x3357e8 offset: 0x003377e8,
>> size: 0x000002f8
>> Section: .data, vaddr: 0xc0336000, paddr: 0x336000 offset: 0x00338000,
>> size: 0x00016380
>> Section: __ex_table, vaddr: 0xc034c380, paddr: 0x34c380 offset:
>> 0x0034e380, size: 0x00000ab0
>> Section: .notes, vaddr: 0xc034ce30, paddr: 0x34ce30 offset: 0x0034ee30,
>> size: 0x00000024
>> Section: .head.text, vaddr: 0xc034e000, paddr: 0x34e000 offset:
>> 0x00350000, size: 0x00004000
>> Section: .init.text, vaddr: 0xc0352000, paddr: 0x352000 offset:
>> 0x00354000, size: 0x00015428
>> Section: .init.data, vaddr: 0xc0367440, paddr: 0x367440 offset:
>> 0x00369440, size: 0x006e087c
>> WARNING: sim_init: Debug module not enabled, cannot start remote service
>> to GDB
>> ****************** counters reset ******************
>> cycles 110463, insn #88572
>> ****************** counters reset ******************
>> Compiled-in FDT at c0368420
>> Linux version 4.4.0-or1ksim (iot at iot-HCL-Desktop) (gcc version 4.9.2 (GCC)
>> ) #2 Thu Jul 28 19:47:49 IST 2016
>> CPU: OpenRISC-12 (revision 1) @20 MHz
>> -- dcache disabled
>> -- icache disabled
>> -- dmmu:   64 entries, 1 way(s)
>> -- immu:   64 entries, 1 way(s)
>> -- additional features:
>> -- power management
>> -- timer
>> setup_memory: Memory: 0x0-0x2000000
>> Reserved - 0x01fff23c-0x00000da2
>> Setting up paging and PTEs.
>> map_ram: Memory: 0x0-0x2000000
>> itlb_miss_handler c0002160
>> dtlb_miss_handler c0002000
>> OpenRISC Linux -- http://openrisc.net
>> Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4080
>> Kernel command line: console=uart,mmio,0x90000000,115200
>> earlycon: Early serial console at MMIO 0x90000000 (options '115200')
>> bootconsole [uart0] enabled
>> PID hash table entries: 128 (order: -4, 512 bytes)
>> Dentry cache hash table entries: 4096 (order: 1, 16384 bytes)
>> Inode-cache hash table entries: 2048 (order: 0, 8192 bytes)
>> Sorting __ex_table...
>> Memory: 21904K/32768K available (2677K kernel code, 91K rwdata, 608K
>> rodata, 7144K init, 85K bss, 10864K reserved, 0K cma-reserved)
>> mem_init_done ...........................................
>> NR_IRQS:32
>> clocksource: openrisc_timer: mask: 0xffffffff max_cycles: 0xffffffff,
>> max_idle_ns: 95563022313 ns
>> 40.00 BogoMIPS (lpj=200000)
>> pid_max: default: 32768 minimum: 301
>> Mount-cache hash table entries: 2048 (order: 0, 8192 bytes)
>> Mountpoint-cache hash table entries: 2048 (order: 0, 8192 bytes)
>> devtmpfs: initialized
>> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
>> max_idle_ns: 19112604462750000 ns
>> NET: Registered protocol family 16
>> clocksource: Switched to clocksource openrisc_timer
>> NET: Registered protocol family 2
>> TCP established hash table entries: 2048 (order: 0, 8192 bytes)
>> TCP bind hash table entries: 2048 (order: 0, 8192 bytes)
>> TCP: Hash tables configured (established 2048 bind 2048)
>> UDP hash table entries: 512 (order: 0, 8192 bytes)
>> UDP-Lite hash table entries: 512 (order: 0, 8192 bytes)
>> NET: Registered protocol family 1
>> RPC: Registered named UNIX socket transport module.
>> RPC: Registered udp transport module.
>> RPC: Registered tcp transport module.
>> RPC: Registered tcp NFSv4.1 backchannel transport module.
>> futex hash table entries: 256 (order: -2, 3072 bytes)
>> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>> 90000000.serial: ttyS0 at MMIO 0x90000000 (irq = 2, base_baud = 1250000)
>> is a 16550A
>> console [ttyS0] enabled
>> console [ttyS0] enabled
>> bootconsole [uart0] disabled
>> bootconsole [uart0] disabled
>> libphy: ethoc-mdio: probed
>> NET: Registered protocol family 17
>> Freeing unused kernel memory: 7144K (c034e000 - c0a48000)
>> Failed to execute /init (error -13)
>> Starting init: /sbin/init exists but couldn't execute it (error -13)
>> Starting init: /bin/sh exists but couldn't execute it (error -13)
>> Kernel panic - not syncing: No working init found.  Try passing init=
>> option to kernel. See Linux Documentation/init.txt for guidance.
>> ---[ end Kernel panic - not syncing: No working init found.  Try passing
>> init= option to kernel. See Linux Documentation/init.txt for guidance.
>
>
> I checked the linux documentation. Also I tried to work out solutions
> provided in this link http://opencores.org/forum,OpenRISC,0,4350 but could
> not find git://openrisc.net/jonas/bakiri/linux this repo. Instead I have
> used https://github.com/openrisc/linux repo.
>
> I'm new to OpenRISC and it would be great if someone could help me to run
> the linux successfully.
>
> Thanks & Regards,
> Vidya
>
>
>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>

