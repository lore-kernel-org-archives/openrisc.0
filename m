From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:42 +0900
Subject: [OpenRISC] [PATCH 16/18] gdb: Remove corelow object from or1k linux
	build
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-17-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Corelow is no longer needed in configure.tgt as its already
included.

gdb/ChangeLog:

	* configure.tgt: remove corelow for or1k
---
 gdb/configure.tgt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gdb/configure.tgt b/gdb/configure.tgt
index 2c5418c..3a3df97 100644
--- a/gdb/configure.tgt
+++ b/gdb/configure.tgt
@@ -423,7 +423,7 @@ nios2*-*-*)
 
 or1k-*-linux*)
 	# Target: OpenCores OpenRISC 1000 32-bit implementation for Linux
-	gdb_target_obs="or1k-tdep.o corelow.o"
+	gdb_target_obs="or1k-tdep.o"
 	gdb_sim=../sim/or1k/libsim.a
 	build_gdbserver=yes
 	;;
@@ -431,13 +431,13 @@ or1k-*-linux*)
 or1k-*-*)
 	# Target: OpenCores OpenRISC 1000 32-bit implementation bare metal
 	gdb_target_obs="or1k-tdep.o"
-    gdb_sim=../sim/or1k/libsim.a
+	gdb_sim=../sim/or1k/libsim.a
 	;;
 
 or1knd-*-linux*)
 	# Target: OpenCores OpenRISC 1000 32-bit implementation for Linux, without delay slot
-	gdb_target_obs="or1k-tdep.o corelow.o"
-    gdb_sim=../sim/or1k/libsim.a
+	gdb_target_obs="or1k-tdep.o"
+	gdb_sim=../sim/or1k/libsim.a
 	build_gdbserver=yes
 	;;
 
-- 
2.7.4


