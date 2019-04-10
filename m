From: Stafford Horne <shorne@gmail.com>
Date: Thu, 11 Apr 2019 06:27:46 +0900
Subject: [OpenRISC] [PATCH 2/3] or1k: Allow volatile memory for sign/zero
 extend loads
In-Reply-To: <20190410212747.18377-1-shorne@gmail.com>
References: <20190410212747.18377-1-shorne@gmail.com>
Message-ID: <20190410212747.18377-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Volatile memory does not match the memory_operand predicate.  This
causes extra extend/mask instructions instructions when reading
from volatile memory.  On OpenRISC this can be treated the same
as regular memory.

gcc/ChangeLog:

	* config/or1k/or1k.md (zero_extend<mode>si2): Update predicate.
	(extend<mode>si2): Update predicate.
	* gcc/config/or1k/predicates.md (volatile_mem_operand): New.
	(reg_or_mem_operand): New.
---
 gcc/config/or1k/or1k.md       |  6 +++---
 gcc/config/or1k/predicates.md | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
index 202493c5ab9..23ded94feb3 100644
--- a/gcc/config/or1k/or1k.md
+++ b/gcc/config/or1k/or1k.md
@@ -372,11 +372,11 @@
 ;; Sign Extending
 ;; -------------------------------------------------------------------------
 
-;; Zero extension can always be done with AND and an extending load.
+;; Zero extension can always be done with AND or an extending load.
 
 (define_insn "zero_extend<mode>si2"
   [(set (match_operand:SI 0 "register_operand"                     "=r,r")
-	(zero_extend:SI (match_operand:I12 1 "nonimmediate_operand" "r,m")))]
+	(zero_extend:SI (match_operand:I12 1 "reg_or_mem_operand" "r,m")))]
   ""
   "@
    l.andi\t%0, %1, <zext_andi>
@@ -388,7 +388,7 @@
 
 (define_insn "extend<mode>si2"
   [(set (match_operand:SI 0 "register_operand"                      "=r,r")
-	(sign_extend:SI (match_operand:I12 1 "nonimmediate_operand"  "r,m")))]
+	(sign_extend:SI (match_operand:I12 1 "reg_or_mem_operand"  "r,m")))]
   "TARGET_SEXT"
   "@
    l.ext<ldst>s\t%0, %1
diff --git a/gcc/config/or1k/predicates.md b/gcc/config/or1k/predicates.md
index 879236bca49..17599d0ee3b 100644
--- a/gcc/config/or1k/predicates.md
+++ b/gcc/config/or1k/predicates.md
@@ -82,3 +82,19 @@
 
 (define_predicate "equality_comparison_operator"
   (match_code "ne,eq"))
+
+;; Borrowed from rs6000
+;  Return 1 if the operand is in volatile memory.  Note that during the
+;; RTL generation phase, memory_operand does not return TRUE for volatile
+;; memory references.  So this function allows us to recognize volatile
+;; references where it's safe.
+(define_predicate "volatile_mem_operand"
+  (and (and (match_code "mem")
+	    (match_test "MEM_VOLATILE_P (op)"))
+       (if_then_else (match_test "reload_completed")
+	 (match_operand 0 "memory_operand")
+	 (match_test "memory_address_p (mode, XEXP (op, 0))"))))
+
+(define_predicate "reg_or_mem_operand"
+  (ior (match_operand 0 "nonimmediate_operand")
+       (match_operand 0 "volatile_mem_operand")))
-- 
2.19.1

