From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:35 +0900
Subject: [OpenRISC] [PATCH 09/18] gdb: or1k: Silence gcc warning
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-10-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

gdb/ChangeLog:

	* or1k-tdep.c (or1k_regset_from_core_section) : Silence gcc warning
	by using %z format for size_t.
---
 gdb/or1k-tdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index 81bb541..f938077 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -1868,7 +1868,7 @@ or1k_regset_from_core_section (struct gdbarch *gdbarch,
 			       const char     *sect_name,
 			       size_t          sect_size)
 {
-  printf ("sect_name \"%s\", sect_size %d\n", sect_name, sect_size);
+  printf ("sect_name \"%s\", sect_size %zd\n", sect_name, sect_size);
   return NULL;
 
 }	/* or1k_regset_from_core_section () */
-- 
2.7.4


