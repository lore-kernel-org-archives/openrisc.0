From: Stafford Horne <shorne@gmail.com>
Date: Wed, 20 May 2020 05:37:49 +0900
Subject: [OpenRISC] [PATCH 4/5] or1k: Add note to indicate execstack
In-Reply-To: <20200519203750.401593-1-shorne@gmail.com>
References: <20200519203750.401593-1-shorne@gmail.com>
Message-ID: <20200519203750.401593-5-shorne@gmail.com>
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
index 21cef067dda..8693e884e2a 100644
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

