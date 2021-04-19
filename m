From: Stafford Horne <shorne@gmail.com>
Date: Mon, 19 Apr 2021 09:05:24 +0900
Subject: [OpenRISC] [PATCH 4/4] or1k: Fail link if the PLT relocation
 overflows
In-Reply-To: <20210419000524.3625897-1-shorne@gmail.com>
References: <20210419000524.3625897-1-shorne@gmail.com>
Message-ID: <20210419000524.3625897-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

bfd/ChangeLog:

	PR 27746
	* elf32-or1k.c (or1k_elf_finish_dynamic_symbol): Add condition
	to check and fail if the PLT relocation overflows.
---
 bfd/elf32-or1k.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 1a5b3319646..6afacfa57cf 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -2453,6 +2453,14 @@ or1k_elf_finish_dynamic_symbol (bfd *output_bfd,
       got_offset = (plt_index + 3) * 4;
       got_addr = got_base_addr + got_offset;
 
+      if (!htab->saw_gotha && plt_reloc > 0xffff)
+	{
+	  _bfd_error_handler (_("%pB: plt relocation overflow when writing %s"),
+		              output_bfd, h->root.root.string);
+	  bfd_set_error (bfd_error_bad_value);
+	  return false;
+	}
+
       /* Fill in the entry in the procedure linkage table.  */
       if (htab->saw_plta)
 	{
-- 
2.26.2

