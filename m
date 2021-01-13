From: Stafford Horne <shorne@gmail.com>
Date: Thu, 14 Jan 2021 08:50:32 +0900
Subject: [OpenRISC] [PATCH v2 5/5] or1k: Fixup exception header data
 encodings
In-Reply-To: <20210113235032.2821155-1-shorne@gmail.com>
References: <20210113235032.2821155-1-shorne@gmail.com>
Message-ID: <20210113235032.2821155-6-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

While running glibc tests several *-textrel tests failed showing that
relocations remained against read only sections.  It turned out this was
related to exception headers data encoding being wrong.

By default pointer encoding will always use the DW_EH_PE_absptr format.

This patch uses format DW_EH_PE_pcrel and DW_EH_PE_sdata4.  Optionally
DW_EH_PE_indirect is included for global symbols.  This eliminates the
relocations.

gcc/ChangeLog:

	* config/or1k/or1k.h (ASM_PREFERRED_EH_DATA_FORMAT): New macro.
---
 gcc/config/or1k/or1k.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
index b686f1bd159..fe01ab81ead 100644
--- a/gcc/config/or1k/or1k.h
+++ b/gcc/config/or1k/or1k.h
@@ -408,4 +408,8 @@ do {                                                    \
     ((N) < 4 ? HW_TO_GCC_REGNO (25) + (N) : INVALID_REGNUM)
 #define EH_RETURN_STACKADJ_RTX gen_rtx_REG (Pmode, EH_RETURN_REGNUM)
 
+/* Select a format to encode pointers in exception handling data.  */
+#define ASM_PREFERRED_EH_DATA_FORMAT(CODE, GLOBAL) \
+  (((GLOBAL) ? DW_EH_PE_indirect : 0) | DW_EH_PE_pcrel | DW_EH_PE_sdata4)
+
 #endif /* GCC_OR1K_H */
-- 
2.26.2

