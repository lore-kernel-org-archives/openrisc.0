From: Stafford Horne <shorne@gmail.com>
Date: Mon, 29 May 2017 23:48:26 +0900
Subject: [OpenRISC] [PATCH v7 4/4] Add gdb for or1k build
In-Reply-To: <cover.1496068645.git.shorne@gmail.com>
References: <cover.1496068645.git.shorne@gmail.com>
Message-ID: <9f7c01d33d453186963b6b13f0f1ef4394b4e98b.1496068645.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

* ChangeLog:

2017-02-12  Stafford Horne  <shorne@gmail.com>

	* configure.ac: Remove logic adding gdb to noconfigsdirs for or1k.
	* configure: Regenerate.

Cc: gcc-patches at gcc.gnu.org
---
 configure    | 7 -------
 configure.ac | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/configure b/configure
index be9dd89..0bf47fa 100755
--- a/configure
+++ b/configure
@@ -3632,10 +3632,6 @@ case "${target}" in
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
@@ -3841,9 +3837,6 @@ case "${target}" in
   nvptx*-*-*)
     noconfigdirs="$noconfigdirs target-libssp target-libstdc++-v3 target-libobjc"
     ;;
-  or1k*-*-*)
-    noconfigdirs="$noconfigdirs gdb"
-    ;;
   sh-*-*)
     case "${target}" in
       sh*-*-elf)
diff --git a/configure.ac b/configure.ac
index 532c5c2..9d16792 100644
--- a/configure.ac
+++ b/configure.ac
@@ -966,10 +966,6 @@ case "${target}" in
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
@@ -1175,9 +1171,6 @@ case "${target}" in
   nvptx*-*-*)
     noconfigdirs="$noconfigdirs target-libssp target-libstdc++-v3 target-libobjc"
     ;;
-  or1k*-*-*)
-    noconfigdirs="$noconfigdirs gdb"
-    ;;
   sh-*-*)
     case "${target}" in
       sh*-*-elf)
-- 
2.9.4

