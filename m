From: Stafford Horne <shorne@gmail.com>
Date: Thu, 23 Feb 2017 22:35:15 +0900
Subject: [OpenRISC] Crosstool/kbuild-all toolchain updates
In-Reply-To: <20170219174923.GI21840@gate.crashing.org>
References: <20170131224438.GD21641@lianli.shorne-pla.net>
 <20170219132637.gjv26w7w5sses2fi@wfg-t540p.sh.intel.com>
 <20170219174923.GI21840@gate.crashing.org>
Message-ID: <20170223133515.GI2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Feb 19, 2017 at 11:49:23AM -0600, Segher Boessenkool wrote:
> Hi!
> 
> On Sun, Feb 19, 2017 at 09:26:37PM +0800, Fengguang Wu wrote:
> > An uptodate crosstool and reasonable active maintainer would be very
> > welcome. I'll sure be a heavy user. In the past year when crosstool is
> > not updated to gcc-6, we've resorted to using debian packages for some
> > ARCHs and building our own cross compliers for the other ARCHs. The
> > latter are based on Segher's buildall tools (CCed). The private builds
> > may work for us in short term, however is obvious not a satisfactory
> > solution.
> 
> Buildall supports GCC only, and this is not likely to change.

I think we are not requiring more at this moment.

My thought was to open up/modernize the crostool build system and store it
on git.kernel.org.  Currently Tony mentions [0] "They are built using a
modified version of the buildall scripts".  I am hoping we can get those
from him and..

  - Create a project kernel/git/{user}/crosstool.git
  - Store there
    * build script (wrapping buildall)
    * any patches needed i.e. or1k/gcc.patch
    * scripts for signing and uploading binaries to website
    * container config for setting up whole build in docker
       * i.e. something like masami's linux-cross [1]

The idea being that then when people want to update binaries they can
just send a patch.  The maintainer need just run the scripts.

Another question, does anyone use the 32-bit binaries anymore?

-Stafford

[0] https://www.kernel.org/pub/tools/crosstool/
[1] https://github.com/mhiramat/linux-cross/tree/master/linux-cross-build

> The primary usecase for buildall is for my own GCC testing.  All patches
> are welcome, but I'm not likely to apply them if they make it harder to
> use the tools for what their goal is.  I'm certainly not going to apply
> patches to other trees from the scripts, etc.
> 
> Buildall itself is still maintained.  It does not get very many updates
> but that is because it is close to perfect ;-)
> 
> On the other hand I'll be happy to help wherever I can.  Just Cc: me on
> whatever comes up.
> 
> 
> Segher
