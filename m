From: Stafford Horne <shorne@gmail.com>
Date: Fri, 17 Mar 2017 14:39:07 +0900
Subject: [OpenRISC] [PATCH v3 1/5] sim: cgen: add rem (remainder) function
	(needed for OR1K lf.rem.[sd])
In-Reply-To: <cover.1489728532.git.shorne@gmail.com>
References: <cover.1489728532.git.shorne@gmail.com>
Message-ID: <871f7df41af556525339d0860ae68a45fd7777bf.1489728532.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

* sim/common/ChangeLog-OR1K:
2012-03-14  Peter Gavin  <pgavin@gmail.com>

	* cgen-accfp.c: add rem (remainder) function (needed for OR1K lf.rem.[sd])
	(remsf) new function
	(remdf) ditto
	(struct cgen_fp_ops) add fields for rem[sdxt]f functions
---
 sim/common/cgen-accfp.c | 40 ++++++++++++++++++++++++++++++
 sim/common/cgen-fpu.h   |  4 +++
 sim/common/sim-fpu.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 sim/common/sim-fpu.h    |  3 +++
 4 files changed, 113 insertions(+)

diff --git a/sim/common/cgen-accfp.c b/sim/common/cgen-accfp.c
index afbca6d..d7124fe 100644
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
@@ -452,6 +471,25 @@ divdf (CGEN_FPU* fpu, DF x, DF y)
   return res;
 }
 
+static SF
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
 static DF
 negdf (CGEN_FPU* fpu, DF x)
 {
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
index 134b4d0..5f9b55d 100644
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
index 0d4d08a..550bcd6 100644
--- a/sim/common/sim-fpu.c
+++ b/sim/common/sim-fpu.c
@@ -41,6 +41,7 @@ along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
 #include "sim-io.h"
 #include "sim-assert.h"
 
+#include <math.h> /* for drem, remove when soft-float version is implemented */
 
 /* Debugging support.
    If digits is -1, then print all digits.  */
@@ -1551,6 +1552,71 @@ sim_fpu_div (sim_fpu *f,
 
 
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
+  
+  {
+    /* cheat for now */
+    /* TODO: don't use hard float */
+
+    sim_fpu_map lval, rval, fval;
+    lval.i = pack_fpu(l, 1);
+    rval.i = pack_fpu(r, 1);
+    fval.d = drem(lval.d, rval.d);
+    unpack_fpu(f, fval.i, 1);
+    return 0;
+    
+  }  
+}
+
+
+INLINE_SIM_FPU (int)
 sim_fpu_max (sim_fpu *f,
 	     const sim_fpu *l,
 	     const sim_fpu *r)
diff --git a/sim/common/sim-fpu.h b/sim/common/sim-fpu.h
index d27d80a..c108f1f 100644
--- a/sim/common/sim-fpu.h
+++ b/sim/common/sim-fpu.h
@@ -151,6 +151,7 @@ typedef enum
   sim_fpu_status_overflow = 4096,
   sim_fpu_status_underflow = 8192,
   sim_fpu_status_denorm = 16384,
+  sim_fpu_status_invalid_irx = 32768, /* (inf % X) */
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
2.9.3

