From: Stafford Horne <shorne@gmail.com>
Date: Sun, 27 Nov 2016 15:16:46 +0900
Subject: [OpenRISC] [PATCH v2 4/4] Add gdb for or1k build
In-Reply-To: <cover.1480216015.git.shorne@gmail.com>
References: <cover.1480216015.git.shorne@gmail.com>
Message-ID: <39744680f87251a083460fc29de7dafdf5fe6a77.1480216015.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Wallentowitz <stefan@wallentowitz.de>

* ChangeLog:

	* configure.ac: Remove logic adding gdb to noconfigsdirs for or1k.
	* configure: Regenerate.
---
 configure    | 7 -------
 configure.ac | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/configure b/configure
index a5f4fc5..0a23491 100755
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
index a27985c..ddaab5a 100644
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


