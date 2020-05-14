From: Stafford Horne <shorne@gmail.com>
Date: Fri, 15 May 2020 06:00:11 +0900
Subject: [OpenRISC] [PATCH 1/8] or1k: Fix static linking when with .rela.got
 relocations
In-Reply-To: <20200514210018.2749462-1-shorne@gmail.com>
References: <20200514210018.2749462-1-shorne@gmail.com>
Message-ID: <20200514210018.2749462-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

When testing glibc static cases were failing due to the assert of
srelgot failing.  Using the reference via htab->root.srelgot
works fine as it is initialized.  Also, this contains a few other
fixups made while figuring out the issue.

bfd/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* elf32-or1k.c (or1k_elf_finish_dynamic_symbol): Rename srela
	to relgot.
	(or1k_elf_relocate_section): Access srelgot via
	htab->root.srelgot.  Add assertions for srelgot->contents.
	Introduce local variable for srelgot to not reuse global
	sreloc.
---
 bfd/elf32-or1k.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 41e61ac7e2..221a14c5b1 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -1226,7 +1226,6 @@ or1k_elf_relocate_section (bfd *output_bfd,
   Elf_Internal_Rela *rel;
   Elf_Internal_Rela *relend;
   struct elf_or1k_link_hash_table *htab = or1k_elf_hash_table (info);
-  bfd *dynobj;
   asection *sreloc;
   bfd_vma *local_got_offsets;
   asection *sgot, *splt;
@@ -1236,7 +1235,6 @@ or1k_elf_relocate_section (bfd *output_bfd,
   if (htab == NULL)
     return FALSE;
 
-  dynobj = htab->root.dynobj;
   local_got_offsets = elf_local_got_offsets (input_bfd);
 
   sreloc = elf_section_data (input_section)->sreloc;
@@ -1254,7 +1252,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
       got_sym_value = (hgot->root.u.def.value
 		       + hgot->root.u.def.section->output_section->vma
 		       + hgot->root.u.def.section->output_offset);
-    got_base = sgot->output_section->vma + sgot->output_offset;
+      got_base = sgot->output_section->vma + sgot->output_offset;
     }
 
   symtab_hdr = &elf_tdata (input_bfd)->symtab_hdr;
@@ -1416,16 +1414,16 @@ or1k_elf_relocate_section (bfd *output_bfd,
 
 		      /* We need to generate a R_OR1K_RELATIVE reloc
 			 for the dynamic linker.  */
-			srelgot = bfd_get_section_by_name (dynobj, ".rela.got");
+		      srelgot = htab->root.srelgot;
 		      BFD_ASSERT (srelgot != NULL);
 
 		      outrel.r_offset = got_base + off;
 		      outrel.r_info = ELF32_R_INFO (0, R_OR1K_RELATIVE);
 		      outrel.r_addend = relocation;
 		      loc = srelgot->contents;
-			loc += (srelgot->reloc_count
-				* sizeof (Elf32_External_Rela));
-		      bfd_elf32_swap_reloca_out (output_bfd, &outrel,loc);
+		      loc += (srelgot->reloc_count
+			      * sizeof (Elf32_External_Rela));
+		      bfd_elf32_swap_reloca_out (output_bfd, &outrel, loc);
 		      ++srelgot->reloc_count;
 		    }
 		  local_got_offsets[r_symndx] |= 1;
@@ -1591,10 +1589,11 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	  {
 	    bfd_vma gotoff;
 	    Elf_Internal_Rela rela;
+	    asection *srelgot;
 	    bfd_byte *loc;
 	    int dynamic;
 
-	    sreloc = bfd_get_section_by_name (dynobj, ".rela.got");
+	    srelgot = htab->root.srelgot;
 
 	    /* Mark as TLS related GOT entry by setting
 	       bit 2 as well as bit 1.  */
@@ -1619,7 +1618,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	    BFD_ASSERT (elf_hash_table (info)->hgot == NULL
 			|| elf_hash_table (info)->hgot->root.u.def.value == 0);
 
-	    /* Dynamic entries will require relocations. if we do not need
+	    /* Dynamic entries will require relocations.  If we do not need
 	       them we will just use the default R_OR1K_NONE and
 	       not set anything.  */
 	    dynamic = bfd_link_pic (info)
@@ -1639,6 +1638,8 @@ or1k_elf_relocate_section (bfd *output_bfd,
 		/* Add DTPMOD and DTPOFF GOT and rela entries.  */
 		for (i = 0; i < 2; ++i)
 		  {
+		    BFD_ASSERT (srelgot->contents != NULL);
+
 		    rela.r_offset = got_base + gotoff + i*4;
 		    if (h != NULL && h->dynindx != -1)
 		      {
@@ -1653,9 +1654,9 @@ or1k_elf_relocate_section (bfd *output_bfd,
 			rela.r_addend = tpoff (info, relocation);
 		      }
 
-		    loc = sreloc->contents;
-		    loc += sreloc->reloc_count++ *
-		      sizeof (Elf32_External_Rela);
+		    loc = srelgot->contents;
+		    loc += (srelgot->reloc_count++
+			    * sizeof (Elf32_External_Rela));
 
 		    bfd_elf32_swap_reloca_out (output_bfd, &rela, loc);
 		    bfd_put_32 (output_bfd, 0, sgot->contents + gotoff + i*4);
@@ -1674,6 +1675,8 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	    /* Shared IE.  */
 	    else if (dynamic)
 	      {
+		BFD_ASSERT (srelgot->contents != NULL);
+
 		/* Add TPOFF GOT and rela entries.  */
 		rela.r_offset = got_base + gotoff;
 		if (h != NULL && h->dynindx != -1)
@@ -1687,8 +1690,8 @@ or1k_elf_relocate_section (bfd *output_bfd,
 		    rela.r_addend = tpoff (info, relocation);
 		  }
 
-		loc = sreloc->contents;
-		loc += sreloc->reloc_count++ * sizeof (Elf32_External_Rela);
+		loc = srelgot->contents;
+		loc += srelgot->reloc_count++ * sizeof (Elf32_External_Rela);
 
 		bfd_elf32_swap_reloca_out (output_bfd, &rela, loc);
 		bfd_put_32 (output_bfd, 0, sgot->contents + gotoff);
@@ -2402,14 +2405,14 @@ or1k_elf_finish_dynamic_symbol (bfd *output_bfd,
       && (h->got.offset & 2) == 0) /* Homemade TLS check.  */
     {
       asection *sgot;
-      asection *srela;
+      asection *srelgot;
       Elf_Internal_Rela rela;
 
       /* This symbol has an entry in the global offset table.  Set it
 	 up.  */
       sgot = htab->root.sgot;
-      srela = htab->root.srelgot;
-      BFD_ASSERT (sgot != NULL && srela != NULL);
+      srelgot = htab->root.srelgot;
+      BFD_ASSERT (sgot != NULL && srelgot != NULL);
 
       rela.r_offset = (sgot->output_section->vma
 		       + sgot->output_offset
@@ -2435,10 +2438,10 @@ or1k_elf_finish_dynamic_symbol (bfd *output_bfd,
 	  rela.r_addend = 0;
 	}
 
-      loc = srela->contents;
-      loc += srela->reloc_count * sizeof (Elf32_External_Rela);
+      loc = srelgot->contents;
+      loc += srelgot->reloc_count * sizeof (Elf32_External_Rela);
       bfd_elf32_swap_reloca_out (output_bfd, &rela, loc);
-      ++srela->reloc_count;
+      ++srelgot->reloc_count;
     }
 
   if (h->needs_copy)
-- 
2.26.2

