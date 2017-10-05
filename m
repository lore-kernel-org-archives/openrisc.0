From: Stafford Horne <shorne@gmail.com>
Date: Thu,  5 Oct 2017 22:49:07 +0900
Subject: [OpenRISC] [PATCH v5 1/6] sim: cgen: add remainder functions
	(needed for OR1K lf.rem.[sd])
In-Reply-To: <20171005134912.26799-1-shorne@gmail.com>
References: <20171005134912.26799-1-shorne@gmail.com>
Message-ID: <20171005134912.26799-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

* sim/common/ChangeLog:

2016-05-21  Peter Gavin  <pgavin@gmail.com>
	    Stafford Horne <shorne@gmail.com>

	* cgen-accfp.c (remsf, remdf): New function.
	(cgen_init_accurate_fpu): Add remsf and remdf.
	* cgen-fpu.h (cgen_fp_ops): Add remsf, remdf, remxf and remtf.
	* sim-fpu.c (sim_fpu_rem): New function.
	* sim-fpu.h (sim_fpu_status_invalid_irx): New enum.
	(sim_fpu_rem): New function.
---
 sim/common/cgen-accfp.c | 40 ++++++++++++++++++++++
 sim/common/cgen-fpu.h   |  4 +++
 sim/common/sim-fpu.c    | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 sim/common/sim-fpu.h    | 13 ++++---
 4 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/sim/common/cgen-accfp.c b/sim/common/cgen-accfp.c
index afbca6d582..5d600c6e41 100644
--- a/sim/common/cgen-accfp.c
+++ b/sim/common/cgen-accfp.c
@@ -93,6 +93,25 @@ divsf (CGEN_FPU* fpu, SF x, SF y)
 }
 
 static SF
+remsf (CGEN_FPU* fpu, SF x, SF y)
+{
+  sim_fpu op1;
+  sim_fpu op2;
+  sim_fpu ans;
+  unsigned32 res;
+  sim_fpu_status status;
+
+  sim_fpu_32to (&op1, x);
+  sim_fpu_32to (&op2, y);
+  status = sim_fpu_rem (&ans, &op1, &op2);
+  if (status != 0)
+    (*fpu->ops->error) (fpu, status);
+  sim_fpu_to32 (&res, &ans);
+
+  return res;
+}
+
+static SF
 negsf (CGEN_FPU* fpu, SF x)
 {
   sim_fpu op1;
@@ -453,6 +472,25 @@ divdf (CGEN_FPU* fpu, DF x, DF y)
 }
 
 static DF
