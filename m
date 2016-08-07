From: Vidya Govindan <vidya.mazhur@gmail.com>
Date: Sun, 7 Aug 2016 19:01:41 +0530
Subject: [OpenRISC] Linux on DE0-Nano Board- Fusesoc build problem
Message-ID: <CAO0TxAQOW1zpzyag=A68UuU9OEssymCiUNR882TG6F+0=JgORw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello All,

I'm trying to build an sof file for DE0Nano board using which I want to run
linux on openrisc platform synthesized on Cyclone IV board.
So far I have been able simulate linux using or1ksim.
I decided to move on to the board and tried the steps mentioned in
https://github.com/kdgwill/OR1K/wiki/OpenRisc-tools-Install
I'm stuck at the make phase of fusesoc where I get the following error:

*make: *** No rule to make target `bin/fusesoc', needed by `out/fusesoc'.
Stop.*

As I tried to find out  why I get the error and how I can solve it, I came
upon lot of other things which basically confused me more. So I have
following queries if possible someone can please clarify:

1.I understand Fusesoc is the latest version of orpsocv3. Is my
understanding correct?
2. I have to build Fusesoc and orpsoc cores separately. So once I have
installed the Fusesoc framework described in here
https://github.com/kdgwill/OR1K/wiki/OpenRisc-tools-Install , I have to use
either
http://www.rs-online.com/designspark/electronics/eng/blog/booting-linux-on-a-de0-nano-with-orpsoc
or
http://web.archive.org/web/20140625095048/http://opencores.org/or1k/ORCONF2013_Workshop_ORPSoC_On_DE0_Nano
instructions both of which do not talk about Fusesoc (may be because it was
recently named?)
Am I going correct here?
3. How can I can build Fusesoc successfully and run linux on OpenRISC
platform using DE0Nano? Any leads would be greatly appreciated.

PS: Please pardon me if any of my queries are stupid.

Thanks & Regards,
Vidya
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160807/ff39144e/attachment.html>
