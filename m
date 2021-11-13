From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Nov 2021 12:16:28 +0900
Subject: [OpenRISC] [PATCH v2 02/13] linux/syscalls: Add or1k_atomic syscall
 for OpenRISC
In-Reply-To: <20211113031639.2402161-1-shorne@gmail.com>
References: <20211113031639.2402161-1-shorne@gmail.com>
Message-ID: <20211113031639.2402161-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

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

