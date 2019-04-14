From: Basel Sayeh <basel.sayeh@hotmail.com>
Date: Sun, 14 Apr 2019 14:46:59 +0000
Subject: [OpenRISC] cannot boot linux
Message-ID: <AM5PR0801MB16336F56C18491748C786E25FE2A0@AM5PR0801MB1633.eurprd08.prod.outlook.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello

I tried to boot linux via mor1kx cpu built via fusesoc for a qmtech Cyclone IV board
https://github.com/baselsayeh/qmtech_ep4ce15-multicore

Every time the kernel jumps to or32_early_setup, the cpu throws bus errors and jumps to 0x200

Here is gdb output just before the error
https://pastebin.com/U5izVPG9

How i can investigate this?
Thanks
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190414/a93daa28/attachment.html>
