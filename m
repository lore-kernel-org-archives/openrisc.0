From: Stafford Horne <shorne@gmail.com>
Date: Sun,  9 Jun 2019 06:32:24 +0900
Subject: [OpenRISC] [PATCH v3 08/11] sim/common: wire up new unordered
 comparisons
In-Reply-To: <20190608213225.3230-1-shorne@gmail.com>
References: <20190608213225.3230-1-shorne@gmail.com>
Message-ID: <20190608213225.3230-9-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Define and wire up unordered floating point comparison operations for cgen
targets.  This patch depends on my posted cgen patches[0].

[0] https://www.sourceware.org/ml/cgen/2019-q2/msg00013.html

sim/common/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* cgen-accfp.c (unorderedsf, unordereddf): New functions.
	(cgen_init_accurate_fpu): Wire up unorderedsf and unordereddf.
	* cgen-fpu.h (cgen_fp_ops): Define fields unorderedsf and unordereddf.
---
Changes from v2:
 - new patch

 sim/common/cgen-accfp.c | 25 +++++++++++++++++++++++++
 sim/common/cgen-fpu.h   |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/sim/common/cgen-accfp.c b/sim/common/cgen-accfp.c
index 51f5a29fe2..b898de3935 100644
--- a/sim/common/cgen-accfp.c
+++ b/sim/common/cgen-accfp.c
@@ -303,6 +303,18 @@ gesf (CGEN_FPU* fpu, SF x, SF y)
   return sim_fpu_is_ge (&op1, &op2);
 }
 
+static int
+unorderedsf (CGEN_FPU* fpu, SF x, SF y)
+{
+  sim_fpu op1;
+  sim_fpu op2;
+
+  sim_fpu_32to (&op1, x);
+  sim_fpu_32to (&op2, y);
+  return sim_fpu_is_nan (&op1) || sim_fpu_is_nan (&op2);
+}
+
+
 static DF
 fextsfdf (CGEN_FPU* fpu, int how UNUSED, SF x)
 {
@@ -703,6 +715,17 @@ gedf (CGEN_FPU* fpu, DF x, DF y)
   sim_fpu_64to (&op2, y);
   return sim_fpu_is_ge (&op1, &op2);
 }
+
+static int
+unordereddf (CGEN_FPU* fpu, DF x, DF y)
+{
+  sim_fpu op1;
+  sim_fpu op2;
+
+  sim_fpu_64to (&op1, x);
+  sim_fpu_64to (&op2, y);
+  return sim_fpu_is_nan (&op1) || sim_fpu_is_nan (&op2);
+}
 
 /* Initialize FP_OPS to use accurate library.  */
 
@@ -738,6 +761,7 @@ cgen_init_accurate_fpu (SIM_CPU* cpu, CGEN_FPU* fpu, CGEN_FPU_ERROR_FN* error)
   o->lesf = lesf;
   o->gtsf = gtsf;
   o->gesf = gesf;
+  o->unorderedsf = unorderedsf;
 
   o->adddf = adddf;
   o->subdf = subdf;
@@ -757,6 +781,7 @@ cgen_init_accurate_fpu (SIM_CPU* cpu, CGEN_FPU* fpu, CGEN_FPU_ERROR_FN* error)
   o->ledf = ledf;
   o->gtdf = gtdf;
   o->gedf = gedf;
+  o->unordereddf = unordereddf;
   o->fextsfdf = fextsfdf;
   o->ftruncdfsf = ftruncdfsf;
   o->floatsisf = floatsisf;
diff --git a/sim/common/cgen-fpu.h b/sim/common/cgen-fpu.h
index 5f9b55d32e..cc5d3569e1 100644
--- a/sim/common/cgen-fpu.h
+++ b/sim/common/cgen-fpu.h
@@ -87,6 +87,7 @@ struct cgen_fp_ops {
   int (*lesf) (CGEN_FPU*, SF, SF);
   int (*gtsf) (CGEN_FPU*, SF, SF);
   int (*gesf) (CGEN_FPU*, SF, SF);
+  int (*unorderedsf) (CGEN_FPU*, SF, SF);
 
   /* basic DF ops */
 
@@ -112,6 +113,7 @@ struct cgen_fp_ops {
   int (*ledf) (CGEN_FPU*, DF, DF);
   int (*gtdf) (CGEN_FPU*, DF, DF);
   int (*gedf) (CGEN_FPU*, DF, DF);
+  int (*unordereddf) (CGEN_FPU*, DF, DF);
 
   /* SF/DF conversion ops */
 
-- 
2.21.0

