From: Stafford Horne <shorne@gmail.com>
Date: Fri, 15 May 2020 06:00:12 +0900
Subject: [OpenRISC] [PATCH 2/8] or1k: Fix dynamic TLS symbol flag
In-Reply-To: <20200514210018.2749462-1-shorne@gmail.com>
References: <20200514210018.2749462-1-shorne@gmail.com>
Message-ID: <20200514210018.2749462-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The dynamic flag used for TLS relocations was not properly being set
for some cases causing link failure.  The fix here was mostly copied
from other BFD implementations.

bfd/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* bfd/elf32-or1k.c (or1k_elf_relocate_section): Fixup dynamic
	symbol detection.
---
 bfd/elf32-or1k.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 221a14c5b1..99a36c7f04 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -1592,6 +1592,7 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	    asection *srelgot;
 	    bfd_byte *loc;
 	    int dynamic;
+	    int indx = 0;
 
 	    srelgot = htab->root.srelgot;
 
@@ -1618,13 +1619,23 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	    BFD_ASSERT (elf_hash_table (info)->hgot == NULL
 			|| elf_hash_table (info)->hgot->root.u.def.value == 0);
 
+	    if (h != NULL)
+	      {
+		bfd_boolean dyn = htab->root.dynamic_sections_created;
+		bfd_boolean pic = bfd_link_pic (info);
+
+		if (WILL_CALL_FINISH_DYNAMIC_SYMBOL (dyn, pic, h)
+		    && (!pic || !SYMBOL_REFERENCES_LOCAL (info, h)))
+		  indx = h->dynindx;
+	      }
+
 	    /* Dynamic entries will require relocations.  If we do not need
 	       them we will just use the default R_OR1K_NONE and
 	       not set anything.  */
-	    dynamic = bfd_link_pic (info)
-	      || (sec && (sec->flags & SEC_ALLOC) != 0
-		  && h != NULL
-		  && (h->root.type == bfd_link_hash_defweak || !h->def_regular));
+	    dynamic = (bfd_link_pic (info) || indx != 0)
+		       && (h == NULL
+			   || ELF_ST_VISIBILITY (h->other) == STV_DEFAULT
+			   || h->root.type != bfd_link_hash_undefweak);
 
 	    /* Shared GD.  */
 	    if (dynamic
-- 
2.26.2

