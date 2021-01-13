From: Stafford Horne <shorne@gmail.com>
Date: Thu, 14 Jan 2021 08:50:31 +0900
Subject: [OpenRISC] [PATCH v2 4/5] or1k: Add note to indicate execstack
In-Reply-To: <20210113235032.2821155-1-shorne@gmail.com>
References: <20210113235032.2821155-1-shorne@gmail.com>
Message-ID: <20210113235032.2821155-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Define TARGET_ASM_FILE_END as file_end_indicate_exec_stack to allow
generation of the ".note.GNU-stack" section note.  This allows binutils
to properly set PT_GNU_STACK in the program header.

This fixes a glibc execstack testsuite test failure found while working
on the OpenRISC glibc port.

gcc/ChangeLog:

	* config/or1k/linux.h (TARGET_ASM_FILE_END): Define macro.
---
 gcc/config/or1k/linux.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gcc/config/or1k/linux.h b/gcc/config/or1k/linux.h
index 74fbe082103..196f3f3c8f0 100644
--- a/gcc/config/or1k/linux.h
+++ b/gcc/config/or1k/linux.h
@@ -42,4 +42,6 @@
      %{!shared:-dynamic-linker " GNU_USER_DYNAMIC_LINKER "}}} \
    %{static-pie:-Bstatic -pie --no-dynamic-linker -z text}"
 
+#define TARGET_ASM_FILE_END file_end_indicate_exec_stack
+
 #endif /* GCC_OR1K_LINUX_H */
-- 
2.26.2

