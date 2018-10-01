From: Stafford Horne <shorne@gmail.com>
Date: Mon,  1 Oct 2018 16:09:58 +0900
Subject: [OpenRISC] [PATCH v2 2/5] or1k: Fix messages for relocations in
	shared libraries
In-Reply-To: <20181001071001.20446-1-shorne@gmail.com>
References: <20181001071001.20446-1-shorne@gmail.com>
Message-ID: <20181001071001.20446-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Added checks include:

 - Do not allow relocations to global symbols using relocations which are
   meant for local symbol relocations.
 - Require the use of -fpic when compiling shared libraries.
 - Require zero addend for plt relocations.

yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>

bfd/ChangeLog:

	* elf32-or1k.c (or1k_elf_relocate_section): Add error for unknown
	relocations.  Add error for non zero addend with plt and got
	relocations.  Add error for got and plt references against dynamic, non
	local, symbols.  Add error when linking non shared liraries with
	flag_pic.
---
 bfd/elf32-or1k.c | 148 ++++++++++++++++++++++++++++-------------------
 1 file changed, 90 insertions(+), 58 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 022d8e9fb3..a4dcfb27e2 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -1067,7 +1067,9 @@ or1k_elf_relocate_section (bfd *output_bfd,
   bfd *dynobj;
   asection *sreloc;
   bfd_vma *local_got_offsets;
-  asection *sgot;
+  asection *sgot, *splt;
+  bfd_vma plt_base, got_base;
+  bfd_boolean ret_val = TRUE;
 
   if (htab == NULL)
     return FALSE;
@@ -1077,7 +1079,15 @@ or1k_elf_relocate_section (bfd *output_bfd,
 
   sreloc = elf_section_data (input_section)->sreloc;
 
+  splt = htab->root.splt;
+  plt_base = 0;
+  if (splt != NULL)
+    plt_base = splt->output_section->vma + splt->output_offset;
+
   sgot = htab->root.sgot;
+  got_base = 0;
+  if (sgot != NULL)
+    got_base = sgot->output_section->vma + sgot->output_offset;
 
   symtab_hdr = &elf_tdata (input_bfd)->symtab_hdr;
   sym_hashes = elf_sym_hashes (input_bfd);
@@ -1104,8 +1114,12 @@ or1k_elf_relocate_section (bfd *output_bfd,
 
       if (r_type < 0 || r_type >= (int) R_OR1K_max)
 	{
+	  _bfd_error_handler
+	    (_("%pB: unknown relocation type %d"),
+	     input_bfd, (int) r_type);
 	  bfd_set_error (bfd_error_bad_value);
-	  return FALSE;
+	  ret_val = FALSE;
+	  continue;
 	}
 
       howto = or1k_elf_howto_table + ELF32_R_TYPE (rel->r_info);
@@ -1131,6 +1145,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 				   r_symndx, symtab_hdr, sym_hashes,
 				   h, sec, relocation,
 				   unresolved_reloc, warned, ignored);
+	  name = h->root.root.string;
 	}
 
       if (sec != NULL && discarded_section (sec))
@@ -1143,16 +1158,24 @@ or1k_elf_relocate_section (bfd *output_bfd,
       switch (howto->type)
 	{
 	case R_OR1K_PLT26:
-	  {
-	    if (htab->root.splt != NULL && h != NULL
-		&& h->plt.offset != (bfd_vma) -1)
-	      {
-		relocation = (htab->root.splt->output_section->vma
-			      + htab->root.splt->output_offset
-			      + h->plt.offset);
-	      }
-	    break;
-	  }
+	  /* If the call is not local, redirect the branch to the PLT.
+	     Otherwise do nothing to send the branch to the symbol direct.  */
+	  if (!SYMBOL_CALLS_LOCAL (info, h))
+	    {
+	      BFD_ASSERT (h->plt.offset != (bfd_vma) -1);
+	      relocation = plt_base + h->plt.offset;
+	    }
+
+	  /* Addend should be zero.  */
+	  if (rel->r_addend != 0)
+	    {
+	      _bfd_error_handler
+		(_("%pB: addend should be zero for plt relocations"),
+		 input_bfd);
+	      bfd_set_error (bfd_error_bad_value);
+	      ret_val = FALSE;
+	    }
+	  break;
 
 	case R_OR1K_GOT16:
 	  /* Relocation is to the entry for this symbol in the global
@@ -1229,9 +1252,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 		      srelgot = htab->root.srelgot;
 		      BFD_ASSERT (srelgot != NULL);
 
-		      outrel.r_offset = (sgot->output_section->vma
-					 + sgot->output_offset
-					 + off);
+		      outrel.r_offset = got_base + off;
 		      outrel.r_info = ELF32_R_INFO (0, R_OR1K_RELATIVE);
 		      outrel.r_addend = relocation;
 		      loc = srelgot->contents;
@@ -1247,10 +1268,13 @@ or1k_elf_relocate_section (bfd *output_bfd,
 
 	  /* Addend should be zero.  */
 	  if (rel->r_addend != 0)
-	    _bfd_error_handler
-	      (_("internal error: addend should be zero for %s"),
-	       "R_OR1K_GOT16");
-
+	    {
+	      _bfd_error_handler
+		(_("%pB: addend should be zero for got relocations"),
+		 input_bfd);
+	      bfd_set_error (bfd_error_bad_value);
+	      ret_val = FALSE;
+	    }
 	  break;
 
 	case R_OR1K_GOTOFF_LO16:
@@ -1259,17 +1283,44 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	case R_OR1K_GOTOFF_SLO16:
 	  /* Relocation is offset from GOT.  */
 	  BFD_ASSERT (sgot != NULL);
-	  relocation
-	    -= (htab->root.hgot->root.u.def.value
-		+ htab->root.hgot->root.u.def.section->output_offset
-		+ htab->root.hgot->root.u.def.section->output_section->vma);
+	  if (!SYMBOL_REFERENCES_LOCAL (info, h))
+	    {
+	      _bfd_error_handler
+		(_("%pB: gotoff relocation against dynamic symbol %s"),
+		 input_bfd, h->root.root.string);
+	      ret_val = FALSE;
+	      bfd_set_error (bfd_error_bad_value);
+	    }
+	  relocation -= got_base;
 	  break;
 
 	case R_OR1K_INSN_REL_26:
+	  /* For a non-shared link, these will reference either the plt
+	     or a .dynbss copy of the symbol.  */
+	  if (bfd_link_pic (info) && !SYMBOL_REFERENCES_LOCAL (info, h))
+	    {
+	      _bfd_error_handler
+		(_("%pB: pc-relative relocation against dynamic symbol %s"),
+		 input_bfd, name);
+	      ret_val = FALSE;
+	      bfd_set_error (bfd_error_bad_value);
+	    }
+	  break;
+
 	case R_OR1K_HI_16_IN_INSN:
 	case R_OR1K_LO_16_IN_INSN:
 	case R_OR1K_AHI16:
 	case R_OR1K_SLO16:
+	  if (bfd_link_pic (info))
+	    {
+	      _bfd_error_handler
+		(_("%pB: non-pic relocation against symbol %s"),
+		 input_bfd, name);
+	      ret_val = FALSE;
+	      bfd_set_error (bfd_error_bad_value);
+	    }
+	  break;
+
 	case R_OR1K_32:
 	  /* R_OR1K_16? */
 	  {
@@ -1280,18 +1331,17 @@ or1k_elf_relocate_section (bfd *output_bfd,
 		|| (input_section->flags & SEC_ALLOC) == 0)
 	      break;
 
-	    if ((bfd_link_pic (info)
-		 && (h == NULL
+	    /* Emit a direct relocation if the symbol is dynamic,
+	       or a RELATIVE reloc for shared objects.  We can omit
+	       RELATIVE relocs to local undefweak symbols.  */
+	    if (bfd_link_pic (info)
+		? (h == NULL
 		     || ELF_ST_VISIBILITY (h->other) == STV_DEFAULT
 		     || h->root.type != bfd_link_hash_undefweak)
-		 && (howto->type != R_OR1K_INSN_REL_26
-		     || !SYMBOL_CALLS_LOCAL (info, h)))
-		|| (!bfd_link_pic (info)
-		    && h != NULL
+		: (h != NULL
 		    && h->dynindx != -1
 		    && !h->non_got_ref
-		    && ((h->def_dynamic
-			 && !h->def_regular)
+		   && ((h->def_dynamic && !h->def_regular)
 			|| h->root.type == bfd_link_hash_undefweak
 			|| h->root.type == bfd_link_hash_undefined)))
 	      {
@@ -1319,32 +1369,16 @@ or1k_elf_relocate_section (bfd *output_bfd,
 
 		if (skip)
 		  memset (&outrel, 0, sizeof outrel);
-		/* h->dynindx may be -1 if the symbol was marked to
-		   become local.  */
-		else if (h != NULL
-			 && ((! info->symbolic && h->dynindx != -1)
-			     || !h->def_regular))
+		else if (SYMBOL_REFERENCES_LOCAL (info, h))
 		  {
-		    BFD_ASSERT (h->dynindx != -1);
-		    outrel.r_info = ELF32_R_INFO (h->dynindx, r_type);
-		    outrel.r_addend = rel->r_addend;
+		    outrel.r_info = ELF32_R_INFO (0, R_OR1K_RELATIVE);
+		    outrel.r_addend = relocation + rel->r_addend;
 		  }
 		else
 		  {
-		    if (r_type == R_OR1K_32)
-		      {
-			outrel.r_info = ELF32_R_INFO (0, R_OR1K_RELATIVE);
-			outrel.r_addend = relocation + rel->r_addend;
-		      }
-		    else
-		      {
-			BFD_FAIL ();
-			_bfd_error_handler
-			  (_("%pB: probably compiled without -fPIC?"),
-			   input_bfd);
-			bfd_set_error (bfd_error_bad_value);
-			return FALSE;
-		      }
+		    BFD_ASSERT (h->dynindx != -1);
+		    outrel.r_info = ELF32_R_INFO (h->dynindx, r_type);
+		    outrel.r_addend = rel->r_addend;
 		  }
 
 		loc = sreloc->contents;
@@ -1420,8 +1454,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 		/* Add DTPMOD and DTPOFF GOT and rela entries.  */
 		for (i = 0; i < 2; ++i)
 		  {
-		    rela.r_offset = sgot->output_section->vma +
-		      sgot->output_offset + gotoff + i*4;
+		    rela.r_offset = got_base + gotoff + i*4;
 		    if (h != NULL && h->dynindx != -1)
 		      {
 			rela.r_info = ELF32_R_INFO (h->dynindx,
@@ -1455,8 +1488,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	    else if (dynamic)
 	      {
 		/* Add TPOFF GOT and rela entries.  */
-		rela.r_offset = sgot->output_section->vma +
-		  sgot->output_offset + gotoff;
+		rela.r_offset = got_base + gotoff;
 		if (h != NULL && h->dynindx != -1)
 		  {
 		    rela.r_info = ELF32_R_INFO (h->dynindx, R_OR1K_TLS_TPOFF);
@@ -1551,7 +1583,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	}
     }
 
-  return TRUE;
+  return ret_val;
 }
 
 /* Return the section that should be marked against GC for a given
-- 
2.17.1

