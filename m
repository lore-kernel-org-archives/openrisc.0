From: Stafford Horne <shorne@gmail.com>
Date: Wed, 29 Dec 2021 13:42:40 +0900
Subject: [OpenRISC] [PATCH v4 02/13] linux/syscalls: Add or1k_atomic syscall
 for OpenRISC
In-Reply-To: <20211229044251.2203653-1-shorne@gmail.com>
References: <20211229044251.2203653-1-shorne@gmail.com>
Message-ID: <20211229044251.2203653-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>
---
 sysdeps/unix/sysv/linux/syscall-names.list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sysdeps/unix/sysv/linux/syscall-names.list b/sysdeps/unix/sysv/linux/syscall-names.list
index 1a74d090b7..a72dee6275 100644
--- a/sysdeps/unix/sysv/linux/syscall-names.list
+++ b/sysdeps/unix/sysv/linux/syscall-names.list
@@ -304,6 +304,7 @@ open_by_handle_at
 open_tree
 openat
 openat2
+or1k_atomic
 osf_adjtime
 osf_afs_syscall
 osf_alt_plock
-- 
2.31.1

