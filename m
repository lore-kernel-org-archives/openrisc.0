From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 31 Mar 2022 10:43:35 +0200
Subject: [OpenRISC] drivers/pci/proc.c:150:17: sparse: sparse:
 restricted __le16 degrades to integer
In-Reply-To: <202203281004.InhLOFxn-lkp@intel.com>
References: <202203281004.InhLOFxn-lkp@intel.com>
Message-ID: <CAK8P3a0ShMf+QCHWishO9DbvRrJ5x9f=9cS9kwm_tkBqwyWtEw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Mar 28, 2022 at 5:04 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f82da161ea75dc4db21b2499e4b1facd36dab275
> commit: a97b693c3712f040c5802f32b2d685352e08cefa uaccess: fix nios2 and microblaze get_user_8()
> date:   4 weeks ago
> config: microblaze-randconfig-s032-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281004.InhLOFxn-lkp at intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a97b693c3712f040c5802f32b2d685352e08cefa
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a97b693c3712f040c5802f32b2d685352e08cefa
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/pci/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/pci/proc.c:150:17: sparse: sparse: restricted __le16 degrades to integer
> >> drivers/pci/proc.c:150:17: sparse: sparse: restricted __le16 degrades to integer
>    drivers/pci/proc.c:150:17: sparse: sparse: cast to restricted __le16
> >> drivers/pci/proc.c:159:17: sparse: sparse: restricted __le32 degrades to integer
> >> drivers/pci/proc.c:159:17: sparse: sparse: restricted __le32 degrades to integer
>    drivers/pci/proc.c:159:17: sparse: sparse: cast to restricted __le32
>    drivers/pci/proc.c:168:17: sparse: sparse: restricted __le16 degrades to integer
>    drivers/pci/proc.c:168:17: sparse: sparse: restricted __le16 degrades to integer
>    drivers/pci/proc.c:168:17: sparse: sparse: cast to restricted __le16

On Tue, Mar 29, 2022 at 8:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Looks like new uaccess code doesn't handle sparse __bitwise annotations.

Right. I copied the line that caused this from 32-bit riscv, which has the same
issue, same on openrisc after d877322bc1ad ("openrisc: Fix issue with
get_user for
64-bit values").

It sounds like we should fix all three of these the same way, any
suggestion which
architecture to copy from?

       Arnd
