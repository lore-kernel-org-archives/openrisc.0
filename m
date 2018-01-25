From: Tobias Klauser <tklauser@distanz.ch>
Date: Thu, 25 Jan 2018 10:58:50 +0100
Subject: [OpenRISC] [PATCH] openrisc: remove unused __ARCH_HAVE_MMU define
Message-ID: <1516874330-31440-1-git-send-email-tklauser@distanz.ch>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The __ARCH_HAVE_MMU define is (and was) used nowhere in the tree and
also doesn't appear to be used by any libc.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/openrisc/include/uapi/asm/unistd.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index 9a3ee389631e..11c5a58ab333 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -17,8 +17,6 @@
  * (at your option) any later version.
  */
 
-#define __ARCH_HAVE_MMU
-
 #define sys_mmap2 sys_mmap_pgoff
 
 #define __ARCH_WANT_RENAMEAT
-- 
2.13.0

