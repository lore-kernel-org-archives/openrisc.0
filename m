From: Manaar Alam <alam.manaar@gmail.com>
Date: Sat, 20 Aug 2016 23:03:09 +0530
Subject: [OpenRISC] Difficulties on Setting up a mor1kx development
Message-ID: <CAFoY_wzsML45neoNXPbAHVrk5vUJq3Nm4+pw1ZieAexDA33Biw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

I am trying to load LINUX in the de0_nano board via telnet I am facing core
dumped error given as -





*Info : JTAG tap: or1k.cpu tap/device found: 0x020f30dd (mfg: 0x06e, part:
0x20f3, ver: 0x0)Error: or1k_assert_reset: implement meError:
or1k_deassert_reset: implement meopenocd: driver.c:191:
interface_jtag_add_dr_scan: Assertion `field == out_fields +
scan->num_fields' failed.Aborted (core dumped)*

The linux image is working properly in the simulator.
Can you help me out to sort out this error?

*Manaar Alam,*
Junior Research Fellow,
Department of Computer Science and Engineering,
Indian Institute of Technology, Kharagpur,
West Bengal, India.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160820/ab1649ed/attachment.html>
