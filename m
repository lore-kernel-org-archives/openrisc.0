From: Stafford Horne <shorne@gmail.com>
Date: Wed, 13 Sep 2017 06:22:52 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC patches for 4.14
Message-ID: <20170912212252.GS2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Linus

Please consider for pull

The following changes since commit 569dbb88e80deb68974ef6fdd6a13edb9d686261:

  Linux 4.13 (2017-09-03 13:56:17 -0700)

are available in the git repository at:

  https://github.com/openrisc/linux.git tags/openrisc-for-linus

for you to fetch changes up to 56ce2f25ab0d8830d914e626bc88e45b42e11661:

  openrisc: add forward declaration for struct vm_area_struct (2017-09-11 07:22:05 +0900)

----------------------------------------------------------------
OpenRISC patches for 4.14

Just one thing here:
 - Fix warning for upcoming work to remove linux/vmalloc.h from
   asm-generic/io.h

----------------------------------------------------------------
Tobias Klauser (1):
      openrisc: add forward declaration for struct vm_area_struct

 arch/openrisc/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

