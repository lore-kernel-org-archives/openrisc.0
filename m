From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Nov 2021 12:16:39 +0900
Subject: [OpenRISC] [PATCH v2 13/13] Documentation for OpenRISC port
In-Reply-To: <20211113031639.2402161-1-shorne@gmail.com>
References: <20211113031639.2402161-1-shorne@gmail.com>
Message-ID: <20211113031639.2402161-14-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

OpenRISC architecture specification:

 https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf

Currently the port as of the 2021-10-16 rebasing has the following test
failures:

 FAIL: timezone/tst-tzset     # Not enough space to create 4GiB file

Writing credits for the port are:

 Stafford Horne  <shorne@gmail.com>
 Christian Svensson  <blue@cmd.nu>
---
 NEWS   | 2 ++
 README | 1 +
 2 files changed, 3 insertions(+)

diff --git a/NEWS b/NEWS
index f10971b180..e8d88a7934 100644
--- a/NEWS
+++ b/NEWS
@@ -481,6 +481,8 @@ Major new features:
   The latest GCC available at this time (10.2) does not support this level of
   fortification.
 
+* Support for OpenRISC on Linux has been added.
+
 Deprecated and removed features, and other changes affecting compatibility:
 
 * The mallinfo function is marked deprecated.  Callers should call
diff --git a/README b/README
index d0f0edb393..3d5a78ccff 100644
--- a/README
+++ b/README
@@ -35,6 +35,7 @@ The GNU C Library supports these configurations for using Linux kernels:
 	microblaze*-*-linux-gnu
 	mips-*-linux-gnu
 	mips64-*-linux-gnu
+	or1k-*-linux-gnu
 	powerpc-*-linux-gnu	Hardware or software floating point, BE only.
 	powerpc64*-*-linux-gnu	Big-endian and little-endian.
 	s390-*-linux-gnu
-- 
2.31.1

