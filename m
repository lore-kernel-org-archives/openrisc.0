Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E5377EDD;
	Wed, 29 Apr 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476060; cv=none; b=KTDltuLHtmN9NuFV7ScDX0dV8ba2R+tks10Veg02MSbbE6M5z/fFh83aqUhTTmpqb8KhsYEkAtpYVdHd+Jk5V9CaAQxwpmJn+bFclQC/2pSurl62VcyA21yOeNq+aR0Zj+ATBE18QMiJsk4pyBVw8thEvtHIPFTiQEwGS2Dw0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476060; c=relaxed/simple;
	bh=5YHDyoKfepxGA177YHbFKRFumgjEQ0JvgrvMBMlHaSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VdBc5egu3SeDpN6PtGfrsRIATsaaGsrw2UJOB5rEHrEdPddyaNqkHxVfljmA1u11xaSWWXO1zrb3U5mZDtXGe906UohpNMBysevdR5IQaQKH0alOJQJ7e4L6xar7cwYKt4AbFLqaEOeXpfVpnF6XCroiiSbsrcaR4fJ7AgW3l0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Mpwio60F; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Mpwio60F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777476052;
	bh=5YHDyoKfepxGA177YHbFKRFumgjEQ0JvgrvMBMlHaSU=;
	h=From:Date:Subject:To:Cc:From;
	b=Mpwio60Fov17FKo+mkmi7WU02uH0J5FCvaCmcdKrZSKfzSy4cHkLlQiCW90QnV+dx
	 bgiAblqUeB3ansDLUGDQiX0jzecE8jyIdJPRnIWBJiIzgj315UHJkYOLzkQgjtDhEq
	 ws+vdPEq1le6fNanfk+DKHTO6zsZq+BryizhgLv4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Apr 2026 17:20:45 +0200
Subject: [PATCH v2] tools/nolibc: add support for OpenRISC / or1k
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-nolibc-openrisc-v2-1-8d7d7a2f3fec@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNyw6CMBBFf8XM2hqmPCKu/A/Doq2DHWNa0gHUE
 P5dQHcuT3LuuRMIJSaB026CRCMLx7CA3u/AeRNupPi6MOhMV1mBpQrxwdap2FFILE4ZNLZGV2B
 LJSyrLlHLr614ab4sg72T69fManiWPqb3djni6v3q+vhXH1GhynOb13VWFqatzk9iEXF+8IdAP
 TTzPH8AAyc3nMUAAAA=
X-Change-ID: 20260415-nolibc-openrisc-a1ab91c41fe5
To: Willy Tarreau <w@1wt.eu>, Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777476052; l=13731;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5YHDyoKfepxGA177YHbFKRFumgjEQ0JvgrvMBMlHaSU=;
 b=rBOQrDSb6zh0MC4cweY6+ot1Df+5FWcAdK3ar9gFy7y1jsZHwOGKpaFIryXILTY54F9AjeCxI
 7uzT3lnOo70AcPHuKg0fBCbxTYyFVN5W92wbPKe4SPZJiT1JfcN5cYT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for OpenRISC / or1k to nolibc.

_start() uses the same wrapper construct as in arch-sh.h.
libgcc is necessary as OpenRISC is missing 64-bit multiplication.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Drop useless l.nop from __nolibc_syscallX().
- Use the delay slot after l.jal _start_c.
- Fix some typos.
- Use a single register variable for system call number and return.
- Use 'r1' register name over non-idiomatic 'sp' alias.
- Link to v1: https://patch.msgid.link/20260428-nolibc-openrisc-v1-1-33b399054af6@weissschuh.net
---
 tools/include/nolibc/Makefile                  |   2 +-
 tools/include/nolibc/arch-openrisc.h           | 160 +++++++++++++++++++++++++
 tools/include/nolibc/arch.h                    |   2 +
 tools/testing/selftests/nolibc/Makefile.nolibc |   5 +
 tools/testing/selftests/nolibc/run-tests.sh    |   4 +-
 5 files changed, 171 insertions(+), 2 deletions(-)

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
index 000000000000..5ef82fd9cc64
--- /dev/null
+++ b/tools/include/nolibc/arch-openrisc.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * OpenRISC specific definitions for NOLIBC
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
+ * Syscalls for OpenRISC:
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
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		: "+r"(_num)                                                  \
+		:                                                             \
+		: "r3", "r4", "r5", "r6", "r7", "r8",                         \
+		  _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_num;                                                                 \
+})
+
+#define __nolibc_syscall1(num, arg1)                                          \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		: "+r"(_num)                                                  \
+		: "r"(_arg1)                                                  \
+		: "r4", "r5", "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST   \
+	);                                                                    \
+	_num;                                                                 \
+})
+
+#define __nolibc_syscall2(num, arg1, arg2)                                    \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		: "+r"(_num)                                                  \
+		: "r"(_arg1), "r"(_arg2)                                      \
+		: "r5", "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST         \
+	);                                                                    \
+	_num;                                                                 \
+})
+
+#define __nolibc_syscall3(num, arg1, arg2, arg3)                              \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		: "+r"(_num)                                                  \
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3)                          \
+		: "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST               \
+	);                                                                    \
+	_num;                                                                 \
+})
+
+#define __nolibc_syscall4(num, arg1, arg2, arg3, arg4)                        \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r6") = (long)(arg4);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		: "+r"(_num)                                                  \
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)              \
+		: "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST                     \
+	);                                                                    \
+	_num;                                                                 \
+})
+
+#define __nolibc_syscall5(num, arg1, arg2, arg3, arg4, arg5)                  \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r6") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r7") = (long)(arg5);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		: "+r"(_num)                                                  \
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)  \
+		: "r8", _NOLIBC_SYSCALL_CLOBBERLIST                           \
+	);                                                                    \
+	_num;                                                                 \
+})
+
+#define __nolibc_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)            \
+({                                                                            \
+	register long _num __asm__ ("r11") = (num);                           \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r6") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r7") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("r8") = (long)(arg6);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"l.sys 1\n"                                                   \
+		: "+r"(_num)                                                  \
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
+		  "r"(_arg6)                                                  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_num;                                                                 \
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
+		".type _start, @function\n"  /* corrupting "sp/r1"                           */
+		".weak _start\n"
+		"_start:\n"
+
+		"l.jal _start_c\n"           /* transfer to c runtime                        */
+		"l.or r3,r1,r1\n"            /* save stack pointer to r3, as arg1 of _start_c */
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

