From: Stafford Horne <shorne@gmail.com>
Date: Fri, 15 May 2020 06:00:17 +0900
Subject: [OpenRISC] [PATCH 7/8] or1k: refactor: Rename s to sgot and splt
In-Reply-To: <20200514210018.2749462-1-shorne@gmail.com>
References: <20200514210018.2749462-1-shorne@gmail.com>
Message-ID: <20200514210018.2749462-8-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The symbol name s for section is terse, replacing with sgot when it
refers to the got and splt when it refers to the plt makes reading code
a bit easier.

bfd/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* elf32-or1k.c (allocate_dynrelocs): Rename s to splt or sgot
	based on usage.
---
 bfd/elf32-or1k.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 22c316d042..7ac34737aa 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -2780,14 +2780,14 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
 
       if (WILL_CALL_FINISH_DYNAMIC_SYMBOL (1, bfd_link_pic (info), h))
 	{
-	  asection *s = htab->root.splt;
+	  asection *splt = htab->root.splt;
 
 	  /* If this is the first .plt entry, make room for the special
 	     first entry.  */
-	  if (s->size == 0)
-	    s->size = PLT_ENTRY_SIZE;
+	  if (splt->size == 0)
+	    splt->size = PLT_ENTRY_SIZE;
 
-	  h->plt.offset = s->size;
+	  h->plt.offset = splt->size;
 
 	  /* If this symbol is not defined in a regular file, and we are
 	     not generating a shared library, then set the symbol to this
@@ -2797,12 +2797,12 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
 	  if (! bfd_link_pic (info)
 	      && !h->def_regular)
 	    {
-	      h->root.u.def.section = s;
+	      h->root.u.def.section = splt;
 	      h->root.u.def.value = h->plt.offset;
 	    }
 
 	  /* Make room for this entry.  */
-	  s->size += PLT_ENTRY_SIZE;
+	  splt->size += PLT_ENTRY_SIZE;
 
 	  /* We also need to make an entry in the .got.plt section, which
 	     will be placed in the .got section by the linker script.  */
@@ -2825,7 +2825,7 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
 
   if (h->got.refcount > 0)
     {
-      asection *s;
+      asection *sgot;
       bfd_boolean dyn;
       unsigned char tls_type;
 
@@ -2838,16 +2838,16 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
 	    return FALSE;
 	}
 
-      s = htab->root.sgot;
+      sgot = htab->root.sgot;
 
-      h->got.offset = s->size;
+      h->got.offset = sgot->size;
 
       tls_type = ((struct elf_or1k_link_hash_entry *) h)->tls_type;
 
       dyn = htab->root.dynamic_sections_created;
       dyn = WILL_CALL_FINISH_DYNAMIC_SYMBOL (dyn, bfd_link_pic (info), h);
       or1k_set_got_and_rela_sizes (tls_type, dyn,
-				   &s->size, &htab->root.srelgot->size);
+				   &sgot->size, &htab->root.srelgot->size);
     }
   else
     h->got.offset = (bfd_vma) -1;
-- 
2.26.2

