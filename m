From: Prudhvi Gali <pgali@asu.edu>
Date: Tue, 14 Aug 2018 16:55:56 -0700
Subject: [OpenRISC] Issue while loading vmlinux-de0_nano
Message-ID: <CAA8cPamyw3=Lyi5-UJgo9MUc9a+5k73O_KFmRU3NoCGYmHyd2g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello

I am new to Openrisc.

I am trying to load mor1k in to de0_nano and boot that with the precompiled
vmlinux-de0_nano.I am using openocd to load it using telnet connection.

When I try using the below command

*halt; load_image /path-to/vmlinux-de0_nano; reset*

*CRC ERROR! match bit after write is 0 (computed CRC 0x2b7d8fa9)*
*CRC ERROR! match bit after write is 0 (computed CRC 0x2b7d8fa9)*
*CRC ERROR! match bit after write is 0 (computed CRC 0x2b7d8fa9)*

What could probably go wrong?

Regards
Prudhvi Gali
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180814/5bf1cf56/attachment.html>
