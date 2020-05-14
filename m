From: Stafford Horne <shorne@gmail.com>
Date: Fri, 15 May 2020 06:00:14 +0900
Subject: [OpenRISC] [PATCH 4/8] or1k: Fix issue with multiple PCREL
 relocations
In-Reply-To: <20200514210018.2749462-1-shorne@gmail.com>
References: <20200514210018.2749462-1-shorne@gmail.com>
Message-ID: <20200514210018.2749462-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

When a symbol has multiple PCREL accesses the first access relocation
will be properly calculated but subsequent ones were not performing the
PCREL calculation.

bfd/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* bfd/elf32-or1k.c (or1k_elf_relocate_section): Fixup PCREL relocation
	calculation.
---
 bfd/elf32-or1k.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index acfdb5bef2..eee418c558 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -1639,9 +1639,18 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	      }
 
 	    /* Only process the relocation once.  */
-	    if (gotoff & 1)
+	    if ((gotoff & 1) != 0)
 	      {
-		relocation = sgot->output_offset + (gotoff  & ~3);
+		gotoff += or1k_initial_exec_offset (howto, tls_type);
+
+		/* The PG21 and LO13 relocs are pc-relative, while the
+		   rest are GOT relative.  */
+		relocation = got_base + (gotoff & ~3);
+		if (!(r_type == R_OR1K_TLS_GD_PG21
+		    || r_type == R_OR1K_TLS_GD_LO13
+		    || r_type == R_OR1K_TLS_IE_PG21
+		    || r_type == R_OR1K_TLS_IE_LO13))
+		  relocation -= got_sym_value;
 		break;
 	      }
 
-- 
2.26.2

