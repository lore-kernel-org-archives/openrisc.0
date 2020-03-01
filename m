From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Mar 2020 06:38:50 +0900
Subject: [OpenRISC] [PATCH v2 2/3] openrisc: Enable the clone3 syscall
In-Reply-To: <20200301213851.8096-1-shorne@gmail.com>
References: <20200301213851.8096-1-shorne@gmail.com>
Message-ID: <20200301213851.8096-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Enable the clone3 syscall for OpenRISC.  We use the generic version.

This was tested with the clone3 test from selftests.  Note, for all
tests to pass it required enabling CONFIG_NAMESPACES which is not
enabled in the default OpenRISC kernel config.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/openrisc/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index 566f8c4f8047..fae34c60fa88 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -24,6 +24,7 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
-- 
2.21.0

