From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date: Mon, 12 Jul 2021 12:32:56 +0200
Subject: [OpenRISC] [PATCH] or1k: fix pc-relative relocation against dynamic
 on PC relative 26 bit relocation
Message-ID: <20210712103256.2275617-1-giulio.benetti@benettiengineering.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

When building openal we were seeing the assert failure:

/home/buildroot/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld: CMakeFiles/OpenAL.dir/al/source.cpp.o:
pc-relative relocation against dynamic symbol alSourcePausev
/home/buildroot/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld: CMakeFiles/OpenAL.dir/al/source.cpp.o:
pc-relative relocation against dynamic symbol alSourceStopv
/home/buildroot/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld: CMakeFiles/OpenAL.dir/al/source.cpp.o:
pc-relative relocation against dynamic symbol alSourceRewindv
/home/buildroot/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld: CMakeFiles/OpenAL.dir/al/source.cpp.o:
pc-relative relocation against dynamic symbol alSourcePlayv
collect2: error: ld returned 1 exit status

This happens because in R_OR1K_INSN_REL_26 case we can't reference local
symbol as previously done but we need to make sure that calls to actual
symbol always call the version of current object.

bfd/Changelog:

	* elf32-or1k.c (or1k_elf_relocate_section): use a separate entry
	  in switch case R_OR1K_INSN_REL_26 where we need to check for
	  !SYMBOL_CALLS_LOCAL() instead of !SYMBOL_REFERENCES_LOCAL().

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 bfd/elf32-or1k.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 4ae7f324d33..4f9092539f5 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -1543,6 +1543,18 @@ or1k_elf_relocate_section (bfd *output_bfd,
 	  break;
 
 	case R_OR1K_INSN_REL_26:
+	  /* For a non-shared link, these will reference plt or call the
+	     version of actual object.  */
+	  if (bfd_link_pic (info) && !SYMBOL_CALLS_LOCAL (info, h))
+	    {
+	      _bfd_error_handler
+		(_("%pB: pc-relative relocation against dynamic symbol %s"),
+		 input_bfd, name);
+	      ret_val = false;
+	      bfd_set_error (bfd_error_bad_value);
+	    }
+	  break;
+
 	case R_OR1K_PCREL_PG21:
 	case R_OR1K_LO13:
 	case R_OR1K_SLO13:
-- 
2.25.1

