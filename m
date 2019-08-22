From: Stafford Horne <shorne@gmail.com>
Date: Thu, 22 Aug 2019 20:27:57 +0900
Subject: [OpenRISC] [PATCH] or1k: Fix incorrect value in PLT GOT entries,
 causing infinite loop
Message-ID: <20190822112757.32751-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The PLT GOT entry should point to the first PLT entry which contains the
runtime linker function.  It was pointing back to the symbol PLT entry
causing an infinite loop.

I found this when testing the OpenRISC glibc port which uses the runtime
dynamic linker.  It seems other libc's we use so far have not been
making use of the initial PLT GOT entries.

bfd/ChangeLog:

	* elf32-or1k.c (or1k_elf_finish_dynamic_symbol): Use correct value for
	PLT GOT entries.
---
 bfd/elf32-or1k.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index c1bbac98fb..cb7c0da5fd 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -2377,8 +2377,11 @@ or1k_elf_finish_dynamic_symbol (bfd *output_bfd,
       or1k_write_plt_entry (output_bfd, splt->contents + h->plt.offset,
 			    plt0, plt1, plt2, OR1K_JR(12));
 
-      /* Fill in the entry in the global offset table.  */
-      bfd_put_32 (output_bfd, plt_addr, sgot->contents + got_offset);
+      /* Fill in the entry in the global offset table.  We initialize it to
+	 point to the top of the plt.  This is done to lazy lookup the actual
+	 symbol as the first plt entry will be setup by libc to call the
+	 runtime dynamic linker.  */
+      bfd_put_32 (output_bfd, plt_base_addr, sgot->contents + got_offset);
 
       /* Fill in the entry in the .rela.plt section.  */
       rela.r_offset = got_addr;
-- 
2.21.0

