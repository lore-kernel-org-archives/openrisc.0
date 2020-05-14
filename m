From: Stafford Horne <shorne@gmail.com>
Date: Fri, 15 May 2020 06:00:15 +0900
Subject: [OpenRISC] [PATCH 5/8] or1k: TLS offset to use tcb size and section
 alignment
In-Reply-To: <20200514210018.2749462-1-shorne@gmail.com>
References: <20200514210018.2749462-1-shorne@gmail.com>
Message-ID: <20200514210018.2749462-6-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The offset was wrong and causing issues when the TLS section alignment
is larger than TCB_SIZE.

In or1k we have:

                 /- TP
                V
[ Pthread | TCB 0x0 0x0 0x0 | TDATA , TBSS ]

Here TDATA is not at TP, but TDATA is offset by the alignment.  TP points
to just after the TCB.  With this patch I adjust for that TCB padding
due to alignment which was not being properly accounted for before.

This allows glibc nptl and elf tests to pass.

bfd/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* elf32-or1k.c (TCB_SIZE): New macro.
	(tpoff): Use TCB_SIZE and alignment to calculate offset.
---
 bfd/elf32-or1k.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index eee418c558..ca1b61fe1c 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -884,6 +884,9 @@ static const struct or1k_reloc_map or1k_reloc_map[] =
 #define TLS_IE	       8
 #define TLS_LE	      16
 
+/* The size of the TLS thread control block, used to offset LE access.  */
+#define TCB_SIZE      16
+
 /* ELF linker hash entry.  */
 struct elf_or1k_link_hash_entry
 {
@@ -1052,14 +1055,22 @@ or1k_info_to_howto_rela (bfd * abfd,
 static bfd_vma
 tpoff (struct bfd_link_info *info, bfd_vma address)
 {
+  struct elf_link_hash_table *htab = elf_hash_table (info);
+  bfd_vma base;
+
   /* If tls_sec is NULL, we should have signalled an error already.  */
-  if (elf_hash_table (info)->tls_sec == NULL)
+  if (htab->tls_sec == NULL)
     return 0;
 
+  /* On or1k, the tp points to just after the tcb, if we have an alignment
+     greater than the tcb size we need to offset by the alignment difference.  */
+  base = align_power ((bfd_vma) TCB_SIZE, htab->tls_sec->alignment_power)
+	 - TCB_SIZE;
+
   /* The thread pointer on or1k stores the address after the TCB where
      the data is, just compute the difference. No need to compensate
      for the size of TCB.  */
-  return (address - elf_hash_table (info)->tls_sec->vma);
+  return address - htab->tls_sec->vma + base;
 }
 
 /* If we have both IE and GD accesses to a symbol the IE relocations should be
-- 
2.26.2

