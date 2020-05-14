From: Stafford Horne <shorne@gmail.com>
Date: Fri, 15 May 2020 06:00:13 +0900
Subject: [OpenRISC] [PATCH 3/8] or1k: Add TLS mask to handle multiple model
 access
In-Reply-To: <20200514210018.2749462-1-shorne@gmail.com>
References: <20200514210018.2749462-1-shorne@gmail.com>
Message-ID: <20200514210018.2749462-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

In cases where a variable is accessed both via GD and IE the GOT was not
getting setup correctly and causing failures.  This was noticed running
the glibc testsuite.

This patch uses tls_type as a bitmask to allow for handling multiple
access types to TLS symbols.

bfd/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* bfd/elf32-or1k.c (or1k_set_got_and_rela_sizes): New function.
	(or1k_initial_exec_offset): New function.
	(TLS_GD, TLS_IE, TLS_LD, TLS_LE): Redefine macros as masks.
	(or1k_elf_relocate_section): Allow for TLS to handle multiple
	model access.
	(or1k_elf_check_relocs): Use OR to set TLS access.
	(allocate_dynrelocs): Use or1k_set_got_and_rela_sizes to set
	sizes.
	(or1k_elf_size_dynamic_sections): Use
	or1k_set_got_and_rela_sizes to set sizes.
---
 bfd/elf32-or1k.c | 149 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 46 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 99a36c7f04..acfdb5bef2 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -873,12 +873,16 @@ static const struct or1k_reloc_map or1k_reloc_map[] =
   { BFD_RELOC_OR1K_PLTA26,	R_OR1K_PLTA26 },
 };
 
+/* tls_type is a mask used to track how each symbol is accessed,
+   it may be accessed via multiple types of TLS access methods.
+   We track this for sizing (allocating got + relocation section space) and
+   for how to process relocations.  */
 #define TLS_UNKNOWN    0
 #define TLS_NONE       1
 #define TLS_GD	       2
-#define TLS_LD	       3
-#define TLS_IE	       4
-#define TLS_LE	       5
+#define TLS_LD	       4
+#define TLS_IE	       8
+#define TLS_LE	      16
 
 /* ELF linker hash entry.  */
 struct elf_or1k_link_hash_entry
@@ -1058,6 +1062,24 @@ tpoff (struct bfd_link_info *info, bfd_vma address)
   return (address - elf_hash_table (info)->tls_sec->vma);
 }
 
+/* If we have both IE and GD accesses to a symbol the IE relocations should be
+   offset by 8 bytes because the got contains both GD and IE entries.  */
+static bfd_vma
+or1k_initial_exec_offset (reloc_howto_type *howto, unsigned char tls_type_mask)
+{
+   switch (howto->type)
+     {
+     case R_OR1K_TLS_IE_HI16:
+     case R_OR1K_TLS_IE_LO16:
+     case R_OR1K_TLS_IE_PG21:
+     case R_OR1K_TLS_IE_LO13:
+     case R_OR1K_TLS_IE_AHI16:
+       return (tls_type_mask & TLS_GD) != 0 ? 8 : 0;
+     default:
+       return 0;
+     }
+}
+
 /* Like _bfd_final_link_relocate, but handles non-contiguous fields.  */
 
 static bfd_reloc_status_type
@@ -1593,19 +1615,26 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	    bfd_byte *loc;
 	    int dynamic;
 	    int indx = 0;
+	    unsigned char tls_type;
 
 	    srelgot = htab->root.srelgot;
 
 	    /* Mark as TLS related GOT entry by setting
-	       bit 2 as well as bit 1.  */
+	       bit 2 to indcate TLS and bit 1 to indicate GOT.  */
 	    if (h != NULL)
 	      {
 		gotoff = h->got.offset;
+		tls_type = ((struct elf_or1k_link_hash_entry *) h)->tls_type;
 		h->got.offset |= 3;
 	      }
 	    else
 	      {
+		unsigned char *local_tls_type;
+
 		gotoff = local_got_offsets[r_symndx];
+		local_tls_type = (unsigned char *) elf_or1k_local_tls_type (input_bfd);
+		tls_type = local_tls_type == NULL ? TLS_NONE
+						  : local_tls_type[r_symndx];
 		local_got_offsets[r_symndx] |= 3;
 	      }
 
@@ -1638,11 +1667,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 			   || h->root.type != bfd_link_hash_undefweak);
 
 	    /* Shared GD.  */
-	    if (dynamic
-		&& (howto->type == R_OR1K_TLS_GD_HI16
-		    || howto->type == R_OR1K_TLS_GD_LO16
-		    || howto->type == R_OR1K_TLS_GD_PG21
-		    || howto->type == R_OR1K_TLS_GD_LO13))
+	    if (dynamic && ((tls_type & TLS_GD) != 0))
 	      {
 		int i;
 
@@ -1674,17 +1699,17 @@ or1k_elf_relocate_section (bfd *output_bfd,
 		  }
 	      }
 	    /* Static GD.  */
-	    else if (howto->type == R_OR1K_TLS_GD_HI16
-		     || howto->type == R_OR1K_TLS_GD_LO16
-		     || howto->type == R_OR1K_TLS_GD_PG21
-		     || howto->type == R_OR1K_TLS_GD_LO13)
+	    else if ((tls_type & TLS_GD) != 0)
 	      {
 		bfd_put_32 (output_bfd, 1, sgot->contents + gotoff);
 		bfd_put_32 (output_bfd, tpoff (info, relocation),
 		    sgot->contents + gotoff + 4);
 	      }
+
+	    gotoff += or1k_initial_exec_offset (howto, tls_type);
+
 	    /* Shared IE.  */
