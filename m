From: Stafford Horne <shorne@gmail.com>
Date: Fri, 16 Mar 2018 10:46:50 +0900
Subject: [OpenRISC] or1200 processor on FPGA -questions
In-Reply-To: <tencent_32C83F04F34592B625AD152DD2EAEDACC008@qq.com>
References: <tencent_32C83F04F34592B625AD152DD2EAEDACC008@qq.com>
Message-ID: <CAAfxs778OxM3vTiwviAYF2P3vpddbqFy6Ziu7dMRP+jWR81Vdg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi zhengfei,

Sorry for late reply.  The toolchain you are using looks pretty old.  What
I use for debugging is openocd(upstream) and gdb(upstream).

Sorry I'm not able to understand the cause of the errors you posted.

You can find the steps I put together here to debug using openocd and a new
version of gdb.  It should work with xilinx boards.

https://github.com/openrisc/tutorials/blob/master/docs/Debugging.md

If you need a new toolchain get one here

https://openrisc.io/2017/02/18/gccreleaseandbins

I need to create binaries for gdb. You will need to build your own, look
here.

https://openrisc.io/newlib/building.html

Hope it helps,

-Stafford

On Mar 12, 2018 5:01 PM, "马正飞" <2272714300@qq.com> wrote:

> Dear shorne
>       I'm using the or1200 processor on FPGA right now, but I've had a lot
> of problems, and it's been bothering me for a long time. Listen to my
> friend, you're an expert in this field. So I hope you can spend a little
> time to help me see the problem. Thank you very much!
>       The problem is focused on the loading board, when I send the data
> (orpmon/vmlinux) to the board. Please, see below for my detailed logs of
> the questions.Thanks!
>
> *1.The first question*
>   There are many reading errors here, although it is best to be ready for
> the JTAG chain at the end
> ------------------------------------------------------------
> -------------------------------------
>   openrisc at openrisc-VirtualBox:~/BSD$ sudo adv_jtag_bridge -b
> /home/openrisc/BSD xpc_usb
> [sudo] password for openrisc:
> Found Xilinx Platform Cable USB (DLC9)
> Found Xilinx Platform Cable USB (DLC9)
> XPC USB driver opening cable
> firmware version = 0x0517 (1303)
> cable CPLD version = 0x0012 (18)
> Enumerating JTAG chain...
>
> Devices on JTAG chain:
> Index Name ID Code IR Length
> ----------------------------------------------------------------
> 0:  XC5VLX110T  0xA2AD6093  10
> 1:  XCCACE  0x0A001093  8
> 2:  xc95144xl  0x59608093  8
> 3:  XCF32P  0xF5059093  16
> 4:  XCF32P  0xF5059093  16
>
> Target device 0, JTAG ID = 0xa2ad6093
> Xilinx IDCODE, assuming internal BSCAN mode
> (using USER1 instead of DEBUG TAP command)
> IDCODE sanity test passed, chain OK!
> JSP server listening on host openrisc-VirtualBox (0.0.0.0), port 9944,
> address family IPv4
> JSP server thread running!
> Burst read timed out.
> Retry count exceeded in burst read!
> *ERROR reading DCR 0 at startup! 'max retries'*
> *Burst read timed out.*
> Retry count exceeded in burst read!
> ERROR reading DCR 1 at startup! 'max retries'
> Burst read timed out.
> Retry count exceeded in burst read!
> ERROR reading DCR 2 at startup! 'max retries'
> Burst read timed out.
> Retry count exceeded in burst read!
> ERROR reading DCR 3 at startup! 'max retries'
> Burst read timed out.
> Retry count exceeded in burst read!
> ERROR reading DCR 4 at startup! 'max retries'
> Burst read timed out.
> Retry count exceeded in burst read!
> *ERROR reading DCR 5 at startup! 'max retries'*
> *Burst read timed out.*
> Retry count exceeded in burst read!
> ERROR reading DCR 6 at startup! 'max retries'
> Burst read timed out.
> Retry count exceeded in burst read!
> ERROR reading DCR 7 at startup! 'max retries'
> No watchpoint hardware found, HWP server not starting
> *JTAG bridge ready!*
> ------------------------------------------------------------
> ----------------------------------------------------
> *2.The second question*
>     And,the JTAG was exited the connection when I executed this command.
> ------------------------------------------------------------
> -----------------------
> openrisc at openrisc-VirtualBox:~$ *or32-elf-gdb*
> Building automata... done, num uncovered: 0/216.
> Parsing operands data... done.
> GNU gdb (OpenRISC 32-bit toolchain for or32-elf (built 20111014))
> 7.2-or32-1.0rc3
> Copyright (C) 2010 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.
> html>;
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "--host=i686-pc-linux-gnu --target=or32-elf".
> For bug reporting instructions, please see:
> <http://www.opencores.org/>;.
> (gdb) target remote:9999
> *Remote debugging using :9999*
> *Remote communication error.  Target disconnected.: Connection reset by
> peer.*
> (gdb)
> ------------------------------------------------------------
> -----------------------------
>
> Burst read timed out.
> Retry count exceeded in burst read!
> CRC ERROR! match bit after write is 0 (computed CRC 0x174b23f1)Retry count
> exceeded!  Abort!
>
> openrisc at openrisc-VirtualBox:~/BSD$
> ------------------------------------------------------------
> --------------------------------------------
> *3.The third question*
>     Neither the CPU nor the sdram detected it at the time of self-testing
> ------------------------------------------------------------
> -----------------------------------------------
> openrisc at openrisc-VirtualBox:~/BSD$ sudo adv_jtag_bridge -b
> /home/openrisc/BSD -t xpc_usb
> Found Xilinx Platform Cable USB (DLC9)
> Found Xilinx Platform Cable USB (DLC9)
> XPC USB driver opening cable
> firmware version = 0x0517 (1303)
> cable CPLD version = 0x0012 (18)
> Enumerating JTAG chain...
>
> Devices on JTAG chain:
> Index Name ID Code IR Length
> ----------------------------------------------------------------
> 0:  XC5VLX110T  0xA2AD6093  10
> 1:  XCCACE  0x0A001093  8
> 2:  xc95144xl  0x59608093  8
> 3:  XCF32P  0xF5059093  16
> 4:  XCF32P  0xF5059093  16
>
> Target device 0, JTAG ID = 0xa2ad6093
> Xilinx IDCODE, assuming internal BSCAN mode
> (using USER1 instead of DEBUG TAP command)
> IDCODE sanity test passed, chain OK!
> *** Doing self-test ***
> *Stall or1k - or1k is not stalled!*
> Self-test FAILED *** Bailing out!
> openrisc at openrisc-VirtualBox:~/BSD$
> ------------------------------------------------------------
> --------------------------------------------
> Thank you very much for your help,
> Zengfeima
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180316/b119c408/attachment-0001.html>
