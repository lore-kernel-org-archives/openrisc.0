From: Stafford Horne <shorne@gmail.com>
Date: Fri, 15 May 2020 06:00:18 +0900
Subject: [OpenRISC] [PATCH 8/8] or1k: Add dynamic flag to tpoff
In-Reply-To: <20200514210018.2749462-1-shorne@gmail.com>
References: <20200514210018.2749462-1-shorne@gmail.com>
Message-ID: <20200514210018.2749462-9-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This is needed to distinguish between initial executable GD, LD, IE and
LE TLS access which require TCB offset and section alignment, but
access to dynamic symbols in secondary TLS modules do not need this
offset.

This was found when running the glibc testsuite.

bfd/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* elf32-or1k.c (tpoff): Add dynamic boolean argument.
	(or1k_elf_relocate_section): Pass dynamic flag to tpoff.
---
 bfd/elf32-or1k.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 7ac34737aa..a7fe0a9c7c 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -1050,10 +1050,9 @@ or1k_info_to_howto_rela (bfd * abfd,
   return TRUE;
 }
 
-
 /* Return the relocation value for @tpoff relocations..  */
 static bfd_vma
-tpoff (struct bfd_link_info *info, bfd_vma address)
+tpoff (struct bfd_link_info *info, bfd_vma address, bfd_boolean dynamic)
 {
   struct elf_link_hash_table *htab = elf_hash_table (info);
   bfd_vma base;
@@ -1062,15 +1061,20 @@ tpoff (struct bfd_link_info *info, bfd_vma address)
   if (htab->tls_sec == NULL)
     return 0;
 
-  /* On or1k, the tp points to just after the tcb, if we have an alignment
-     greater than the tcb size we need to offset by the alignment difference.  */
-  base = align_power ((bfd_vma) TCB_SIZE, htab->tls_sec->alignment_power)
-	 - TCB_SIZE;
-
-  /* The thread pointer on or1k stores the address after the TCB where
-     the data is, just compute the difference. No need to compensate
-     for the size of TCB.  */
-  return address - htab->tls_sec->vma + base;
+  if (dynamic)
+    return address - htab->tls_sec->vma;
+  else
+    {
+      /* On or1k, the tp points to just after the tcb, if we have an alignment
+	 greater than the tcb size we need to offset by the alignment difference.  */
+      base = align_power ((bfd_vma) TCB_SIZE, htab->tls_sec->alignment_power)
+	     - TCB_SIZE;
+
+      /* The thread pointer on or1k stores the address after the TCB where
+	 the data is, just compute the difference. No need to compensate
+	 for the size of TCB.  */
+      return address - htab->tls_sec->vma + base;
+    }
 }
 
 /* If we have both IE and GD accesses to a symbol the IE relocations should be
@@ -1624,7 +1628,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	    Elf_Internal_Rela rela;
 	    asection *srelgot;
 	    bfd_byte *loc;
-	    int dynamic;
+	    bfd_boolean dynamic;
 	    int indx = 0;
 	    unsigned char tls_type;
 
@@ -1707,7 +1711,8 @@ or1k_elf_relocate_section (bfd *output_bfd,
 		      {
 			rela.r_info = ELF32_R_INFO (0,
 			    (i == 0 ? R_OR1K_TLS_DTPMOD : R_OR1K_TLS_DTPOFF));
-			rela.r_addend = tpoff (info, relocation);
+			rela.r_addend =
+			    (i == 0 ? 0 : tpoff (info, relocation, dynamic));
 		      }
 
 		    loc = srelgot->contents;
@@ -1722,7 +1727,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	    else if ((tls_type & TLS_GD) != 0)
 	      {
 		bfd_put_32 (output_bfd, 1, sgot->contents + gotoff);
-		bfd_put_32 (output_bfd, tpoff (info, relocation),
+		bfd_put_32 (output_bfd, tpoff (info, relocation, dynamic),
 		    sgot->contents + gotoff + 4);
 	      }
 
@@ -1743,7 +1748,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 		else
 		  {
 		    rela.r_info = ELF32_R_INFO (0, R_OR1K_TLS_TPOFF);
-		    rela.r_addend = tpoff (info, relocation);
+		    rela.r_addend = tpoff (info, relocation, dynamic);
 		  }
 
 		loc = srelgot->contents;
@@ -1754,7 +1759,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	      }
 	    /* Static IE.  */
 	    else if ((tls_type & TLS_IE) != 0)
-	      bfd_put_32 (output_bfd, tpoff (info, relocation),
+	      bfd_put_32 (output_bfd, tpoff (info, relocation, dynamic),
 			  sgot->contents + gotoff);
 
 	    /* The PG21 and LO13 relocs are pc-relative, while the
@@ -1773,7 +1778,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	case R_OR1K_TLS_LE_AHI16:
 	case R_OR1K_TLS_LE_SLO16:
 	  /* Relocation is offset from TP.  */
-	  relocation = tpoff (info, relocation);
+	  relocation = tpoff (info, relocation, 0);
 	  break;
 
 	case R_OR1K_TLS_DTPMOD:
-- 
2.26.2

