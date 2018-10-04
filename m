From: Nick Clifton <nickc@redhat.com>
Date: Thu, 4 Oct 2018 16:33:15 +0100
Subject: [OpenRISC] [PATCH v3 3/5] or1k: Add the l.adrp insn and
 supporting relocations
In-Reply-To: <20181004032317.17478-4-shorne@gmail.com>
References: <20181004032317.17478-1-shorne@gmail.com>
 <20181004032317.17478-4-shorne@gmail.com>
Message-ID: <10dcf643-7acd-84a9-4cf1-0fc2ea2844a7@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

> yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>
> 
> bfd/ChangeLog:
> 
> 	* bfd-in2.h: Regenerated.
> 	* elf32-or1k.c: (or1k_elf_howto_table): Fix formatting for
> 	R_OR1K_PLT26, Add R_OR1K_PCREL_PG21, R_OR1K_GOT_PG21,
> 	R_OR1K_TLS_GD_PG21, R_OR1K_TLS_LDM_PG21, R_OR1K_TLS_IE_PG21,
> 	R_OR1K_LO13, R_OR1K_GOT_LO13, R_OR1K_TLS_GD_LO13, R_OR1K_TLS_LDM_LO13,
> 	R_OR1K_TLS_IE_LO13, R_OR1K_SLO13, R_OR1K_PLTA26.
> 	(or1k_reloc_map): Add BFD_RELOC_OR1K_PCREL_PG21,
> 	BFD_RELOC_OR1K_GOT_PG21, BFD_RELOC_OR1K_TLS_GD_PG21,
> 	BFD_RELOC_OR1K_TLS_LDM_PG21, BFD_RELOC_OR1K_TLS_IE_PG21,
> 	BFD_RELOC_OR1K_LO13, BFD_RELOC_OR1K_GOT_LO13,
> 	BFD_RELOC_OR1K_TLS_GD_LO13, BFD_RELOC_OR1K_TLS_GD_LO13,
> 	BFD_RELOC_OR1K_TLS_LDM_LO13, BFD_RELOC_OR1K_TLS_IE_LO13,
> 	BFD_RELOC_OR1K_SLO13, BFD_RELOC_OR1K_PLTA26.
> 	(elf_or1k_link_hash_table): Add field saw_plta.
> 	(or1k_final_link_relocate): Add value calculations for new relocations.
> 	(or1k_elf_relocate_section): Add section relocations for new
> 	relocations.
> 	(or1k_write_plt_entry): New function.
> 	(or1k_elf_finish_dynamic_sections): Add support for PLTA relocations
> 	using new l.adrp instruction.  Cleanup PLT relocation code generation.
> 	* libbfd.h: Regenerated.
> 	* reloc.c: Add BFD_RELOC_OR1K_PCREL_PG21, BFD_RELOC_OR1K_LO13,
> 	BFD_RELOC_OR1K_SLO13, BFD_RELOC_OR1K_GOT_PG21, BFD_RELOC_OR1K_GOT_LO13,
> 	BFD_RELOC_OR1K_PLTA26, BFD_RELOC_OR1K_TLS_GD_PG21,
> 	BFD_RELOC_OR1K_TLS_GD_LO13, BFD_RELOC_OR1K_TLS_LDM_PG21,
> 	BFD_RELOC_OR1K_TLS_LDM_LO13, BFD_RELOC_OR1K_TLS_IE_PG21,
> 	BFD_RELOC_OR1K_TLS_IE_LO13.
> 
> cpu/ChangeLog:
> 
> 	* or1k.opc (parse_disp26): Add support for plta() relocations.
> 	(parse_disp21): New function.
> 	(or1k_rclass): New enum.
> 	(or1k_rtype): New enum.
> 	(or1k_imm16_relocs): Define new PO and SPO relocation mappings.
> 	(parse_reloc): Add new po(), gotpo() and gottppo() for LO13 relocations.
> 	(parse_imm16): Add support for the new 21bit and 13bit relocations.
> 	* or1korbis.cpu (f-disp26): Don't assume SI.
> 	(f-disp21): New pc-relative 21-bit 13 shifted to right.
> 	(insn-opcode): Add ADRP.
> 	(l-adrp): New instruction.
> 
> gas/ChangeLog:
> 
> 	* config/tc-or1k.c (or1k_apply_fix): Add BFD_RELOC_OR1K_TLS_GD_PG21,
> 	BFD_RELOC_OR1K_TLS_GD_LO13, BFD_RELOC_OR1K_TLS_LDM_PG21,
> 	BFD_RELOC_OR1K_TLS_LDM_LO13, BFD_RELOC_OR1K_TLS_IE_PG21,
> 	BFD_RELOC_OR1K_TLS_IE_LO13.
> 	* testsuite/gas/or1k/allinsn.s: Add test for l.adrp.
> 	* testsuite/gas/or1k/allinsn.d: Add test results for new
> 	instructions.
> 	* testsuite/gas/or1k/reloc-1.s: Add tests to generate
> 	R_OR1K_PLTA26, R_OR1K_GOT_PG21, R_OR1K_TLS_GD_PG21, R_OR1K_TLS_LDM_PG21,
> 	R_OR1K_TLS_IE_PG21, R_OR1K_LO13, R_OR1K_GOT_LO13, R_OR1K_TLS_GD_LO13,
> 	R_OR1K_TLD_LDM_LO13, R_OR1K_TLS_IE_LO13, R_OR1K_LO13, R_OR1K_SLO13
> 	relocations.
> 	* testsuite/gas/or1k/reloc-1.d: Add relocation results for
> 	tests.
> 	* testsuite/gas/or1k/reloc-2.s: Add negative tests for store to
> 	gotpo().
> 	* testsuite/gas/or1k/reloc-2.l: Add expected error test results.
> 
> ld/ChangeLog:
> 
> 	* testsuite/ld-or1k/or1k.exp: Add test cases for plt generation.
> 	* testsuite/ld-or1k/plt1.dd: New file.
> 	* testsuite/ld-or1k/plt1.s: New file.
> 	* testsuite/ld-or1k/plt1.x.dd: New file.
> 	* testsuite/ld-or1k/plta1.dd: New file.
> 	* testsuite/ld-or1k/plta1.s: New file.
> 	* testsuite/ld-or1k/pltlib.s: New file.
> 
> include/ChangeLog:
> 
> 	* elf/or1k.h (elf_or1k_reloc_type): Add R_OR1K_PCREL_PG21,
> 	R_OR1K_GOT_PG21, R_OR1K_TLS_GD_PG21, R_OR1K_TLS_LDM_PG21,
> 	R_OR1K_TLS_IE_PG21, R_OR1K_LO13, R_OR1K_GOT_LO13,
> 	R_OR1K_TLS_GD_LO13, R_OR1K_TLS_LDM_LO13, R_OR1K_TLS_IE_LO13,
> 	R_OR1K_SLO13, R_OR1K_PLTA26.
> 
> opcodes/ChangeLog:
> 
> 	* or1k-asm.c: Regenerated.
> 	* or1k-desc.c: Regenerated.
> 	* or1k-desc.h: Regenerated.
> 	* or1k-dis.c: Regenerated.
> 	* or1k-ibld.c: Regenerated.
> 	* or1k-opc.c: Regenerated.
> 	* or1k-opc.h: Regenerated.
> 	* or1k-opinst.c: Regenerated.

Approved.

Cheers
  Nick


