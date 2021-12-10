From: Stafford Horne <shorne@gmail.com>
Date: Sat, 11 Dec 2021 08:34:54 +0900
Subject: [OpenRISC] [PATCH v3 11/13] or1k: Build Infrastructure
In-Reply-To: <20211210233456.4146479-1-shorne@gmail.com>
References: <20211210233456.4146479-1-shorne@gmail.com>
Message-ID: <20211210233456.4146479-12-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Here we define the minumum linux kernel version at 5.4.0, as that is the
long term support version where 32-bit architectures start to support
64-bit time API's.  The OpenRISC kernel had some bugs up until version 5.8
which caused issues with glibc fork/clone, they have been backported to
5.4 but not previous versions.
---
 sysdeps/or1k/Implies                        |  3 ++
 sysdeps/or1k/Makefile                       |  7 +++++
 sysdeps/or1k/nofpu/Implies                  |  1 +
 sysdeps/or1k/nptl/Makefile                  | 21 +++++++++++++
 sysdeps/or1k/preconfigure                   | 34 +++++++++++++++++++++
 sysdeps/unix/sysv/linux/or1k/Implies        |  3 ++
 sysdeps/unix/sysv/linux/or1k/Makefile       | 12 ++++++++
 sysdeps/unix/sysv/linux/or1k/configure      |  4 +++
 sysdeps/unix/sysv/linux/or1k/configure.ac   |  4 +++
 sysdeps/unix/sysv/linux/or1k/shlib-versions |  2 ++
 10 files changed, 91 insertions(+)
 create mode 100644 sysdeps/or1k/Implies
 create mode 100644 sysdeps/or1k/Makefile
 create mode 100644 sysdeps/or1k/nofpu/Implies
 create mode 100644 sysdeps/or1k/nptl/Makefile
 create mode 100644 sysdeps/or1k/preconfigure
 create mode 100644 sysdeps/unix/sysv/linux/or1k/Implies
 create mode 100644 sysdeps/unix/sysv/linux/or1k/Makefile
 create mode 100644 sysdeps/unix/sysv/linux/or1k/configure
 create mode 100644 sysdeps/unix/sysv/linux/or1k/configure.ac
 create mode 100644 sysdeps/unix/sysv/linux/or1k/shlib-versions

diff --git a/sysdeps/or1k/Implies b/sysdeps/or1k/Implies
new file mode 100644
index 0000000000..387a0ca052
--- /dev/null
+++ b/sysdeps/or1k/Implies
@@ -0,0 +1,3 @@
+wordsize-32
+ieee754/dbl-64
+ieee754/flt-32
diff --git a/sysdeps/or1k/Makefile b/sysdeps/or1k/Makefile
new file mode 100644
index 0000000000..0241a0587e
--- /dev/null
+++ b/sysdeps/or1k/Makefile
@@ -0,0 +1,7 @@
+ASFLAGS-.os += -fPIC
+
+ifeq ($(subdir),elf)
+# Extra shared linker files to link only into dl-allobjs.so.
+sysdep-rtld-routines += dl-start
+endif
+
diff --git a/sysdeps/or1k/nofpu/Implies b/sysdeps/or1k/nofpu/Implies
new file mode 100644
index 0000000000..abcbadb25f
--- /dev/null
+++ b/sysdeps/or1k/nofpu/Implies
@@ -0,0 +1 @@
+ieee754/soft-fp
diff --git a/sysdeps/or1k/nptl/Makefile b/sysdeps/or1k/nptl/Makefile
new file mode 100644
index 0000000000..0e08821933
--- /dev/null
+++ b/sysdeps/or1k/nptl/Makefile
@@ -0,0 +1,21 @@
+# Copyright (C) 2021 Free Software Foundation, Inc.
+#
+# This file is part of the GNU C Library.
+#
+# The GNU C Library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# The GNU C Library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with the GNU C Library.  If not, see
+# <https://www.gnu.org/licenses/>.
+
+ifeq ($(subdir),csu)
+gen-as-const-headers += tcb-offsets.sym
+endif
diff --git a/sysdeps/or1k/preconfigure b/sysdeps/or1k/preconfigure
new file mode 100644
index 0000000000..d1b1fb1843
--- /dev/null
+++ b/sysdeps/or1k/preconfigure
@@ -0,0 +1,34 @@
+#
+# This is free and unencumbered software released into the public domain.
+#
+# Anyone is free to copy, modify, publish, use, compile, sell, or
+# distribute this software, either in source code form or as a compiled
+# binary, for any purpose, commercial or non-commercial, and by any
+# means.
+#
+# In jurisdictions that recognize copyright laws, the author or authors
+# of this software dedicate any and all copyright interest in the
+# software to the public domain. We make this dedication for the benefit
+# of the public at large and to the detriment of our heirs and
+# successors. We intend this dedication to be an overt act of
+# relinquishment in perpetuity of all present and future rights to this
+# software under copyright law.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+
+case "$machine" in
+or1k*)
+  base_machine=or1k
+  machine=or1k
+
+  with_fp_cond="defined __or1k_hard_float__"
+  ;;
+esac
+
diff --git a/sysdeps/unix/sysv/linux/or1k/Implies b/sysdeps/unix/sysv/linux/or1k/Implies
new file mode 100644
index 0000000000..f39f16c04a
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/Implies
@@ -0,0 +1,3 @@
+or1k/nptl
+unix/sysv/linux/generic/wordsize-32
+unix/sysv/linux/generic
diff --git a/sysdeps/unix/sysv/linux/or1k/Makefile b/sysdeps/unix/sysv/linux/or1k/Makefile
new file mode 100644
index 0000000000..be20320b2f
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/Makefile
@@ -0,0 +1,12 @@
+ifeq ($(subdir),misc)
+  sysdep_routines += prctl or1k_clone
+endif
+
+ifeq ($(subdir),stdlib)
+gen-as-const-headers += ucontext_i.sym
+endif
+
+# pull in __syscall_error routine
+libpthread-routines += sysdep
+librt-routines += sysdep
+
diff --git a/sysdeps/unix/sysv/linux/or1k/configure b/sysdeps/unix/sysv/linux/or1k/configure
new file mode 100644
index 0000000000..5225dfea5b
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/configure
@@ -0,0 +1,4 @@
+# This file is generated from configure.ac by Autoconf.  DO NOT EDIT!
+ # Local configure fragment for sysdeps/unix/sysv/linux/or1k.
+
+arch_minimum_kernel=5.4.0
diff --git a/sysdeps/unix/sysv/linux/or1k/configure.ac b/sysdeps/unix/sysv/linux/or1k/configure.ac
new file mode 100644
index 0000000000..6274c4fb02
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/configure.ac
@@ -0,0 +1,4 @@
+GLIBC_PROVIDES dnl See aclocal.m4 in the top level source directory.
+# Local configure fragment for sysdeps/unix/sysv/linux/or1k.
+
+arch_minimum_kernel=5.4.0
diff --git a/sysdeps/unix/sysv/linux/or1k/shlib-versions b/sysdeps/unix/sysv/linux/or1k/shlib-versions
new file mode 100644
index 0000000000..159653b5c4
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/shlib-versions
@@ -0,0 +1,2 @@
+DEFAULT                 GLIBC_2.35
+ld=ld-linux-or1k.so.1
-- 
2.31.1

