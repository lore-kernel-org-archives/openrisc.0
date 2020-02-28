From: Vad Rulezz <vad@vr5.epicgamer.org>
Date: Fri, 28 Feb 2020 17:34:21 +0300
Subject: [OpenRISC] [PATCH] openrisc: fix syscalls table initialization
Message-ID: <47bb03c5-85bc-c8a2-6b16-c07ff692f174@vr5.epicgamer.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Some entries in syscalls table could be left uninitialized, this patch
fixes that.

Vad Rulezz

--- a/arch/openrisc/kernel/sys_call_table.c	2020-02-24 03:17:42.000000000 +0300
+++ b/arch/openrisc/kernel/sys_call_table.c	2020-02-28 17:08:57.990931846 +0300
@@ -20,5 +20,6 @@
  #define __SYSCALL(nr, call) [nr] = (call),

  void *sys_call_table[__NR_syscalls] = {
+	[0 ... __NR_syscalls-1] = &sys_ni_syscall,
  #include <asm/unistd.h>
  };
