From: Stafford Horne <shorne@gmail.com>
Date: Fri, 27 Jan 2017 00:20:29 +0900
Subject: [OpenRISC] OpenRISC toolchain updates for crosstool
Message-ID: <20170126152029.GB21641@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Tony,

I am working as the OpenRISC linux kernel maintainer.  Currently in
linux-next a few patches are taking advantage of new (2 year old)
instrucions (l.swa/l.lwa).

The current toolchains most 0day and kbuild scripts use are the
great crosstools that you are maintaining.  Since they are a bit dated
many builds are failing.

I have updated the patches.tar.gz and posted my changes here:

  http://shorne.noip.me/crosstool/files/

You should be familiar with the file layout.  I have put an example
toolchian build as well there. Note, openrisc no longer needs patches
for binutils as everything is upstream. Also the name has changed from
or32- to or1k-.

Could you use my changes to update crosstool for openrisc to 5.4.0?

Let me know if you have any questions.

-Stafford
