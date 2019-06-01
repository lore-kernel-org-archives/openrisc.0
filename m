From: Stafford Horne <shorne@gmail.com>
Date: Sat,  1 Jun 2019 16:26:28 +0900
Subject: [OpenRISC] [PATCH 1/2] cgen: Add unordered compare operation
In-Reply-To: <20190601072629.4070-1-shorne@gmail.com>
References: <20190601072629.4070-1-shorne@gmail.com>
Message-ID: <20190601072629.4070-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On OpenRISC we have added FPU unordered comparison operations (NaN
detection).  This patch adds the unordered operation which will generate
c hooks to be implemented in simulators.

An unordered comparison can now be defined as:

  ; Compare unordered (set flag if either r1 or r2 is NaN)
  (set BI flag (unordered WI r1 r2))

  ; Compare unordered, greater than or equal
  (set BI flag (or (unordered WI r1 r2)
		   (ge WI r1 r2)))

ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* rtl-c.scm (unordered): New comparison operation.
	* rtx-funcs.scm (unordered): New rtx node.
---
 rtl-c.scm     | 4 ++++
 rtx-funcs.scm | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/rtl-c.scm b/rtl-c.scm
index 1a4b8b0..4d4d671 100644
--- a/rtl-c.scm
+++ b/rtl-c.scm
@@ -1897,6 +1897,10 @@
 (define-fn geu (*estate* options mode s1 s2)
   (s-cmpop *estate* 'geu ">=" mode s1 s2)
 )
+(define-fn unordered (*estate* options mode s1 s2)
+  (s-cmpop *estate* 'unordered #f mode s1 s2)
+)
+
 
 (define-fn member (*estate* options mode value set)
   ;; NOTE: There are multiple evalutions of VALUE in the generated code.
diff --git a/rtx-funcs.scm b/rtx-funcs.scm
index 6c28735..f16864a 100644
--- a/rtx-funcs.scm
+++ b/rtx-funcs.scm
@@ -1086,6 +1086,13 @@
      COMPARE
      #f
 )
+; Detect NaNs
+(drn (unordered &options &mode s1 s2)
+     BI
+     (OPTIONS ANYNUMMODE RTX RTX) (NA NA MATCHEXPR MATCH2)
+     COMPARE
+     #f
+)
 
 ; Set membership.
 ; Useful in ifield assertions.
-- 
2.21.0

