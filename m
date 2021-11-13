From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Nov 2021 12:16:27 +0900
Subject: [OpenRISC] [PATCH v2 01/13] elf: Add reloc for OpenRISC
In-Reply-To: <20211113031639.2402161-1-shorne@gmail.com>
References: <20211113031639.2402161-1-shorne@gmail.com>
Message-ID: <20211113031639.2402161-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

---
 elf/elf.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/elf/elf.h b/elf/elf.h
index 50f87baceb..4cbacd4794 100644
--- a/elf/elf.h
+++ b/elf/elf.h
@@ -4119,4 +4119,41 @@ enum
 #define R_ARC_TLS_LE_S9		0x4a
 #define R_ARC_TLS_LE_32		0x4b
 
+/* OpenRISC 1000 specific relocs.  */
+#define R_OR1K_NONE		0
+#define R_OR1K_32		1
+#define R_OR1K_16		2
+#define R_OR1K_8		3
+#define R_OR1K_LO_16_IN_INSN	4
+#define R_OR1K_HI_16_IN_INSN	5
+#define R_OR1K_INSN_REL_26	6
+#define R_OR1K_GNU_VTENTRY	7
+#define R_OR1K_GNU_VTINHERIT	8
+#define R_OR1K_32_PCREL		9
+#define R_OR1K_16_PCREL		10
+#define R_OR1K_8_PCREL		11
+#define R_OR1K_GOTPC_HI16	12
+#define R_OR1K_GOTPC_LO16	13
+#define R_OR1K_GOT16		14
+#define R_OR1K_PLT26		15
+#define R_OR1K_GOTOFF_HI16	16
+#define R_OR1K_GOTOFF_LO16	17
+#define R_OR1K_COPY		18
+#define R_OR1K_GLOB_DAT		19
+#define R_OR1K_JMP_SLOT		20
+#define R_OR1K_RELATIVE		21
+#define R_OR1K_TLS_GD_HI16	22
+#define R_OR1K_TLS_GD_LO16	23
+#define R_OR1K_TLS_LDM_HI16	24
+#define R_OR1K_TLS_LDM_LO16	25
+#define R_OR1K_TLS_LDO_HI16	26
+#define R_OR1K_TLS_LDO_LO16	27
+#define R_OR1K_TLS_IE_HI16	28
+#define R_OR1K_TLS_IE_LO16	29
+#define R_OR1K_TLS_LE_HI16	30
+#define R_OR1K_TLS_LE_LO16	31
+#define R_OR1K_TLS_TPOFF	32
+#define R_OR1K_TLS_DTPOFF	33
+#define R_OR1K_TLS_DTPMOD	34
+
 #endif	/* elf.h */
-- 
2.31.1

