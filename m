From: Stafford Horne <shorne@gmail.com>
Date: Mon, 29 May 2017 23:47:27 +0900
Subject: [OpenRISC] [PATCH v4 2/5] sim: cgen: add MUL2OFSI and MUL1OFSI
	macros (needed for OR1K l.mul[u])
In-Reply-To: <cover.1496066478.git.shorne@gmail.com>
References: <cover.1496066478.git.shorne@gmail.com>
Message-ID: <700407e5797b8b9b9f76b2dba026d1b06978987b.1496066478.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

sim/common/ChangeLog:

2012-03-14  Peter Gavin  <pgavin@gmail.com>

	* cgen-ops.h (MUL2OFSI): New macro, 1's complement.
	(MUL1OFSI): New macro, 2's complement.
---
 sim/common/cgen-ops.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sim/common/cgen-ops.h b/sim/common/cgen-ops.h
index 97585d7..ffbdf3f 100644
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
2.9.4

