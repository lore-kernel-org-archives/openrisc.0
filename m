From: Stafford Horne <shorne@gmail.com>
Date: Mon, 19 Apr 2021 09:05:23 +0900
Subject: [OpenRISC] [PATCH 3/4] or1k: Support cmodel=large when generating
 plt code
In-Reply-To: <20210419000524.3625897-1-shorne@gmail.com>
References: <20210419000524.3625897-1-shorne@gmail.com>
Message-ID: <20210419000524.3625897-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The current PLT generation code will generate invalid code when the PLT
relocation offset exceeds 64k.  This fixes the issue by taking advantage
of OpenRISC GCC's -mcmodel=large option.

When gcc is run with -mcmodel=large it will output gotha relocations to
handle GOT offsets larger than 64k.  Detect these relocations and use
them to trigger genration of PLT code that can handle large GOT offsets.

The "large" plt code needs 2 extra instructions to create 32-bit offsets.

I use a saw_gotha as its similar to what we did with saw_plta and it
seems to work.

bfd/ChangeLog:

	PR 27746
	* elf32-or1k.c (PLT_ENTRY_SIZE_LARGE, PLT_MAX_INSN_COUNT,
	OR1K_ADD, OR1K_ORI): New macros to help with plt creation.
	(elf_or1k_link_hash_table): New field saw_gotha.
	(elf_or1k_plt_entry_size): New functions.
	(or1k_write_plt_entry): Update to support variable size PLTs.
	(or1k_elf_finish_dynamic_sections): Support writing large PLT
	entries.
	(or1k_elf_finish_dynamic_symbol): Support generating PLT entries
	for large GOT offsets.
	(allocate_dynrelocs): Use elf_or1k_plt_entry_size to account for
	PLT size.

ld/ChangeLog:

	PR 27746
	testsuite/ld-or1k/or1k.exp (or1kplttests): Add tests for new PLT
	entry types.
	testsuite/ld-or1k/pltlarge1.dd: New file.
	testsuite/ld-or1k/pltlarge1.s: New file.
	testsuite/ld-or1k/pltlarge2.dd: New file.
	testsuite/ld-or1k/pltlarge2.s: New file
	testsuite/ld-or1k/pltlib.s (x): Define size to avoid link
	failure.
---
 bfd/elf32-or1k.c                  | 146 ++++++++++++++++++++++--------
 ld/testsuite/ld-or1k/or1k.exp     |   8 ++
 ld/testsuite/ld-or1k/pltlarge1.dd |  38 ++++++++
 ld/testsuite/ld-or1k/pltlarge1.s  |  24 +++++
 ld/testsuite/ld-or1k/pltlarge2.dd |  39 ++++++++
 ld/testsuite/ld-or1k/pltlarge2.s  |  25 +++++
 ld/testsuite/ld-or1k/pltlib.s     |   1 +
 7 files changed, 241 insertions(+), 40 deletions(-)
 create mode 100644 ld/testsuite/ld-or1k/pltlarge1.dd
 create mode 100644 ld/testsuite/ld-or1k/pltlarge1.s
 create mode 100644 ld/testsuite/ld-or1k/pltlarge2.dd
 create mode 100644 ld/testsuite/ld-or1k/pltlarge2.s

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 070397d5944..1a5b3319646 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -30,10 +30,14 @@
 #define N_ONES(X)	(((bfd_vma)2 << (X)) - 1)
 
 #define PLT_ENTRY_SIZE 16
+#define PLT_ENTRY_SIZE_LARGE (6*4)
+#define PLT_MAX_INSN_COUNT 6
 
 #define OR1K_MOVHI(D)		(0x18000000 | (D << 21))
 #define OR1K_ADRP(D)		(0x08000000 | (D << 21))
 #define OR1K_LWZ(D,A)		(0x84000000 | (D << 21) | (A << 16))
+#define OR1K_ADD(D,A,B)		(0xE0000000 | (D << 21) | (A << 16) | (B << 11))
+#define OR1K_ORI(D,A)		(0xA8000000 | (D << 21) | (A << 16))
 #define OR1K_ORI0(D)		(0xA8000000 | (D << 21))
 #define OR1K_JR(B)		(0x44000000 | (B << 11))
 #define OR1K_NOP		0x15000000
@@ -932,8 +936,15 @@ struct elf_or1k_link_hash_table
   struct elf_link_hash_table root;
 
   bool saw_plta;
