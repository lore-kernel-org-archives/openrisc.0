From: Stafford Horne <shorne@gmail.com>
Date: Fri, 15 May 2020 06:00:16 +0900
Subject: [OpenRISC] [PATCH 6/8] or1k: refactor: Rename p to sec_relocs
In-Reply-To: <20200514210018.2749462-1-shorne@gmail.com>
References: <20200514210018.2749462-1-shorne@gmail.com>
Message-ID: <20200514210018.2749462-7-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The symbol name p was not very meaningful and causing me confusion
while debugging this code.  Change to a more meaninful name.

bfd/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* elf32-or1k.c (allocate_dynrelocs, readonly_dynrelocs,
	or1k_elf_check_relocs, or1k_elf_size_dynamic_sections): Rename
	p to sec_relocs.
---
 bfd/elf32-or1k.c | 86 ++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index ca1b61fe1c..22c316d042 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -2104,7 +2104,7 @@ or1k_elf_check_relocs (bfd *abfd,
 		    && (h->root.type == bfd_link_hash_defweak
 			|| !h->def_regular)))
 	      {
-		struct elf_dyn_relocs *p;
+		struct elf_dyn_relocs *sec_relocs;
 		struct elf_dyn_relocs **head;
 
 		/* When creating a shared object, we must copy these
@@ -2172,24 +2172,26 @@ or1k_elf_check_relocs (bfd *abfd,
 		    head = (struct elf_dyn_relocs **) vpp;
 		  }
 
-		p = *head;
-		if (p == NULL || p->sec != sec)
+		sec_relocs = *head;
+		/* Allocate this sections dynamic reolcations structure if this
+		   is a new section.  */
+		if (sec_relocs == NULL || sec_relocs->sec != sec)
 		  {
-		    size_t amt = sizeof *p;
-		    p = ((struct elf_dyn_relocs *)
-			 bfd_alloc (htab->root.dynobj, amt));
-		    if (p == NULL)
+		    size_t amt = sizeof *sec_relocs;
+		    sec_relocs = ((struct elf_dyn_relocs *)
+				  bfd_alloc (htab->root.dynobj, amt));
+		    if (sec_relocs == NULL)
 		      return FALSE;
-		    p->next = *head;
-		    *head = p;
-		    p->sec = sec;
-		    p->count = 0;
-		    p->pc_count = 0;
+		    sec_relocs->next = *head;
+		    *head = sec_relocs;
+		    sec_relocs->sec = sec;
+		    sec_relocs->count = 0;
+		    sec_relocs->pc_count = 0;
 		  }
 
-		p->count += 1;
+		sec_relocs->count += 1;
 		if (r_type == R_OR1K_INSN_REL_26)
-		  p->pc_count += 1;
+		  sec_relocs->pc_count += 1;
 	      }
 	  }
 	  break;
@@ -2549,15 +2551,17 @@ or1k_elf_reloc_type_class (const struct bfd_link_info *info ATTRIBUTE_UNUSED,
 static asection *
 readonly_dynrelocs (struct elf_link_hash_entry *h)
 {
-  struct elf_dyn_relocs *p;
+  struct elf_dyn_relocs *sec_relocs;
   struct elf_or1k_link_hash_entry *eh = (struct elf_or1k_link_hash_entry *) h;
 
-  for (p = eh->dyn_relocs; p != NULL; p = p->next)
+  for (sec_relocs = eh->dyn_relocs;
+       sec_relocs != NULL;
+       sec_relocs = sec_relocs->next)
     {
-      asection *s = p->sec->output_section;
+      asection *s = sec_relocs->sec->output_section;
 
       if (s != NULL && (s->flags & SEC_READONLY) != 0)
-	return p->sec;
+	return sec_relocs->sec;
     }
   return NULL;
 }
@@ -2750,7 +2754,7 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
   struct bfd_link_info *info;
   struct elf_or1k_link_hash_table *htab;
   struct elf_or1k_link_hash_entry *eh;
-  struct elf_dyn_relocs *p;
+  struct elf_dyn_relocs *sec_relocs;
 
   if (h->root.type == bfd_link_hash_indirect)
     return TRUE;
@@ -2863,14 +2867,14 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
 	{
 	  struct elf_dyn_relocs **pp;
 
-	  for (pp = &eh->dyn_relocs; (p = *pp) != NULL;)
+	  for (pp = &eh->dyn_relocs; (sec_relocs = *pp) != NULL;)
 	    {
-	      p->count -= p->pc_count;
-	      p->pc_count = 0;
-	      if (p->count == 0)
-		*pp = p->next;
+	      sec_relocs->count -= sec_relocs->pc_count;
+	      sec_relocs->pc_count = 0;
+	      if (sec_relocs->count == 0)
+		*pp = sec_relocs->next;
 	      else
-		pp = &p->next;
+		pp = &sec_relocs->next;
 	    }
 	}
 
@@ -2926,10 +2930,12 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
     }
 
   /* Finally, allocate space.  */
-  for (p = eh->dyn_relocs; p != NULL; p = p->next)
+  for (sec_relocs = eh->dyn_relocs;
+       sec_relocs != NULL;
+       sec_relocs = sec_relocs->next)
     {
-      asection *sreloc = elf_section_data (p->sec)->sreloc;
-      sreloc->size += p->count * sizeof (Elf32_External_Rela);
+      asection *sreloc = elf_section_data (sec_relocs->sec)->sreloc;
+      sreloc->size += sec_relocs->count * sizeof (Elf32_External_Rela);
     }
 
   return TRUE;
@@ -3009,26 +3015,28 @@ or1k_elf_size_dynamic_sections (bfd *output_bfd ATTRIBUTE_UNUSED,
 
       for (s = ibfd->sections; s != NULL; s = s->next)
 	{
-	  struct elf_dyn_relocs *p;
+	  struct elf_dyn_relocs *sec_relocs;
 
-	  for (p = ((struct elf_dyn_relocs *)
-		    elf_section_data (s)->local_dynrel);
-	       p != NULL;
-	       p = p->next)
+	  for (sec_relocs = ((struct elf_dyn_relocs *)
+			     elf_section_data (s)->local_dynrel);
+	       sec_relocs != NULL;
+	       sec_relocs = sec_relocs->next)
 	    {
-	      if (! bfd_is_abs_section (p->sec)
-		  && bfd_is_abs_section (p->sec->output_section))
+	      if (! bfd_is_abs_section (sec_relocs->sec)
+		  && bfd_is_abs_section (sec_relocs->sec->output_section))
 		{
 		  /* Input section has been discarded, either because
 		     it is a copy of a linkonce section or due to
 		     linker script /DISCARD/, so we'll be discarding
 		     the relocs too.  */
 		}
-	      else if (p->count != 0)
+	      else if (sec_relocs->count != 0)
 		{
-		  srel = elf_section_data (p->sec)->sreloc;
-		  srel->size += p->count * sizeof (Elf32_External_Rela);
-		  if ((p->sec->output_section->flags & SEC_READONLY) != 0)
+		  srel = elf_section_data (sec_relocs->sec)->sreloc;
+		  srel->size += sec_relocs->count
+				* sizeof (Elf32_External_Rela);
+		  if ((sec_relocs->sec->output_section->flags & SEC_READONLY)
+		      != 0)
 		    info->flags |= DF_TEXTREL;
 		}
 	    }
-- 
2.26.2