-	    else if (dynamic)
+	    if (dynamic && ((tls_type & TLS_IE) != 0))
 	      {
 		BFD_ASSERT (srelgot->contents != NULL);
 
@@ -1708,11 +1733,9 @@ or1k_elf_relocate_section (bfd *output_bfd,
 		bfd_put_32 (output_bfd, 0, sgot->contents + gotoff);
 	      }
 	    /* Static IE.  */
-	    else
-	      {
-		bfd_put_32 (output_bfd, tpoff (info, relocation),
-			    sgot->contents + gotoff);
-	      }
+	    else if ((tls_type & TLS_IE) != 0)
+	      bfd_put_32 (output_bfd, tpoff (info, relocation),
+			  sgot->contents + gotoff);
 
 	    /* The PG21 and LO13 relocs are pc-relative, while the
 	       rest are GOT relative.  */
@@ -1909,7 +1932,7 @@ or1k_elf_check_relocs (bfd *abfd,
 
       /* Record TLS type.  */
       if (h != NULL)
-	  ((struct elf_or1k_link_hash_entry *) h)->tls_type = tls_type;
+	  ((struct elf_or1k_link_hash_entry *) h)->tls_type |= tls_type;
       else
 	{
 	  unsigned char *local_tls_type;
@@ -1926,7 +1949,7 @@ or1k_elf_check_relocs (bfd *abfd,
 		return FALSE;
 	      elf_or1k_local_tls_type (abfd) = local_tls_type;
 	    }
-	  local_tls_type[r_symndx] = tls_type;
+	  local_tls_type[r_symndx] |= tls_type;
 	}
 
       switch (r_type)
@@ -2648,6 +2671,56 @@ or1k_elf_adjust_dynamic_symbol (struct bfd_link_info *info,
   return _bfd_elf_adjust_dynamic_copy (info, h, s);
 }
 
+/* Caclulate an update the sizes required for a symbol in the GOT and
+   RELA relocation section based on the TLS_TYPE and whether or not the symbol
+   is DYNAMIC.
+
+   Symbols with TLS_GD access require 8 bytes in the GOT and, if dynamic,
+   require two relocation entries.  Symbols with TLS_IE access require 4 bytes
+   in the GOT and, if dynamic, require one relocation entry.  Symbols may have
+   both TLS_GD and TLS_IE access to be accounted for.
+
+   Other symbols require 4 bytes in the GOT table and, if dynamic, require one
+   relocation entry.  */
+
+static void
+or1k_set_got_and_rela_sizes (const unsigned char tls_type,
+			     const bfd_boolean dynamic,
+			     bfd_vma *got_size,
+			     bfd_vma *rela_size)
+{
+  bfd_boolean is_tls_entry = FALSE;
+
+  /* TLS GD requires two GOT entries and two relocs.  */
+  if ((tls_type & TLS_GD) != 0)
+    {
+      *got_size += 8;
+      is_tls_entry = TRUE;
+    }
+
+  if ((tls_type & TLS_IE) != 0)
+    {
+      *got_size += 4;
+      is_tls_entry = TRUE;
+    }
+
+  if (is_tls_entry == FALSE)
+    *got_size += 4;
+
+  if (dynamic)
+    {
+      if ((tls_type & TLS_GD) != 0)
+	*rela_size += 2 * sizeof (Elf32_External_Rela);
+
+      if ((tls_type & TLS_IE) != 0)
+	*rela_size += sizeof (Elf32_External_Rela);
+
+      if (is_tls_entry == FALSE)
+	*rela_size += sizeof (Elf32_External_Rela);
+    }
+}
+
+
 /* Allocate space in .plt, .got and associated reloc sections for
    dynamic relocs.  */
 
@@ -2747,19 +2820,10 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
 
       tls_type = ((struct elf_or1k_link_hash_entry *) h)->tls_type;
 
-      /* TLS GD requires two GOT and two relocs.  */
-      if (tls_type == TLS_GD)
-	s->size += 8;
-      else
-	s->size += 4;
       dyn = htab->root.dynamic_sections_created;
-      if (WILL_CALL_FINISH_DYNAMIC_SYMBOL (dyn, bfd_link_pic (info), h))
-	{
-	  if (tls_type == TLS_GD)
-	    htab->root.srelgot->size += 2 * sizeof (Elf32_External_Rela);
-	  else
-	    htab->root.srelgot->size += sizeof (Elf32_External_Rela);
-	}
+      dyn = WILL_CALL_FINISH_DYNAMIC_SYMBOL (dyn, bfd_link_pic (info), h);
+      or1k_set_got_and_rela_sizes (tls_type, dyn,
+				   &s->size, &htab->root.srelgot->size);
     }
   else
     h->got.offset = (bfd_vma) -1;
@@ -2964,20 +3028,13 @@ or1k_elf_size_dynamic_sections (bfd *output_bfd ATTRIBUTE_UNUSED,
 	{
 	  if (*local_got > 0)
 	    {
-	      *local_got = s->size;
+	      unsigned char tls_type = (local_tls_type == NULL)
+					? TLS_UNKNOWN
+					: *local_tls_type;
 
-	      /* TLS GD requires two GOT and two relocs.  */
-	      if (local_tls_type != NULL && *local_tls_type == TLS_GD)
-		s->size += 8;
-	      else
-		s->size += 4;
-	      if (bfd_link_pic (info))
-		{
-		  if (local_tls_type != NULL && *local_tls_type == TLS_GD)
-		    srel->size += 2 * sizeof (Elf32_External_Rela);
-		  else
-		    srel->size += sizeof (Elf32_External_Rela);
-		}
+	      *local_got = s->size;
+	      or1k_set_got_and_rela_sizes (tls_type, bfd_link_pic (info),
+					   &s->size, &srel->size);
 	    }
 	  else
 
-- 
2.26.2