+  bool saw_gotha;
 };
 
+static size_t
+elf_or1k_plt_entry_size (struct elf_or1k_link_hash_table *htab)
+{
+  return htab->saw_gotha ? PLT_ENTRY_SIZE_LARGE : PLT_ENTRY_SIZE;
+}
+
 /* Get the ELF linker hash table from a link_info structure.  */
 #define or1k_elf_hash_table(p) \
   ((is_elf_hash_table ((p)->hash)					\
@@ -2008,10 +2019,12 @@ or1k_elf_check_relocs (bfd *abfd,
 	    }
 	  break;
 
+	case R_OR1K_GOT_AHI16:
+	  htab->saw_gotha = true;
+	  /* FALLTHRU */
 	case R_OR1K_GOT16:
 	case R_OR1K_GOT_PG21:
 	case R_OR1K_GOT_LO13:
-	case R_OR1K_GOT_AHI16:
 	case R_OR1K_TLS_GD_HI16:
 	case R_OR1K_TLS_GD_LO16:
 	case R_OR1K_TLS_GD_PG21:
@@ -2211,33 +2224,46 @@ or1k_elf_check_relocs (bfd *abfd,
 }
 
 static void
-or1k_write_plt_entry (bfd *output_bfd, bfd_byte *contents, unsigned insn1,
-		      unsigned insn2, unsigned insn3, unsigned insnj)
+or1k_write_plt_entry (bfd *output_bfd, bfd_byte *contents, unsigned insnj,
+		      unsigned insns[], size_t insn_count)
 {
   unsigned nodelay = elf_elfheader (output_bfd)->e_flags & EF_OR1K_NODELAY;
-  unsigned insn4;
+  unsigned output_insns[PLT_MAX_INSN_COUNT];
+
+  /* Copy instructions into the output buffer.  */
+  for (size_t i = 0; i < insn_count; i++)
+    output_insns[i] = insns[i];
 
   /* Honor the no-delay-slot setting.  */
-  if (insn3 == OR1K_NOP)
+  if (insns[insn_count-1] == OR1K_NOP)
     {
-      insn4 = insn3;
+      unsigned slot1, slot2;
+
       if (nodelay)
-	insn3 = insnj;
+	slot1 = insns[insn_count-2], slot2 = insnj;
       else
-	insn3 = insn2, insn2 = insnj;
+	slot1 = insnj, slot2 = insns[insn_count-2];
+
+      output_insns[insn_count-2] = slot1;
+      output_insns[insn_count-1] = slot2;
+      output_insns[insn_count]   = OR1K_NOP;
     }
   else
     {
+      unsigned slot1, slot2;
+
       if (nodelay)
-	insn4 = insnj;
+	slot1 = insns[insn_count-1], slot2 = insnj;
       else
-	insn4 = insn3, insn3 = insnj;
+	slot1 = insnj, slot2 = insns[insn_count-1];
+
+      output_insns[insn_count-1] = slot1;
+      output_insns[insn_count]   = slot2;
     }
 
-  bfd_put_32 (output_bfd, insn1, contents);
-  bfd_put_32 (output_bfd, insn2, contents + 4);
-  bfd_put_32 (output_bfd, insn3, contents + 8);
-  bfd_put_32 (output_bfd, insn4, contents + 12);
+  /* Write out the output buffer.  */
+  for (size_t i = 0; i < (insn_count+1); i++)
+    bfd_put_32 (output_bfd, output_insns[i], contents + (i*4));
 }
 
 /* Finish up the dynamic sections.  */
@@ -2304,7 +2330,8 @@ or1k_elf_finish_dynamic_sections (bfd *output_bfd,
       splt = htab->root.splt;
       if (splt && splt->size > 0)
 	{
-	  unsigned plt0, plt1, plt2;
+	  unsigned plt[PLT_MAX_INSN_COUNT];
+	  size_t plt_insn_count = 3;
 	  bfd_vma got_addr = sgot->output_section->vma + sgot->output_offset;
 
 	  /* Note we force 16 byte alignment on the .got, so that
@@ -2315,27 +2342,35 @@ or1k_elf_finish_dynamic_sections (bfd *output_bfd,
 	      bfd_vma pc = splt->output_section->vma + splt->output_offset;
 	      unsigned pa = ((got_addr >> 13) - (pc >> 13)) & 0x1fffff;
 	      unsigned po = got_addr & 0x1fff;
-	      plt0 = OR1K_ADRP(12) | pa;
-	      plt1 = OR1K_LWZ(15,12) | (po + 8);
-	      plt2 = OR1K_LWZ(12,12) | (po + 4);
+	      plt[0] = OR1K_ADRP(12) | pa;
+	      plt[1] = OR1K_LWZ(15,12) | (po + 8);
+	      plt[2] = OR1K_LWZ(12,12) | (po + 4);
 	    }
 	  else if (bfd_link_pic (info))
 	    {
-	      plt0 = OR1K_LWZ(15, 16) | 8;	/* .got+8 */
-	      plt1 = OR1K_LWZ(12, 16) | 4;	/* .got+4 */
-	      plt2 = OR1K_NOP;
+	      plt[0] = OR1K_LWZ(15, 16) | 8;	/* .got+8 */
+	      plt[1] = OR1K_LWZ(12, 16) | 4;	/* .got+4 */
+	      plt[2] = OR1K_NOP;
 	    }
 	  else
 	    {
 	      unsigned ha = ((got_addr + 0x8000) >> 16) & 0xffff;
 	      unsigned lo = got_addr & 0xffff;
-	      plt0 = OR1K_MOVHI(12) | ha;
-	      plt1 = OR1K_LWZ(15,12) | (lo + 8);
-	      plt2 = OR1K_LWZ(12,12) | (lo + 4);
+	      plt[0] = OR1K_MOVHI(12) | ha;
+	      plt[1] = OR1K_LWZ(15,12) | (lo + 8);
+	      plt[2] = OR1K_LWZ(12,12) | (lo + 4);
 	    }
 
-	  or1k_write_plt_entry (output_bfd, splt->contents,
-				plt0, plt1, plt2, OR1K_JR(15));
+	  /* Fill large entries with 2 extra nops.  */
+	  if (htab->saw_gotha)
+	    {
+	      plt[3] = OR1K_NOP;
+	      plt[4] = OR1K_NOP;
+	      plt_insn_count = 5;
+	    }
+
+	  or1k_write_plt_entry (output_bfd, splt->contents, OR1K_JR(15),
+				plt, plt_insn_count);
 
 	  elf_section_data (splt->output_section)->this_hdr.sh_entsize = 4;
 	}
@@ -2378,7 +2413,8 @@ or1k_elf_finish_dynamic_symbol (bfd *output_bfd,
 
   if (h->plt.offset != (bfd_vma) -1)
     {
-      unsigned int plt0, plt1, plt2;
+      unsigned int plt[PLT_MAX_INSN_COUNT];
+      size_t plt_insn_count = 3;
       asection *splt;
       asection *sgot;
       asection *srela;
@@ -2407,7 +2443,7 @@ or1k_elf_finish_dynamic_symbol (bfd *output_bfd,
 	 corresponds to this symbol.  This is the index of this symbol
 	 in all the symbols for which we are making plt entries.  The
 	 first entry in the procedure linkage table is reserved.  */
-      plt_index = h->plt.offset / PLT_ENTRY_SIZE - 1;
+      plt_index = h->plt.offset / elf_or1k_plt_entry_size (htab) - 1;
       plt_addr = plt_base_addr + h->plt.offset;
       plt_reloc = plt_index * sizeof (Elf32_External_Rela);
 
@@ -2422,27 +2458,57 @@ or1k_elf_finish_dynamic_symbol (bfd *output_bfd,
 	{
 	  unsigned pa = ((got_addr >> 13) - (plt_addr >> 13)) & 0x1fffff;
 	  unsigned po = (got_addr & 0x1fff);
-	  plt0 = OR1K_ADRP(12) | pa;
-	  plt1 = OR1K_LWZ(12,12) | po;
-	  plt2 = OR1K_ORI0(11) | plt_reloc;
+	  plt[0] = OR1K_ADRP(12) | pa;
+	  plt[1] = OR1K_LWZ(12,12) | po;
+	  plt[2] = OR1K_ORI0(11) | plt_reloc;
 	}
       else if (bfd_link_pic (info))
 	{
-	  plt0 = OR1K_LWZ(12,16) | got_offset;
-	  plt1 = OR1K_ORI0(11) | plt_reloc;
-	  plt2 = OR1K_NOP;
+	  if (htab->saw_gotha)
+	    {
+	      unsigned gotha = ((got_offset + 0x8000) >> 16) & 0xffff;
+	      unsigned got = got_offset & 0xffff;
+	      unsigned pltrelhi = (plt_reloc >> 16) & 0xffff;
+	      unsigned pltrello = plt_reloc & 0xffff;
+
+	      plt[0] = OR1K_MOVHI(12) | gotha;
+	      plt[1] = OR1K_ADD(12,12,16);
+	      plt[2] = OR1K_LWZ(12,12) | got;
+	      plt[3] = OR1K_MOVHI(11) | pltrelhi;
+	      plt[4] = OR1K_ORI(11,11) | pltrello;
+	      plt_insn_count = 5;
+	    }
+	  else
+	    {
+	      plt[0] = OR1K_LWZ(12,16) | got_offset;
+	      plt[1] = OR1K_ORI0(11) | plt_reloc;
+	      plt[2] = OR1K_NOP;
+	    }
 	}
       else
 	{
 	  unsigned ha = ((got_addr + 0x8000) >> 16) & 0xffff;
 	  unsigned lo = got_addr & 0xffff;
-	  plt0 = OR1K_MOVHI(12) | ha;
-	  plt1 = OR1K_LWZ(12,12) | lo;
-	  plt2 = OR1K_ORI0(11) | plt_reloc;
+	  plt[0] = OR1K_MOVHI(12) | ha;
+	  plt[1] = OR1K_LWZ(12,12) | lo;
+	  plt[2] = OR1K_ORI0(11) | plt_reloc;
+	}
+
+      /* For large code model we fixup the non-PIC PLT relocation instructions
+	 here.  */
+      if (htab->saw_gotha && !bfd_link_pic (info))
+	{
+	  unsigned pltrelhi = (plt_reloc >> 16) & 0xffff;
+	  unsigned pltrello = plt_reloc & 0xffff;
+
+	  plt[2] = OR1K_MOVHI(11) | pltrelhi;
+	  plt[3] = OR1K_ORI(11,11) | pltrello;
+	  plt[4] = OR1K_NOP;
+	  plt_insn_count = 5;
 	}
 
       or1k_write_plt_entry (output_bfd, splt->contents + h->plt.offset,
-			    plt0, plt1, plt2, OR1K_JR(12));
+			    OR1K_JR(12), plt, plt_insn_count);
 
       /* Fill in the entry in the global offset table.  We initialize it to
 	 point to the top of the plt.  This is done to lazy lookup the actual
@@ -2770,7 +2836,7 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
 	  /* If this is the first .plt entry, make room for the special
 	     first entry.  */
 	  if (splt->size == 0)
-	    splt->size = PLT_ENTRY_SIZE;
+	    splt->size = elf_or1k_plt_entry_size (htab);
 
 	  h->plt.offset = splt->size;
 
@@ -2787,7 +2853,7 @@ allocate_dynrelocs (struct elf_link_hash_entry *h, void * inf)
 	    }
 
 	  /* Make room for this entry.  */
-	  splt->size += PLT_ENTRY_SIZE;
+	  splt->size += elf_or1k_plt_entry_size (htab);
 
 	  /* We also need to make an entry in the .got.plt section, which
 	     will be placed in the .got section by the linker script.  */
diff --git a/ld/testsuite/ld-or1k/or1k.exp b/ld/testsuite/ld-or1k/or1k.exp
index 8bb943aacc9..a17ce0eee8e 100644
--- a/ld/testsuite/ld-or1k/or1k.exp
+++ b/ld/testsuite/ld-or1k/or1k.exp
@@ -53,6 +53,14 @@ set or1kplttests {
      "" {plt1.s}
      {{objdump -dr plt1.x.dd}}
      "plt1.x"}
+    {"PLT exec large" "tmpdir/libpltlib.so" ""
+     "" {pltlarge1.s}
+     {{objdump -dr pltlarge1.dd}}
+     "pltlarge1.x"}
+    {"PLT large -fpic -shared" "-fpic -shared" ""
+     "" {pltlarge2.s}
+     {{objdump -dr pltlarge2.dd}}
+     "pltlarge2.x"}
 }
 
 # Not implemented yet
diff --git a/ld/testsuite/ld-or1k/pltlarge1.dd b/ld/testsuite/ld-or1k/pltlarge1.dd
new file mode 100644
index 00000000000..623dfa0557c
--- /dev/null
+++ b/ld/testsuite/ld-or1k/pltlarge1.dd
@@ -0,0 +1,38 @@
+
+.*\.x:     file format elf32-or1k
+
+
+Disassembly of section \.plt:
+
+00002170 <\.plt>:
+ +[0-9a-f]+:	19 80 00 00 	l\.movhi r12,0x0
+ +[0-9a-f]+:	85 ec [0-9a-f]+ [0-9a-f]+ 	l\.lwz r15,[0-9]+\(r12\)
+ +[0-9a-f]+:	85 8c [0-9a-f]+ [0-9a-f]+ 	l\.lwz r12,[0-9]+\(r12\)
+ +[0-9a-f]+:	44 00 78 00 	l\.jr r15
+ +[0-9a-f]+:	15 00 00 00 	l\.nop 0x0
+ +[0-9a-f]+:	15 00 00 00 	l\.nop 0x0
+ +[0-9a-f]+:	19 80 00 00 	l\.movhi r12,0x0
+ +[0-9a-f]+:	85 8c [0-9a-f]+ [0-9a-f]+ 	l\.lwz r12,[0-9]+\(r12\)
+ +[0-9a-f]+:	19 60 00 00 	l\.movhi r11,0x0
+ +[0-9a-f]+:	44 00 60 00 	l\.jr r12
+ +[0-9a-f]+:	a9 6b 00 00 	l\.ori r11,r11,0x0
+ +[0-9a-f]+:	15 00 00 00 	l\.nop 0x0
+
+Disassembly of section \.text:
+
+000021a0 <_start>:
+ +[0-9a-f]+:	9c 21 ff fc 	l\.addi r1,r1,-4
+ +[0-9a-f]+:	d4 01 48 00 	l\.sw 0\(r1\),r9
+ +[0-9a-f]+:	04 00 00 02 	l\.jal [0-9a-f]+ <_start\+0x10>
+ +[0-9a-f]+:	1a 60 00 00 	l\.movhi r19,0x0
+ +[0-9a-f]+:	aa 73 [0-9a-f]+ [0-9a-f]+ 	l\.ori r19,r19,0x[0-9a-f]+
+ +[0-9a-f]+:	e2 73 48 00 	l\.add r19,r19,r9
+ +[0-9a-f]+:	1a 20 00 00 	l\.movhi r17,0x0
+ +[0-9a-f]+:	e2 31 98 00 	l\.add r17,r17,r19
+ +[0-9a-f]+:	86 31 00 10 	l\.lwz r17,16\(r17\)
+ +[0-9a-f]+:	84 71 00 00 	l\.lwz r3,0\(r17\)
+ +[0-9a-f]+:	07 ff ff f0 	l\.jal [0-9a-f]+ <\.plt\+0x18>
+ +[0-9a-f]+:	15 00 00 00 	l\.nop 0x0
+ +[0-9a-f]+:	85 21 00 00 	l\.lwz r9,0\(r1\)
+ +[0-9a-f]+:	44 00 48 00 	l\.jr r9
+ +[0-9a-f]+:	9c 21 00 04 	l\.addi r1,r1,4
diff --git a/ld/testsuite/ld-or1k/pltlarge1.s b/ld/testsuite/ld-or1k/pltlarge1.s
new file mode 100644
index 00000000000..42b16db425c
--- /dev/null
+++ b/ld/testsuite/ld-or1k/pltlarge1.s
@@ -0,0 +1,24 @@
+	.data
+	.p2align 16
+
+	.text
+	.globl	_start
+_start:
+	l.addi	r1, r1, -4
+	l.sw	0(r1), r9
+
+	l.jal	8
+	 l.movhi	r19, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
+	l.ori	r19, r19, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
+	l.add	r19, r19, r9
+
+	l.movhi	r17, gotha(x)
+	l.add	r17, r17, r19
+	l.lwz	r17, got(x)(r17)
+	l.lwz	r3, 0(r17)
+
+	l.jal	plt(func)
+	 l.nop
+	l.lwz	r9, 0(r1)
+	l.jr	r9
+	 l.addi	r1, r1, 4
diff --git a/ld/testsuite/ld-or1k/pltlarge2.dd b/ld/testsuite/ld-or1k/pltlarge2.dd
new file mode 100644
index 00000000000..140cc96777c
--- /dev/null
+++ b/ld/testsuite/ld-or1k/pltlarge2.dd
@@ -0,0 +1,39 @@
+
+.*\.x:     file format elf32-or1k
+
+
+Disassembly of section \.plt:
+
+[0-9a-f]+ <\.plt>:
+ +[0-9a-f]+:	85 f0 00 08 	l\.lwz r15,8\(r16\)
+ +[0-9a-f]+:	85 90 00 04 	l\.lwz r12,4\(r16\)
+ +[0-9a-f]+:	15 00 00 00 	l\.nop 0x0
+ +[0-9a-f]+:	44 00 78 00 	l\.jr r15
+ +[0-9a-f]+:	15 00 00 00 	l\.nop 0x0
+ +[0-9a-f]+:	15 00 00 00 	l\.nop 0x0
+ +[0-9a-f]+:	19 80 00 00 	l\.movhi r12,0x0
+ +[0-9a-f]+:	e1 8c 80 00 	l\.add r12,r12,r16
+ +[0-9a-f]+:	85 8c 00 0c 	l\.lwz r12,12\(r12\)
+ +[0-9a-f]+:	19 60 00 00 	l\.movhi r11,0x0
+ +[0-9a-f]+:	44 00 60 00 	l\.jr r12
+ +[0-9a-f]+:	a9 6b 00 00 	l\.ori r11,r11,0x0
+
+Disassembly of section \.text:
+
+[0-9a-f]+ <test>:
+ +[0-9a-f]+:	9c 21 ff f8 	l\.addi r1,r1,-8
+ +[0-9a-f]+:	d4 01 80 00 	l\.sw 0\(r1\),r16
+ +[0-9a-f]+:	d4 01 48 04 	l\.sw 4\(r1\),r9
+ +[0-9a-f]+:	04 00 [0-9a-f]+ [0-9a-f]+ 	l\.jal [0-9a-f]+ <test\+0x14>
+ +[0-9a-f]+:	1a 00 00 00 	l\.movhi r16,0x0
+ +[0-9a-f]+:	aa 10 [0-9a-f]+ [0-9a-f]+ 	l\.ori r16,r16,0x[0-9a-f]+
+ +[0-9a-f]+:	e2 10 48 00 	l\.add r16,r16,r9
+ +[0-9a-f]+:	1a 20 00 00 	l\.movhi r17,0x0
+ +[0-9a-f]+:	e2 31 80 00 	l\.add r17,r17,r16
+ +[0-9a-f]+:	86 31 00 10 	l\.lwz r17,16\(r17\)
+ +[0-9a-f]+:	07 ff ff f0 	l\.jal [0-9a-f]+ <\.plt\+0x18>
+ +[0-9a-f]+:	84 71 00 00 	l\.lwz r3,0\(r17\)
+ +[0-9a-f]+:	85 21 00 04 	l\.lwz r9,4\(r1\)
+ +[0-9a-f]+:	86 01 00 00 	l\.lwz r16,0\(r1\)
+ +[0-9a-f]+:	44 00 48 00 	l\.jr r9
+ +[0-9a-f]+:	9c 21 00 08 	l\.addi r1,r1,8
diff --git a/ld/testsuite/ld-or1k/pltlarge2.s b/ld/testsuite/ld-or1k/pltlarge2.s
new file mode 100644
index 00000000000..665578c67c1
--- /dev/null
+++ b/ld/testsuite/ld-or1k/pltlarge2.s
@@ -0,0 +1,25 @@
+	.section	.text
+	.align 4
+	.global	test
+	.type	test, @function
+test:
+	l.addi	r1, r1, -8
+	l.sw	0(r1), r16
+	l.sw	4(r1), r9
+
+	l.jal	8
+	 l.movhi	r16, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
+	l.ori	r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
+	l.add	r16, r16, r9
+
+	l.movhi	r17, gotha(i)
+	l.add	r17, r17, r16
+	l.lwz	r17, got(i)(r17)
+
+	l.jal	plt(func)
+	 l.lwz	r3, 0(r17)
+
+	l.lwz	r9, 4(r1)
+	l.lwz	r16, 0(r1)
+	l.jr	r9
+	 l.addi	r1, r1, 8
diff --git a/ld/testsuite/ld-or1k/pltlib.s b/ld/testsuite/ld-or1k/pltlib.s
index baf76ca1af7..8b4d7ba48fd 100644
--- a/ld/testsuite/ld-or1k/pltlib.s
+++ b/ld/testsuite/ld-or1k/pltlib.s
@@ -1,5 +1,6 @@
 	.section .data
 	.globl x, y
+	.size x, 4
 x:	.long 33
 y:	.long 44
 
-- 
2.26.2

