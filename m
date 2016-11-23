From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:16 +0900
Subject: [OpenRISC] [PATCH 02/18] sim: cgen: add mul-o1flag,
	mul-o2flag RTL functions to CGEN
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-3-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

* sim/common/ChangeLog
2012-03-14  Peter Gavin  <pgavin@gmail.com>

	* add mul-o1flag (1's complement unsigned multiply overflow flag)
	and mul-o2flag (2's complement signed multiply overflow flag)
	* cgen-ops.h:
	(MUL1OFSI) new function: 1's complement
	(MUL2OFSI) new function: 2's complement
---
 sim/common/cgen-ops.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sim/common/cgen-ops.h b/sim/common/cgen-ops.h
index 7ff1b4d..81ba02c 100644
--- a/sim/common/cgen-ops.h
+++ b/sim/common/cgen-ops.h
@@ -631,6 +631,22 @@ SUBOFQI (QI a, QI b, BI c)
   return res;
 }
 
+SEMOPS_INLINE BI
+MUL2OFSI (SI a, SI b)
+{
+  DI tmp = MULDI (EXTSIDI(a), EXTSIDI(b));
+  BI res = tmp < -0x80000000LL || tmp > 0x7fffffffLL;
+  return res;
+}
+
+SEMOPS_INLINE BI
+MUL1OFSI (USI a, USI b)
+{
+  UDI tmp = MULDI (ZEXTSIDI(a), ZEXTSIDI(b));
+  BI res = (tmp > 0xFFFFFFFFULL);
+  return res;
+}
+
 #else
 
 SI ADDCSI (SI, SI, BI);
@@ -651,6 +667,8 @@ UBI ADDOFQI (QI, QI, BI);
 QI SUBCQI (QI, QI, BI);
 UBI SUBCFQI (QI, QI, BI);
 UBI SUBOFQI (QI, QI, BI);
+BI MUL1OFSI (SI a, SI b);
+BI MUL2OFSI (SI a, SI b);
 
 #endif
 
-- 
2.7.4


