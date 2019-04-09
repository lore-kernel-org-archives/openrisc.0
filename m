From: Stafford Horne <shorne@gmail.com>
Date: Wed, 10 Apr 2019 06:39:25 +0900
Subject: [OpenRISC] [PATCH v2 6/6] sim/common: Fix issue with wrong byte
 order on BE targets
In-Reply-To: <20190409213925.32699-1-shorne@gmail.com>
References: <20190409213925.32699-1-shorne@gmail.com>
Message-ID: <20190409213925.32699-7-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Currently only the OpenRISC sim uses this JOINSIDF() function to compose a
double float from 2 registers.  The old code doesn't seem to work as the
work order gets swapped when running on a x86_64 host.  This change
fixes that, but I am not sure if its the best thing to do.

On mips they do similar reg pair floating point operations composing
doubles from 2 32-bit registers in sim/mips/cp1.c value_fpr().

sim/common/ChangeLog:

	* cgen-ops.h (JOINSIDF): Fix big endian check.
---
 sim/common/cgen-ops.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sim/common/cgen-ops.h b/sim/common/cgen-ops.h
index 841552066f..d718394723 100644
--- a/sim/common/cgen-ops.h
+++ b/sim/common/cgen-ops.h
@@ -431,12 +431,8 @@ JOINSIDI (SI x0, SI x1)
 SEMOPS_INLINE DF
 JOINSIDF (SI x0, SI x1)
 {
-  union { SI in[2]; DF out; } x;
-  if (CURRENT_TARGET_BYTE_ORDER == BFD_ENDIAN_BIG)
-    x.in[0] = x0, x.in[1] = x1;
-  else
-    x.in[1] = x0, x.in[0] = x1;
-  return x.out;
+  /* Making doubles is the same as making long longs.  */
+  return MAKEDI (x0, x1);
 }
 
 SEMOPS_INLINE XF
-- 
2.19.1

