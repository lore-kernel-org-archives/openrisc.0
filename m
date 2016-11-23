From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:31 +0900
Subject: [OpenRISC] [PATCH 05/18] gdb: handle arbitrary strings in
	tdesc_register_in_reggroup_p
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-6-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Franck Jullien <franck.jullien@gmail.com>

tdesc_register_in_reggroup_p in now able to handle arbitrary
groups. This is useful when groups are created while the
target descriptor file is received from the remote.

This can be the case of a soft core target processor where
registers/groups can change.

gdb/ChangeLog:

	* target-descriptions.c: (tdesc_register_in_reggroup_p) support
	arbitrary groups.
---
 gdb/target-descriptions.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gdb/target-descriptions.c b/gdb/target-descriptions.c
index 18c39cd..a542ef9 100644
--- a/gdb/target-descriptions.c
+++ b/gdb/target-descriptions.c
@@ -1118,12 +1118,8 @@ tdesc_remote_register_number (struct gdbarch *gdbarch, int regno)
    return -1 if it does not know; the caller should handle registers
    with no specified group.
 
-   Arbitrary strings (other than "general", "float", and "vector")
-   from the description are not used; they cause the register to be
-   displayed in "info all-registers" but excluded from "info
-   registers" et al.  The names of containing features are also not
-   used.  This might be extended to display registers in some more
-   useful groupings.
+   The names of containing features are also not used.  This might be
+   extended to display registers in some more useful groupings.
 
    The save-restore flag is also implemented here.  */
 
@@ -1152,6 +1148,10 @@ tdesc_register_in_reggroup_p (struct gdbarch *gdbarch, int regno,
 
       if (reggroup == general_reggroup)
 	return general_p;
+
+      if (strcmp (reg->group, reggroup_name (reggroup)) == 0)
+	return 1;
+
     }
 
   if (reg != NULL
-- 
2.7.4


