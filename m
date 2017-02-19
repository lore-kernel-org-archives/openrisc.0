From: Fengguang Wu <fengguang.wu@intel.com>
Date: Sun, 19 Feb 2017 21:26:37 +0800
Subject: [OpenRISC] Crosstool/kbuild-all toolchain updates
In-Reply-To: <20170131224438.GD21641@lianli.shorne-pla.net>
References: <20170131224438.GD21641@lianli.shorne-pla.net>
Message-ID: <20170219132637.gjv26w7w5sses2fi@wfg-t540p.sh.intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Wed, Feb 01, 2017 at 07:44:38AM +0900, Stafford Horne wrote:
>Hi Fengguang/All,
>
>I am working as the OpenRISC linux kernel maintainer.  Currently in
>linux-next our patches are causing kbuild test robot to fail.
>
>This is because the patches are taking advantage of 2 'new' (2 year old)
>instrucions (l.swa/l.lwa) and the build robots, as far as I can tell,
>use the 'make.cross' [0] build script from lkp-tests.git.  These point
>to the crosstools [1] toolchains maintained by Tony.
>
>I sent a mail to Tony who maintains the crosstools but I didn't get a
>reply and it seems he is not longer working on them [1].
>
>I think our options are:
>
>  1. Update 'make.cross' to point somewhere else for openrisc
>  2. Update and maintain crosstools
>
>For 1. its trvial but, maybe not the best solution.

It's a valuable patch, thank you!

>For 2. I created new crosstool builds for openrisc [3]. The way the
>crosstools are maintained is via a patches.tar file and it seem a custom
>buildall script.  I dont see the source for that custom script anywhere.
>
>I am thinking I could help to update and 'opensource' the crosstool
>build scripts to make it easier for everyone to update toolchains by
>sending patches.
>
>But, I would need access to crosstool on kernel.org and an OK from
>everyone.
>
>Any opinions? Questions?

An uptodate crosstool and reasonable active maintainer would be very
welcome. I'll sure be a heavy user. In the past year when crosstool is
not updated to gcc-6, we've resorted to using debian packages for some
ARCHs and building our own cross compliers for the other ARCHs. The
latter are based on Segher's buildall tools (CCed). The private builds
may work for us in short term, however is obvious not a satisfactory
solution.

Thanks,
Fengguang
