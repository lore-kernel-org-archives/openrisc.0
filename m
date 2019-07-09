From: Stafford Horne <shorne@gmail.com>
Date: Tue,  9 Jul 2019 22:06:26 +0900
Subject: [OpenRISC] [PATCH v3 5/5] or1k: only force reg for immediates
In-Reply-To: <20190709130626.11226-1-shorne@gmail.com>
References: <20190709130626.11226-1-shorne@gmail.com>
Message-ID: <20190709130626.11226-6-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The force_reg in or1k_expand_compare is hard coded for SImode, which is fine as
this used to only be used on SI expands.  However, with FP support this will
cause issues.  In general we should only force the right hand operand to a
register if its an immediate.  This patch adds an condition to check for that.

gcc/ChangeLog:

	* config/or1k/or1k.c (or1k_expand_compare): Check for int before
	force_reg.
---
 gcc/config/or1k/or1k.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/gcc/config/or1k/or1k.c b/gcc/config/or1k/or1k.c
index 1eea84f47e0..f8eed4a7797 100644
--- a/gcc/config/or1k/or1k.c
+++ b/gcc/config/or1k/or1k.c
@@ -1448,13 +1448,15 @@ void
 or1k_expand_compare (rtx *operands)
 {
   rtx sr_f = gen_rtx_REG (BImode, SR_F_REGNUM);
+  rtx righthand_op = XEXP (operands[0], 1);
   rtx_code cmp_code = GET_CODE (operands[0]);
   bool flag_check_ne = true;
 
-  /* The RTL may receive an immediate in argument 1 of the compare, this is not
-     supported unless we have l.sf*i instructions, force them into registers.  */
-  if (!TARGET_SFIMM)
-    XEXP (operands[0], 1) = force_reg (SImode, XEXP (operands[0], 1));
+  /* Integer RTL may receive an immediate in argument 1 of the compare, this is
+     not supported unless we have l.sf*i instructions, force them into
+     registers.  */
+  if (!TARGET_SFIMM && CONST_INT_P (righthand_op))
+    XEXP (operands[0], 1) = force_reg (SImode, righthand_op);
 
   /* Normalize comparison operators to ones OpenRISC support.  */
   switch (cmp_code)
-- 
2.21.0

