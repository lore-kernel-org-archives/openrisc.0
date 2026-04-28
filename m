Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ACD3EB7FB;
	Tue, 28 Apr 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391377; cv=none; b=jEbXmaDYAXiZHZY7Ny6GsBzCfNP68/eBfQY5+lEuFMHkFhFbo9f+ty+xB3Ltxk3hIATBVLrFOfDVxJQXAM3Dpl5hXZahpCbwarwvQxIKMiCTABLmY4+iJAMuYkoW8iXZsUzXBhaQG52K4jr+TrqOgTe+MGJDvD8KQgtItSnhcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391377; c=relaxed/simple;
	bh=ffW+3VThKzbY4mJ0QimkJobQsxjovGtgsqfbkfoyqr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aPCJJO7JknH1OHDt1BCz7oZcTi5QjjQJDgKdTy145SBO22fmJrFbm7W2Ydk/qtlkxdV0XkCn0fu+LNxBXKd+a5JAALNzcQoqhADuOOs7s06PhKP9uaujkrqll1BIus+3YWhcrk4Qf0woZTVpHtnenFc5o0wMACsAQLSnvN0wRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Z077LvoZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Z077LvoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777391372;
	bh=ffW+3VThKzbY4mJ0QimkJobQsxjovGtgsqfbkfoyqr8=;
	h=From:Date:Subject:To:Cc:From;
	b=Z077LvoZAcLsIn4kpEWfWhtJ04NUbjHU/2jKb8RytFUa+s51y5AAOHkf0bu6ual0P
	 mBzzNbn0AgMva8M/UzH6tNFJKmGGpnq9Va4v13zOF6Cv0EBEK5kEu/XsUNra7+7lQa
	 PLFpM15ybxTfj0jvIG5XZuH5GBeYfd0zYzkRsYY8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Apr 2026 17:48:51 +0200
Subject: [PATCH] tools/nolibc: add support for OpenRISC / or1k
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-nolibc-openrisc-v1-1-33b399054af6@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrA04ogW9inSRTMc6IknIaClI7
 t5Yl2/x/wnKSVhhrE5I/BGV4AuwroAW699s5FUMbdM+mg5748MmjkyI7JMoGYvWDUgdztxDqWL
 iWb7/4/S8rYdbmfZrAzn/ADq8rRRzAAAA
X-Change-ID: 20260415-nolibc-openrisc-a1ab91c41fe5
To: Willy Tarreau <w@1wt.eu>, Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777391371; l=14455;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ffW+3VThKzbY4mJ0QimkJobQsxjovGtgsqfbkfoyqr8=;
 b=2/kHjG8axV1W/itduGYV6sWhd6+DTtrhVXb0t5t4gG9zHBwGraVHSwnOKnkg0dlFS6Ofh93+v
 bxOZUCFp9dRDpA1WNB4R2bVeTx7FzMKH8LchC8K+LXKvM79qr43T4qt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for OpenRISC / or1k to nolibc.

_start() uses the same wrapper construct as in arch-sh.h.
libgcc is necessary as OpenRISC is missing 64-bit multiplication.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile                  |   2 +-
 tools/include/nolibc/arch-openrisc.h           | 176 +++++++++++++++++++++++++
 tools/include/nolibc/arch.h                    |   2 +
 tools/testing/selftests/nolibc/Makefile.nolibc |   5 +
 tools/testing/selftests/nolibc/run-tests.sh    |   4 +-
 5 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 872c318f50d4..2cb4d610fe53 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -17,7 +17,7 @@ endif
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
 
-architectures := arm arm64 loongarch m68k mips powerpc riscv s390 sh sparc x86
+architectures := arm arm64 loongarch m68k mips openrisc powerpc riscv s390 sh sparc x86
 arch_files := arch.h $(addsuffix .h, $(addprefix arch-, $(architectures)))
 all_files := \
 		alloca.h \
