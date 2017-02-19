From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Sun, 19 Feb 2017 11:49:23 -0600
Subject: [OpenRISC] Crosstool/kbuild-all toolchain updates
In-Reply-To: <20170219132637.gjv26w7w5sses2fi@wfg-t540p.sh.intel.com>
References: <20170131224438.GD21641@lianli.shorne-pla.net>
 <20170219132637.gjv26w7w5sses2fi@wfg-t540p.sh.intel.com>
Message-ID: <20170219174923.GI21840@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi!

On Sun, Feb 19, 2017 at 09:26:37PM +0800, Fengguang Wu wrote:
> An uptodate crosstool and reasonable active maintainer would be very
> welcome. I'll sure be a heavy user. In the past year when crosstool is
> not updated to gcc-6, we've resorted to using debian packages for some
> ARCHs and building our own cross compliers for the other ARCHs. The
> latter are based on Segher's buildall tools (CCed). The private builds
> may work for us in short term, however is obvious not a satisfactory
> solution.

Buildall supports GCC only, and this is not likely to change.

The primary usecase for buildall is for my own GCC testing.  All patches
are welcome, but I'm not likely to apply them if they make it harder to
use the tools for what their goal is.  I'm certainly not going to apply
patches to other trees from the scripts, etc.

Buildall itself is still maintained.  It does not get very many updates
but that is because it is close to perfect ;-)

On the other hand I'll be happy to help wherever I can.  Just Cc: me on
whatever comes up.


Segher
