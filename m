From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri,  2 Apr 2021 15:18:07 +0000 (UTC)
Subject: [OpenRISC] [PATCH v4 06/20] powerpc: convert strcpy to strlcpy in
 prom_init
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <03c0b931557967876abcebc7d0e3c6537eb6ab89.1617375802.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Daniel Walker <danielwa@cisco.com>

There's only two users of strcpy and one is the command
line handling. The generic command line handling uses strlcpy
and it makes sense to convert this one other user to strlcpy to
keep prom_init size consistent.

Cc: xe-linux-external at cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/prom_init.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 41ed7e33d897..33316ee55265 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -242,15 +242,6 @@ static int __init prom_strcmp(const char *cs, const char *ct)
 	return 0;
 }
 
-static char __init *prom_strcpy(char *dest, const char *src)
-{
-	char *tmp = dest;
-
-	while ((*dest++ = *src++) != '\0')
-		/* nothing */;
-	return tmp;
-}
-
 static int __init prom_strncmp(const char *cs, const char *ct, size_t count)
 {
 	unsigned char c1, c2;
@@ -276,6 +267,20 @@ static size_t __init prom_strlen(const char *s)
 	return sc - s;
 }
 
+static size_t __init prom_strlcpy(char *dest, const char *src, size_t size)
+{
+	size_t ret = prom_strlen(src);
+
+	if (size) {
+		size_t len = (ret >= size) ? size - 1 : ret;
+
+		memcpy(dest, src, len);
+		dest[len] = '\0';
+	}
+	return ret;
+}
+
+
 static int __init prom_memcmp(const void *cs, const void *ct, size_t count)
 {
 	const unsigned char *su1, *su2;
@@ -2702,7 +2707,7 @@ static void __init flatten_device_tree(void)
 
 	/* Add "phandle" in there, we'll need it */
 	namep = make_room(&mem_start, &mem_end, 16, 1);
-	prom_strcpy(namep, "phandle");
+	prom_strlcpy(namep, "phandle", 8);
 	mem_start = (unsigned long)namep + prom_strlen(namep) + 1;
 
 	/* Build string array */
-- 
2.25.0

