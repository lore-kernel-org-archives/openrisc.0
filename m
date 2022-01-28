From: Stafford Horne <shorne@gmail.com>
Date: Sat, 29 Jan 2022 08:28:42 +0900
Subject: [OpenRISC] [PATCH] or1k: Define PI_STATIC_AND_HIDDEN
Message-ID: <20220128232842.3329969-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

PI_STATIC_AND_HIDDEN means that references to static functions, data
and symbols with hidden visibility do not need any run-time relocations
after the final link, with the build flags used by glibc.

OpenRISC follows this so enabled PI_STATIC_AND_HIDDEN by adding
configure.ac and generating configure.

Suggested-by: Florian Weimer <fweimer@redhat.com>
---
This was discussed on the mailing list:
  https://sourceware.org/pipermail/libc-alpha/2022-January/135620.html

I thought to get this out as I start to test 2.35 we want this change in.

 sysdeps/or1k/configure    | 5 +++++
 sysdeps/or1k/configure.ac | 4 ++++
 2 files changed, 9 insertions(+)
 create mode 100644 sysdeps/or1k/configure
 create mode 100644 sysdeps/or1k/configure.ac

diff --git a/sysdeps/or1k/configure b/sysdeps/or1k/configure
new file mode 100644
index 0000000000..d73db4ddbe
--- /dev/null
+++ b/sysdeps/or1k/configure
@@ -0,0 +1,5 @@
+# This file is generated from configure.ac by Autoconf.  DO NOT EDIT!
+ # Local configure fragment for sysdeps/or1k/elf.
+
+$as_echo "#define PI_STATIC_AND_HIDDEN 1" >>confdefs.h
+
diff --git a/sysdeps/or1k/configure.ac b/sysdeps/or1k/configure.ac
new file mode 100644
index 0000000000..db6a6087e1
--- /dev/null
+++ b/sysdeps/or1k/configure.ac
@@ -0,0 +1,4 @@
+GLIBC_PROVIDES dnl See aclocal.m4 in the top level source directory.
+# Local configure fragment for sysdeps/or1k/elf.
+
+AC_DEFINE(PI_STATIC_AND_HIDDEN)
-- 
2.31.1

