From: Stafford Horne <shorne@gmail.com>
Date: Mon, 17 Apr 2017 08:23:54 +0900
Subject: [OpenRISC] [PATCH 5/7] migration: Add VMSTATE_UINTTL_2DARRAY()
In-Reply-To: <cover.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
Message-ID: <319fd7910ccc8ab543e2396f3d757f76084eac88.1492384862.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

In openRISC we are implementing the shadow registers as a 2d array.
Using this target long method rather than direct 32-bit alternatives is
consistent with the rest of our vm state serialization logic.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 include/migration/cpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index f3d5dfc..a40bd35 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -18,6 +18,8 @@
     VMSTATE_UINT64_EQUAL_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
+    VMSTATE_UINT64_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
     VMSTATE_UINT64_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint64
@@ -37,6 +39,8 @@
     VMSTATE_UINT32_EQUAL_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
+    VMSTATE_UINT32_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
     VMSTATE_UINT32_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint32
@@ -48,5 +52,8 @@
     VMSTATE_UINTTL_EQUAL_V(_f, _s, 0)
 #define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
+#define VMSTATE_UINTTL_2DARRAY(_f, _s, _n1, _n2)                      \
+    VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, 0)
+
 
 #endif
-- 
2.9.3

