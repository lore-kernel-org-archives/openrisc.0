From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 21:52:50 +0900
Subject: [OpenRISC] [PATCH v6 1/5] tdesc: handle arbitrary strings in
	tdesc_register_in_reggroup_p
In-Reply-To: <cover.1493038197.git.shorne@gmail.com>
References: <cover.1493038197.git.shorne@gmail.com>
Message-ID: <dbd35ae7e8f9ca8db89dd14b81119d3eb50afb98.1493038197.git.shorne@gmail.com>
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

2013-02-15  Franck Jullien  <franck.jullien@gmail.com>

	* target-descriptions.c (tdesc_register_in_reggroup_p): Support
	arbitrary strings.
---
 gdb/target-descriptions.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gdb/target-descriptions.c b/gdb/target-descriptions.c
index 9a7e2dd..8b5ac92 100644
--- a/gdb/target-descriptions.c
+++ b/gdb/target-descriptions.c
@@ -1086,12 +1086,8 @@ tdesc_remote_register_number (struct gdbarch *gdbarch, int regno)
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
 
@@ -1120,6 +1116,10 @@ tdesc_register_in_reggroup_p (struct gdbarch *gdbarch, int regno,
 
       if (reggroup == general_reggroup)
 	return general_p;
+
+      if (strcmp (reg->group, reggroup_name (reggroup)) == 0)
+	return 1;
+
     }
 
   if (reg != NULL
-- 
2.9.3

