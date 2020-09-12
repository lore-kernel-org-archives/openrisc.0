From: Stafford Horne <shorne@gmail.com>
Date: Sat, 12 Sep 2020 17:42:55 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC fixes for v5.9-rc4
Message-ID: <20200912084255.GR3562056@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull.

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to d877322bc1adcab9850732275670409e8bcca4c4:

  openrisc: Fix issue with get_user for 64-bit values (2020-09-12 17:26:00 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.9-rc4

Fixes for compile issues pointed out by kbuild and one bug I found in
interd with the 5.9 patches.

----------------------------------------------------------------
Stafford Horne (3):
      openrisc: Reserve memblock for initrd
      openrisc: Fix cache API compile issue when not inlining
      openrisc: Fix issue with get_user for 64-bit values

 arch/openrisc/include/asm/uaccess.h | 33 +++++++++++++++++++++------------
 arch/openrisc/kernel/setup.c        | 10 ++++++++++
 arch/openrisc/mm/cache.c            |  2 +-
 3 files changed, 32 insertions(+), 13 deletions(-)