+remdf (CGEN_FPU* fpu, DF x, DF y)
+{
+  sim_fpu op1;
+  sim_fpu op2;
+  sim_fpu ans;
+  unsigned64 res;
+  sim_fpu_status status;
+
+  sim_fpu_64to (&op1, x);
+  sim_fpu_64to (&op2, y);
+  status = sim_fpu_rem (&ans, &op1, &op2);
+  if (status != 0)
+    (*fpu->ops->error) (fpu, status);
+  sim_fpu_to64(&res, &ans);
+
+  return res;
+}
+
+static DF
 negdf (CGEN_FPU* fpu, DF x)
 {
   sim_fpu op1;
@@ -664,6 +702,7 @@ cgen_init_accurate_fpu (SIM_CPU* cpu, CGEN_FPU* fpu, CGEN_FPU_ERROR_FN* error)
   o->subsf = subsf;
   o->mulsf = mulsf;
   o->divsf = divsf;
+  o->remsf = remsf;
   o->negsf = negsf;
   o->abssf = abssf;
   o->sqrtsf = sqrtsf;
@@ -682,6 +721,7 @@ cgen_init_accurate_fpu (SIM_CPU* cpu, CGEN_FPU* fpu, CGEN_FPU_ERROR_FN* error)
   o->subdf = subdf;
   o->muldf = muldf;
   o->divdf = divdf;
+  o->remdf = remdf;
   o->negdf = negdf;
   o->absdf = absdf;
   o->sqrtdf = sqrtdf;
diff --git a/sim/common/cgen-fpu.h b/sim/common/cgen-fpu.h
index 134b4d031c..5f9b55d32e 100644
--- a/sim/common/cgen-fpu.h
+++ b/sim/common/cgen-fpu.h
@@ -69,6 +69,7 @@ struct cgen_fp_ops {
   SF (*subsf) (CGEN_FPU*, SF, SF);
   SF (*mulsf) (CGEN_FPU*, SF, SF);
   SF (*divsf) (CGEN_FPU*, SF, SF);
+  SF (*remsf) (CGEN_FPU*, SF, SF);
   SF (*negsf) (CGEN_FPU*, SF);
   SF (*abssf) (CGEN_FPU*, SF);
   SF (*sqrtsf) (CGEN_FPU*, SF);
@@ -93,6 +94,7 @@ struct cgen_fp_ops {
   DF (*subdf) (CGEN_FPU*, DF, DF);
   DF (*muldf) (CGEN_FPU*, DF, DF);
   DF (*divdf) (CGEN_FPU*, DF, DF);
+  DF (*remdf) (CGEN_FPU*, DF, DF);
   DF (*negdf) (CGEN_FPU*, DF);
   DF (*absdf) (CGEN_FPU*, DF);
   DF (*sqrtdf) (CGEN_FPU*, DF);
@@ -142,6 +144,7 @@ struct cgen_fp_ops {
   XF (*subxf) (CGEN_FPU*, XF, XF);
   XF (*mulxf) (CGEN_FPU*, XF, XF);
   XF (*divxf) (CGEN_FPU*, XF, XF);
+  XF (*remxf) (CGEN_FPU*, XF, XF);
   XF (*negxf) (CGEN_FPU*, XF);
   XF (*absxf) (CGEN_FPU*, XF);
   XF (*sqrtxf) (CGEN_FPU*, XF);
@@ -180,6 +183,7 @@ struct cgen_fp_ops {
   TF (*subtf) (CGEN_FPU*, TF, TF);
   TF (*multf) (CGEN_FPU*, TF, TF);
   TF (*divtf) (CGEN_FPU*, TF, TF);
+  TF (*remtf) (CGEN_FPU*, TF, TF);
   TF (*negtf) (CGEN_FPU*, TF);
   TF (*abstf) (CGEN_FPU*, TF);
   TF (*sqrttf) (CGEN_FPU*, TF);
diff --git a/sim/common/sim-fpu.c b/sim/common/sim-fpu.c
index 0d4d08ae86..854d19dfd8 100644
--- a/sim/common/sim-fpu.c
+++ b/sim/common/sim-fpu.c
@@ -41,7 +41,6 @@ along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
 #include "sim-io.h"
 #include "sim-assert.h"
 
-
 /* Debugging support.
    If digits is -1, then print all digits.  */
 
@@ -834,6 +833,7 @@ do_normal_round (sim_fpu *f,
   unsigned64 guardmask = LSMASK64 (nr_guards - 1, 0);
   unsigned64 guardmsb = LSBIT64 (nr_guards - 1);
   unsigned64 fraclsb = guardmsb << 1;
+  /* If there are decimal values do the round.  */
   if ((f->fraction & guardmask))
     {
       int status = sim_fpu_status_inexact;
@@ -865,6 +865,7 @@ do_normal_round (sim_fpu *f,
 	case sim_fpu_round_zero:
 	  break;
 	}
+      /* Actually do the rounding by masking out the decimals.  */
       f->fraction &= ~guardmask;
       /* Round if needed, handle resulting overflow.  */
       if ((status & sim_fpu_status_rounded))
@@ -1384,7 +1385,6 @@ sim_fpu_mul (sim_fpu *f,
        up in the high 64 bit word.  In the source the decimal point
        was at NR_FRAC_GUARD. */
     f->normal_exp += NR_FRAC_GUARD + 64 - (NR_FRAC_GUARD * 2);
-
     /* The high word is bounded according to the above.  Consequently
        it has never overflowed into IMPLICIT_2. */
     ASSERT (high < LSBIT64 (((NR_FRAC_GUARD + 1) * 2) - 64));
@@ -1551,6 +1551,89 @@ sim_fpu_div (sim_fpu *f,
 
 
 INLINE_SIM_FPU (int)
+sim_fpu_rem (sim_fpu *f,
+	     const sim_fpu *l,
+	     const sim_fpu *r)
+{
+  if (sim_fpu_is_snan (l))
+    {
+      *f = *l;
+      f->class = sim_fpu_class_qnan;
+      return sim_fpu_status_invalid_snan;
+    }
+  if (sim_fpu_is_snan (r))
+    {
+      *f = *r;
+      f->class = sim_fpu_class_qnan;
+      return sim_fpu_status_invalid_snan;
+    }
+  if (sim_fpu_is_qnan (l))
+    {
+      *f = *l;
+      f->class = sim_fpu_class_qnan;
+      return 0;
+    }
+  if (sim_fpu_is_qnan (r))
+    {
+      *f = *r;
+      f->class = sim_fpu_class_qnan;
+      return 0;
+    }
+  if (sim_fpu_is_infinity (l))
+    {
+      *f = sim_fpu_qnan;
+      return sim_fpu_status_invalid_irx;
+    }
+  if (sim_fpu_is_zero (r))
+    {
+      *f = sim_fpu_qnan;
+      return sim_fpu_status_invalid_div0;
+    }
+  if (sim_fpu_is_zero (l))
+    {
+      *f = *l;
+      return 0;
+    }
+  if (sim_fpu_is_infinity (r))
+    {
+      *f = *l;
+      return 0;
+    }
+  {
+    sim_fpu n, tmp;
+
+    /* Remainder is calculated as l-n*r, where n is l/r rounded to the
+       nearest integer.  The variable n is rounded half even.  */
+
+    sim_fpu_div (&n, l, r);
+    sim_fpu_round_64 (&n, 0, 0);
+
+    if (n.normal_exp < -1) /* If n looks like zero just return l.  */
+      {
+	*f = *l;
+	return 0;
+      }
+    else if (n.class == sim_fpu_class_number
+	&& n.normal_exp <= (NR_FRAC_GUARD)) /* If not too large round.  */
+      do_normal_round (&n, (NR_FRAC_GUARD) - n.normal_exp, sim_fpu_round_near);
+
+    /* Mark 0's as zero so multiply can detect zero.  */
+    if (n.fraction == 0)
+      n.class = sim_fpu_class_zero;
+
+    /* Calculate n*r.  */
+    sim_fpu_mul (&tmp, &n, r);
+    sim_fpu_round_64 (&tmp, 0, 0);
+
+    /* Finally calculate l-n*r.  */
+    sim_fpu_sub (f, l, &tmp);
+
+    return 0;
+  }
+}
+
+
+INLINE_SIM_FPU (int)
 sim_fpu_max (sim_fpu *f,
 	     const sim_fpu *l,
 	     const sim_fpu *r)
@@ -2533,6 +2616,9 @@ sim_fpu_print_status (int status,
 	case sim_fpu_status_invalid_sqrt:
 	  print (arg, "%sSQRT", prefix);
 	  break;
+	case sim_fpu_status_invalid_irx:
+	  print (arg, "%sIRX", prefix);
+	  break;
 	case sim_fpu_status_inexact:
 	  print (arg, "%sX", prefix);
 	  break;
diff --git a/sim/common/sim-fpu.h b/sim/common/sim-fpu.h
index d27d80a513..adf3b1904a 100644
--- a/sim/common/sim-fpu.h
+++ b/sim/common/sim-fpu.h
@@ -146,11 +146,12 @@ typedef enum
   sim_fpu_status_invalid_div0 = 128, /* (X / 0) */
   sim_fpu_status_invalid_cmp = 256, /* compare */
   sim_fpu_status_invalid_sqrt = 512,
-  sim_fpu_status_rounded = 1024,
-  sim_fpu_status_inexact = 2048,
-  sim_fpu_status_overflow = 4096,
-  sim_fpu_status_underflow = 8192,
-  sim_fpu_status_denorm = 16384,
+  sim_fpu_status_invalid_irx = 1024, /* (inf % X) */
+  sim_fpu_status_rounded = 2048,
+  sim_fpu_status_inexact = 4096,
+  sim_fpu_status_overflow = 8192,
+  sim_fpu_status_underflow = 16384,
+  sim_fpu_status_denorm = 32768,
 } sim_fpu_status;
 
 
@@ -230,6 +231,8 @@ INLINE_SIM_FPU (int) sim_fpu_mul (sim_fpu *f,
 				  const sim_fpu *l, const sim_fpu *r);
 INLINE_SIM_FPU (int) sim_fpu_div (sim_fpu *f,
 				  const sim_fpu *l, const sim_fpu *r);
+INLINE_SIM_FPU (int) sim_fpu_rem (sim_fpu *f,
+				  const sim_fpu *l, const sim_fpu *r);
 INLINE_SIM_FPU (int) sim_fpu_max (sim_fpu *f,
 				  const sim_fpu *l, const sim_fpu *r);
 INLINE_SIM_FPU (int) sim_fpu_min (sim_fpu *f,
-- 
2.13.5

