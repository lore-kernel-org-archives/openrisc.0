From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:28 +0900
Subject: [OpenRISC] [PATCH 02/18] gdb: or1k: Add a check for NULL ptr in
	or1k_skip_prologue
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-3-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Franck Jullien <franck.jullien@gmail.com>

gdb/ChangeLog:

	* or1k-tdep.c (or1k_skip_prologue): Add a check for NULL
	pointer while comparing debugformat to "dwarf".

Signed-off-by: Franck Jullien <franck.jullien@gmail.com>
---
 gdb/or1k-tdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index 6d27a0d..55b9522 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -949,7 +949,7 @@ or1k_skip_prologue (struct gdbarch *gdbarch,
 	  struct symtab_and_line  prologue_sal = find_pc_line (start_pc, 0);
 	  const char *debug_format = prologue_sal.symtab->debugformat;
 
-	  if ((strlen ("dwarf") <= strlen (debug_format))
+	  if ((NULL != debug_format) && (strlen ("dwarf") <= strlen (debug_format))
 	      && (0 == strncasecmp ("dwarf", debug_format, strlen ("dwarf"))))
 	    {
 	      return  (prologue_end > pc) ? prologue_end : pc;
-- 
2.7.4


