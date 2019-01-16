From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 16 Jan 2019 15:44:17 +0200
Subject: [OpenRISC] [PATCH 17/21] init/main: add checks for the return value
	of memblock_alloc*()
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1547646261-32535-18-git-send-email-rppt@linux.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add panic() calls if memblock_alloc() returns NULL.

The panic() format duplicates the one used by memblock itself and in order
to avoid explosion with long parameters list replace open coded allocation
size calculations with a local variable.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 init/main.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index a56f65a..d58a365 100644
--- a/init/main.c
+++ b/init/main.c
@@ -373,12 +373,20 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  */
 static void __init setup_command_line(char *command_line)
 {
-	saved_command_line =
-		memblock_alloc(strlen(boot_command_line) + 1, SMP_CACHE_BYTES);
-	initcall_command_line =
-		memblock_alloc(strlen(boot_command_line) + 1, SMP_CACHE_BYTES);
-	static_command_line = memblock_alloc(strlen(command_line) + 1,
-					     SMP_CACHE_BYTES);
+	size_t len = strlen(boot_command_line) + 1;
+
+	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
+	if (!saved_command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
+	initcall_command_line =	memblock_alloc(len, SMP_CACHE_BYTES);
+	if (!initcall_command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
+	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
+	if (!static_command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
 	strcpy(saved_command_line, boot_command_line);
 	strcpy(static_command_line, command_line);
 }
@@ -773,8 +781,14 @@ static int __init initcall_blacklist(char *str)
 			pr_debug("blacklisting initcall %s\n", str_entry);
 			entry = memblock_alloc(sizeof(*entry),
 					       SMP_CACHE_BYTES);
+			if (!entry)
+				panic("%s: Failed to allocate %zu bytes\n",
+				      __func__, sizeof(*entry));
 			entry->buf = memblock_alloc(strlen(str_entry) + 1,
 						    SMP_CACHE_BYTES);
+			if (!entry->buf)
+				panic("%s: Failed to allocate %zu bytes\n",
+				      __func__, strlen(str_entry) + 1);
 			strcpy(entry->buf, str_entry);
 			list_add(&entry->next, &blacklisted_initcalls);
 		}
-- 
2.7.4

