From: Nick Clifton <nickc@redhat.com>
Date: Thu, 4 Oct 2018 16:31:43 +0100
Subject: [OpenRISC] [PATCH v3 1/5] or1k: Add relocations for high-signed
 and low-stores
In-Reply-To: <20181004032317.17478-2-shorne@gmail.com>
References: <20181004032317.17478-1-shorne@gmail.com>
 <20181004032317.17478-2-shorne@gmail.com>
Message-ID: <5acf7fa6-76a4-3df4-b8d5-0c56cb7f6191@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

> bfd/ChangeLog:
> 
> yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>
> 
> 	* bfd-in2.h: Regenerated.
> 	* elf32-or1k.c (N_ONES): New macro.
> 	(or1k_elf_howto_table): Fix R_OR1K_PLT26 to complain on overflow.
> 	Add definitions for R_OR1K_TLS_TPOFF, R_OR1K_TLS_DTPOFF,
> 	R_OR1K_TLS_DTPMOD, R_OR1K_AHI16, R_OR1K_GOTOFF_AHI16,
> 	R_OR1K_TLS_IE_AHI16, R_OR1K_TLS_LE_AHI16, R_OR1K_SLO16,
> 	R_OR1K_GOTOFF_SLO16, R_OR1K_TLS_LE_SLO16.
> 	(or1k_reloc_map): Add entries for BFD_RELOC_HI16_S,
> 	BFD_RELOC_LO16_GOTOFF, BFD_RELOC_HI16_GOTOFF, BFD_RELOC_HI16_S_GOTOFF,
> 	BFD_RELOC_OR1K_TLS_IE_AHI16, BFD_RELOC_OR1K_TLS_LE_AHI16,
> 	BFD_RELOC_OR1K_SLO16, BFD_RELOC_OR1K_GOTOFF_SLO16,
> 	BFD_RELOC_OR1K_TLS_LE_SLO16.
> 	(or1k_reloc_type_lookup): Change search loop to start ad index 0 and
> 	also check results before returning.
> 	(or1k_reloc_name_lookup): Simplify loop to use R_OR1K_max as index
> 	limit.
> 	(or1k_final_link_relocate): New function.
> 	(or1k_elf_relocate_section): Add support for new AHI and SLO
> 	relocations.  Use or1k_final_link_relocate instead of generic
> 	_bfd_final_link_relocate.
> 	(or1k_elf_check_relocs): Add support for new AHI and SLO relocations.
> 	* reloc.c: Add new enums for BFD_RELOC_OR1K_SLO16,
> 	BFD_RELOC_OR1K_GOTOFF_SLO16, BFD_RELOC_OR1K_TLS_IE_AHI16,
> 	BFD_RELOC_OR1K_TLS_IE_AHI16, BFD_RELOC_OR1K_TLS_LE_AHI16,
> 	BFD_RELOC_OR1K_TLS_LE_SLO16.  Remove unused BFD_RELOC_OR1K_GOTOFF_HI16
> 	and BFD_RELOC_OR1K_GOTOFF_LO16.
> 	* libbfd.h: Regenerated.
> 
> cpu/ChangeLog:
> 
> yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>
> 
> 	* or1k.opc: Add RTYPE_ enum.
> 	(INVALID_STORE_RELOC): New string.
> 	(or1k_imm16_relocs): New array array.
> 	(parse_reloc): New static function that just does the parsing.
> 	(parse_imm16): New static function for generic parsing.
> 	(parse_simm16): Change to just call parse_imm16.
> 	(parse_simm16_split): New function.
> 	(parse_uimm16): Change to call parse_imm16.
> 	(parse_uimm16_split): New function.
> 	* or1korbis.cpu (simm16-split): Change to use new simm16_split.
> 	(uimm16-split): Change to use new uimm16_split.
> 
> gas/ChangeLog:
> 
> yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>
> 
> 	* testsuite/gas/or1k/allinsn.d (l_ha): Add result for ha() relocation.
> 	* testsuite/gas/or1k/allinsn.s (l_ha): Add test for ha() relocations.
> 	* testsuite/gas/or1k/allinsn.exp: Renamed to or1k.exp.
> 	* testsuite/gas/or1k/or1k.exp: Add reloc-2 list test.
> 	* testsuite/gas/or1k/reloc-1.d: New file.
> 	* testsuite/gas/or1k/reloc-1.s: New file.
> 	* testsuite/gas/or1k/reloc-2.l: New file.
> 	* testsuite/gas/or1k/reloc-2.s: New file.
> 
> include/ChangeLog:
> 
> yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>
> 
> 	* elf/or1k.h (elf_or1k_reloc_type): Add R_OR1K_AHI16,
> 	R_OR1K_GOTOFF_AHI16, R_OR1K_TLS_IE_AHI16, R_OR1K_TLS_LE_AHI16,
> 	R_OR1K_SLO16, R_OR1K_GOTOFF_SLO16, R_OR1K_TLS_LE_SLO16.
> 
> ld/ChangeLog:
> 
> yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>
> 
> 	* testsuite/ld-or1k/offsets1.d: New file.
> 	* testsuite/ld-or1k/offsets1.s: New file.
> 	* testsuite/ld-or1k/or1k.exp: New file.
> 
> opcodes/ChangeLog:
> 
> yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>
> 
> 	* or1k-asm.c: Regenerate.
> --- 

Approved.

Cheers
  Nick

