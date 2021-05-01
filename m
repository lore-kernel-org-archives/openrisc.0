From: Stafford Horne <shorne@gmail.com>
Date: Sun,  2 May 2021 06:11:45 +0900
Subject: [OpenRISC] [PATCH v2 2/2] or1k: Use cmodel=large when building
 crtstuff
In-Reply-To: <20210501211145.2980164-1-shorne@gmail.com>
References: <20210501211145.2980164-1-shorne@gmail.com>
Message-ID: <20210501211145.2980164-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

When linking gcc runtime objects into large binaries the link may fail
with the below errors.  This will happen even if we are building with
-mcmodel=large.

    /home/shorne/work/openrisc/output/host/lib/gcc/or1k-buildroot-linux-uclibc/10.3.0/crtbeginS.o: in function `deregister_tm_clones':
    crtstuff.c:(.text+0x3c): relocation truncated to fit: R_OR1K_GOT16 against undefined symbol `_ITM_deregisterTMCloneTable'
    /home/shorne/work/openrisc/output/host/lib/gcc/or1k-buildroot-linux-uclibc/10.3.0/crtbeginS.o: in function `register_tm_clones':
    crtstuff.c:(.text+0xc0): relocation truncated to fit: R_OR1K_GOT16 against undefined symbol `_ITM_registerTMCloneTable'

This patch builds the gcc crtstuff binaries always with the
-mcmodel=large option to ensure they can be linked into large binaries.

libgcc/ChangeLog:

	PR 99783
	* config.host (or1k-*, tmake_file): Add or1k/t-crtstuff.
	* config/or1k/t-crtstuff: New file.
---
 libgcc/config.host            | 4 ++--
 libgcc/config/or1k/t-crtstuff | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 libgcc/config/or1k/t-crtstuff

diff --git a/libgcc/config.host b/libgcc/config.host
index f808b61be70..9e40d4560a3 100644
--- a/libgcc/config.host
+++ b/libgcc/config.host
@@ -1119,12 +1119,12 @@ nios2-*-*)
 	extra_parts="$extra_parts crti.o crtn.o"
 	;;
 or1k-*-linux*)
-	tmake_file="$tmake_file or1k/t-or1k"
+	tmake_file="$tmake_file or1k/t-or1k or1k/t-crtstuff"
 	tmake_file="$tmake_file t-softfp-sfdf t-softfp"
 	md_unwind_header=or1k/linux-unwind.h
 	;;
 or1k-*-*)
-	tmake_file="$tmake_file or1k/t-or1k"
+	tmake_file="$tmake_file or1k/t-or1k or1k/t-crtstuff"
 	tmake_file="$tmake_file t-softfp-sfdf t-softfp"
 	;;
 pdp11-*-*)
diff --git a/libgcc/config/or1k/t-crtstuff b/libgcc/config/or1k/t-crtstuff
new file mode 100644
index 00000000000..dcae7f3498e
--- /dev/null
+++ b/libgcc/config/or1k/t-crtstuff
@@ -0,0 +1,2 @@
+# Compile crtbeginS.o and crtendS.o with -mcmodel=large
+CRTSTUFF_T_CFLAGS_S += -mcmodel=large
-- 
2.26.2

