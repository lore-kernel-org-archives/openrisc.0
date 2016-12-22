From: Stafford Horne <shorne@gmail.com>
Date: Fri, 23 Dec 2016 01:14:02 +0900
Subject: [OpenRISC] [PATCH v3 3/3] Add gdb for or1k build
In-Reply-To: <cover.1482413820.git.shorne@gmail.com>
References: <cover.1482413820.git.shorne@gmail.com>
Message-ID: <77bb840b75c98ab7e81e71d36e1549b19964ffb7.1482413820.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Wallentowitz <stefan@wallentowitz.de>

* ChangeLog:

	* configure.ac: remove logic adding gdb to noconfigsdirs for or1k
	* configure: regenerate
---
 configure    | 7 -------
 configure.ac | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/configure b/configure
index f6d12b8..d3862d2 100755
--- a/configure
+++ b/configure
@@ -3729,10 +3729,6 @@ case "${target}" in
     ;;
   *-*-rtems*)
     noconfigdirs="$noconfigdirs target-libgloss"
-    # this is not caught below because this stanza matches earlier
-    case $target in
-      or1k*-*-*) noconfigdirs="$noconfigdirs gdb" ;;
-    esac
     ;;
     # The tpf target doesn't support gdb yet.
   *-*-tpf*)
@@ -3940,9 +3936,6 @@ case "${target}" in
   nvptx*-*-*)
     noconfigdirs="$noconfigdirs target-libssp target-libstdc++-v3 target-libobjc"
     ;;
-  or1k*-*-*)
-    noconfigdirs="$noconfigdirs gdb"
-    ;;
   sh-*-* | sh64-*-*)
     case "${target}" in
       sh*-*-elf)
diff --git a/configure.ac b/configure.ac
index 3ec86c1..a3a914d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1065,10 +1065,6 @@ case "${target}" in
     ;;
   *-*-rtems*)
     noconfigdirs="$noconfigdirs target-libgloss"
-    # this is not caught below because this stanza matches earlier
-    case $target in
-      or1k*-*-*) noconfigdirs="$noconfigdirs gdb" ;;
-    esac
     ;;
     # The tpf target doesn't support gdb yet.
   *-*-tpf*)
@@ -1276,9 +1272,6 @@ case "${target}" in
   nvptx*-*-*)
     noconfigdirs="$noconfigdirs target-libssp target-libstdc++-v3 target-libobjc"
     ;;
-  or1k*-*-*)
-    noconfigdirs="$noconfigdirs gdb"
-    ;;
   sh-*-* | sh64-*-*)
     case "${target}" in
       sh*-*-elf)
-- 
2.7.4


