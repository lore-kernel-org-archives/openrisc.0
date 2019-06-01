From: Stafford Horne <shorne@gmail.com>
Date: Sat,  1 Jun 2019 16:26:29 +0900
Subject: [OpenRISC] [PATCH 2/2] gen-doc: Updates for latest cpu definitions
In-Reply-To: <20190601072629.4070-1-shorne@gmail.com>
References: <20190601072629.4070-1-shorne@gmail.com>
Message-ID: <20190601072629.4070-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Doc generation was no longer working due to several issues.

 - openrisc.cpu no longer exists (its not cpu/or1k.cpu in binutils-gdb)
 - Relavive paths for archfile no longer work due to wrong cwd.
 - Many architectures have been added and removed.

I have be able to get this working and added all the architectures I
could get working with the below changes. I have posted the results
here:

  http://shorne.noip.me/downloads/gen-doc/

ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* gen-all-doc (archs): Add new archs and update locations.
	(archfile): Prepend cgendir.
	(index.html gen): Change name openrisc to or1k.
	* html.scm (gen-html-trailer): Change redhat.com to
	sourceware.org.
---
 gen-all-doc | 46 ++++++++++++++++++++++++++++++++--------------
 html.scm    |  2 +-
 2 files changed, 33 insertions(+), 15 deletions(-)
 mode change 100644 => 100755 gen-all-doc

diff --git a/gen-all-doc b/gen-all-doc
old mode 100644
new mode 100755
index e2a49b6..5db3200
--- a/gen-all-doc
+++ b/gen-all-doc
@@ -18,7 +18,7 @@
 # <http://www.gnu.org/licenses/>.
 #
 
-# Run this script in the src/cgen directory.
+# Run this script in the binutils-gdb/cgen directory.
 
 # Exit on any error.
 set -e
@@ -26,28 +26,46 @@ set -e
 # For debugging.
 set -x
 
-# ??? Some are missing, need to add them after some research.
-#../cpu/m32c.cpu
-#../cpu/xc16x.cpu
+# ??? Broken archs not in list, grouped by error
+# h-prefixreg error
+#../cpu/cris.cpu
+# Error: unexpected operand: #f
+# ../cpu/m32c.cpu
+# ../cpu/xc16x.cpu
+# cpu/ia32.cpu
+# sh64-compact.cpu:316:3: Error: Instruction has opcode bits outside of its mask
+# ../cpu/sh.cpu
+# ia64.cpu:924:invalid argument to %sym: (if (eq? (string-length "") 0) "" ".")
+# ../cpu/ia64.cpu
+# sparc.cpu:389:1: define-hardware: hardware already defined: h-gr
+# cpu/sparc.cpu
+
+# Archs in parent directly should be from the binutils-gdb project. Others are
+# hosted here in cgen.
+
 archs="
-cpu/fr30.cpu
-cpu/arm.cpu
+../cpu/epiphany.cpu
+../cpu/fr30.cpu
 ../cpu/frv.cpu
-cpu/i960.cpu
-cpu/ip2k.cpu
+../cpu/ip2k.cpu
 ../cpu/iq2000.cpu
 ../cpu/lm32.cpu
 ../cpu/m32r.cpu
-cpu/mep.cpu
+../cpu/mep.cpu
 ../cpu/mt.cpu
-cpu/openrisc.cpu
+../cpu/or1k.cpu
+../cpu/xstormy16.cpu
+cpu/arm.cpu
+cpu/i960.cpu
+cpu/m68k.cpu
+cpu/play.cpu
+cpu/powerpc.cpu
 cpu/sh.cpu
-cpu/xstormy16.cpu
 "
 
 if [ ! -f sim.scm ]
 then
-    echo "Not in the src/cgen directory." >& 2
+    echo "Not in the cgen source directory." >& 2
     exit 1
 fi
 
@@ -66,7 +84,7 @@ export cgendir=`pwd`
 
   for a in $archs
   do
-    archfile=../$a
+    archfile=$cgendir/$a
     arch=$(basename $archfile .cpu)
 
     case $arch in
@@ -129,7 +147,7 @@ EOF
     arm-thumb.*) name="ARM Thumb" ;;
     frv-1.*) name="FRV FR400" ;;
     frv-2.*) name="FRV FR500" ;;
-    openrisc.*) name="Openrisc" ;;
+    or1k.*) name="OpenRISC" ;;
     xstormy16.*) name="Xstormy16" ;;
     *) name=`echo ${html/.html} | tr $lower $upper` ;;
     esac
diff --git a/html.scm b/html.scm
index 3d6bb4a..0a57a73 100644
--- a/html.scm
+++ b/html.scm
@@ -111,7 +111,7 @@ See the input .cpu file(s) for copyright information.
    "This documentation was machine generated from the cgen cpu description\n"
    "files for this architecture.\n"
    "<br>\n"
-   "<a href=\"http://sources.redhat.com/cgen/\">http://sources.redhat.com/cgen/</a>\n"
+   "<a href=\"https://sourceware.org/cgen/\">https://sourceware.org/cgen/</a>\n"
    "</body>\n"
    "</html>\n"
    )
-- 
2.21.0

