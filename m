From: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Date: Sun, 23 Jan 2022 11:01:00 +0900
Subject: [OpenRISC] [PATCH] openrisc/boot: Remove unnecessary initialisation
 in memcpy().
Message-ID: <20220123020100.45201-1-kuniyu@amazon.co.jp>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

'd' and 's' are initialised later with 'dest_w' and 'src_w', so we need not
initialise them before that.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
 arch/openrisc/lib/memcpy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
index fe2177628..e2af9b510 100644
--- a/arch/openrisc/lib/memcpy.c
+++ b/arch/openrisc/lib/memcpy.c
@@ -101,7 +101,7 @@ void *memcpy(void *dest, __const void *src, __kernel_size_t n)
  */
 void *memcpy(void *dest, __const void *src, __kernel_size_t n)
 {
-	unsigned char *d = (unsigned char *)dest, *s = (unsigned char *)src;
+	unsigned char *d, *s;
 	uint32_t *dest_w = (uint32_t *)dest, *src_w = (uint32_t *)src;
 
 	/* If both source and dest are word aligned copy words */
-- 
2.30.2