diff --git a/tools/include/nolibc/arch-openrisc.h b/tools/include/nolibc/arch-openrisc.h
new file mode 100644
index 000000000000..de2df1715504
--- /dev/null
+++ b/tools/include/nolibc/arch-openrisc.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * openrisc specific definitions for NOLIBC
+ * Copyright (C) 2026 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_ARCH_OPENRISC_H
+#define _NOLIBC_ARCH_OPENRISC_H
+
+#include "compiler.h"
+#include "crt.h"
+
+/*
+ * Syscalls for SuperH:
+ *   - syscall number is passed in r11
+ *   - arguments are in r3, r4, r5, r6, r7, r8
+ *   - the system call is performed by calling l.sys 1
+ *   - syscall return value is in r11
+ */
+
+#define _NOLIBC_SYSCALL_CLOBBERLIST \
+	"r12", "r13", "r15", "r17", "r19", "r21", "r23", "r25", "r27", "r29", "r31", "memory"
+
+#define __nolibc_syscall0(num)                                                \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _ret __asm__ ("r11");                                   \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		"l.nop\n"                                                     \
+		: "=r"(_ret)                                                  \
+		: "r"(_num)                                                   \
+		: "r3", "r4", "r5", "r6", "r7", "r8",                         \
+		  _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define __nolibc_syscall1(num, arg1)                                          \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _ret __asm__ ("r11");                                   \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		"l.nop\n"                                                     \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1)                                       \
+		: "r4", "r5", "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST   \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define __nolibc_syscall2(num, arg1, arg2)                                    \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _ret __asm__ ("r11");                                   \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		"l.nop\n"                                                     \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2)                           \
+		: "r5", "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST         \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define __nolibc_syscall3(num, arg1, arg2, arg3)                              \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _ret __asm__ ("r11");                                   \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		"l.nop\n"                                                     \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3)               \
+		: "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST               \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define __nolibc_syscall4(num, arg1, arg2, arg3, arg4)                        \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _ret __asm__ ("r11");                                   \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r6") = (long)(arg4);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		"l.nop\n"                                                     \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)   \
+		: "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST                     \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define __nolibc_syscall5(num, arg1, arg2, arg3, arg4, arg5)                  \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _ret __asm__ ("r11");                                   \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r6") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r7") = (long)(arg5);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		"l.nop\n"                                                     \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),  \
+		  "r"(_arg5)                                                  \
+		: "r8", _NOLIBC_SYSCALL_CLOBBERLIST                           \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define __nolibc_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)            \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _ret __asm__ ("r11");                                   \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r6") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r7") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("r8") = (long)(arg6);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		"l.nop\n"                                                     \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),  \
+		  "r"(_arg5), "r"(_arg6)                                      \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#ifndef NOLIBC_NO_RUNTIME
+/* startup code */
+void _start_wrapper(void);
+void __attribute__((weak,noreturn))
+__nolibc_entrypoint __nolibc_no_stack_protector
+_start_wrapper(void)
+{
+	__asm__ volatile (
+		".global _start\n"           /* The C function will have a prologue,         */
+		".type _start, @function\n"  /* corrupting "sp"                              */
+		".weak _start\n"
+		"_start:\n"
+
+		"l.or r3,sp,sp\n"            /* save stack pointer to 3, as arg1 of _start_c */
+		"l.jal _start_c\n"           /* transfer to c runtime                        */
+		"l.nop\n"
+
+		".size _start, .-_start\n"
+	);
+	__nolibc_entrypoint_epilogue();
+}
+#endif /* NOLIBC_NO_RUNTIME */
+
+#endif /* _NOLIBC_ARCH_OPENRISC_H */
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index a3adaf433f2c..55009dcafe9e 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -28,6 +28,8 @@
 #include "arch-m68k.h"
 #elif defined(__sh__)
 #include "arch-sh.h"
+#elif defined(__or1k__)
+#include "arch-openrisc.h"
 #else
 #error Unsupported Architecture
 #endif
diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index f30bc68470cc..91f5a284f4e6 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -92,6 +92,7 @@ IMAGE_sparc32    = arch/sparc/boot/image
 IMAGE_sparc64    = arch/sparc/boot/image
 IMAGE_m68k       = vmlinux
 IMAGE_sh4        = arch/sh/boot/zImage
+IMAGE_openrisc   = vmlinux
 IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
@@ -121,6 +122,7 @@ DEFCONFIG_sparc32    = sparc32_defconfig
 DEFCONFIG_sparc64    = sparc64_defconfig
 DEFCONFIG_m68k       = virt_defconfig
 DEFCONFIG_sh4        = rts7751r2dplus_defconfig
+DEFCONFIG_openrisc   = virt_defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
 EXTRACONFIG_x32       = -e CONFIG_X86_X32_ABI
@@ -159,6 +161,7 @@ QEMU_ARCH_sparc32    = sparc
 QEMU_ARCH_sparc64    = sparc64
 QEMU_ARCH_m68k       = m68k
 QEMU_ARCH_sh4        = sh4
+QEMU_ARCH_openrisc   = or1k
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 QEMU_ARCH_USER_ppc64le = ppc64le
@@ -199,6 +202,7 @@ QEMU_ARGS_sparc32    = -M SS-5 -m 256M -append "console=ttyS0,115200 panic=-1 $(
 QEMU_ARGS_sparc64    = -M sun4u -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_m68k       = -M virt -append "console=ttyGF0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_sh4        = -M r2d -serial file:/dev/stdout -append "console=ttySC1,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_openrisc   = -M virt -m 512M -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
@@ -233,6 +237,7 @@ CFLAGS_XARCH = $(CFLAGS_$(XARCH))
 endif
 
 LDLIBS_ppc = $(if $(LLVM),,-lgcc)
+LDLIBS_openrisc = $(if $(LLVM),,-lgcc)
 LDLIBS = $(LDLIBS_$(XARCH))
 
 include Makefile.include
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index cd439096fdf3..c25ee4be2df4 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -21,6 +21,7 @@ all_archs=(
 	i386 x86_64 x32
 	arm64 arm armthumb
 	mips32le mips32be mipsn32le mipsn32be mips64le mips64be
+	openrisc
 	ppc ppc64 ppc64le
 	riscv32 riscv64
 	s390x
@@ -107,6 +108,7 @@ crosstool_arch() {
 	case "$1" in
 	arm64) echo aarch64;;
 	armthumb) echo arm;;
+	openrisc) echo or1k;;
 	ppc) echo powerpc;;
 	ppc64) echo powerpc64;;
 	ppc64le) echo powerpc64;;
@@ -185,7 +187,7 @@ test_arch() {
 			exit 1
 	esac
 	printf '%-15s' "$arch:"
-	if [ "$arch" = "m68k" -o "$arch" = "sh4" ] && [ "$llvm" = "1" ]; then
+	if [ "$arch" = "m68k" -o "$arch" = "sh4" -o "$arch" = "openrisc" ] && [ "$llvm" = "1" ]; then
 		echo "Unsupported configuration"
 		return
 	fi

---
base-commit: 8bf37d924968cf26ab95f644c981a28086e372af
change-id: 20260415-nolibc-openrisc-a1ab91c41fe5

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

