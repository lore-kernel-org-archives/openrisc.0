From: Stafford Horne <shorne@gmail.com>
Date: Wed, 1 Feb 2017 07:44:38 +0900
Subject: [OpenRISC] Crosstool/kbuild-all toolchain updates
Message-ID: <20170131224438.GD21641@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Fengguang/All,

I am working as the OpenRISC linux kernel maintainer.  Currently in
linux-next our patches are causing kbuild test robot to fail.

This is because the patches are taking advantage of 2 'new' (2 year old)
instrucions (l.swa/l.lwa) and the build robots, as far as I can tell,
use the 'make.cross' [0] build script from lkp-tests.git.  These point
to the crosstools [1] toolchains maintained by Tony.

I sent a mail to Tony who maintains the crosstools but I didn't get a
reply and it seems he is not longer working on them [1].

I think our options are:

  1. Update 'make.cross' to point somewhere else for openrisc
  2. Update and maintain crosstools

For 1. its trvial but, maybe not the best solution.

For 2. I created new crosstool builds for openrisc [3]. The way the
crosstools are maintained is via a patches.tar file and it seem a custom
buildall script.  I dont see the source for that custom script anywhere.

I am thinking I could help to update and 'opensource' the crosstool
build scripts to make it easier for everyone to update toolchains by
sending patches.

But, I would need access to crosstool on kernel.org and an OK from
everyone.

Any opinions? Questions?

-Stafford

[0] https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/tree/sbin/make.cross
[1] https://www.kernel.org/pub/tools/crosstool/
[2] https://marc.info/?l=linux-kernel&m=146406282809809&w=1
[3] http://shorne.noip.me/crosstool/files/
