From: Stafford Horne <shorne@gmail.com>
Date: Tue, 14 Mar 2017 23:56:26 +0900
Subject: [OpenRISC] [PATCH 1/3] openrisc: xchg: fix `computed is not used`
	warning
In-Reply-To: <cover.1489502779.git.shorne@gmail.com>
References: <cover.1489502779.git.shorne@gmail.com>
Message-ID: <44f79fa18a167e2fb175c93cab20c775814dd1b7.1489502779.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

When building allmodconfig this warning shows.

  fs/ocfs2/file.c: In function 'ocfs2_file_write_iter':
  ./arch/openrisc/include/asm/cmpxchg.h:81:3: warning: value computed is
  not used [-Wunused-value]
    ((typeof(*(ptr)))__xchg((unsigned long)(with), (ptr), sizeof(*(ptr))))
     ^

Applying the same patch logic that was done to the cmpxchg macro.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/cmpxchg.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index 5fcb9ac..f0a5d8b 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -77,7 +77,11 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 	return val;
 }
 
-#define xchg(ptr, with) \
-	((typeof(*(ptr)))__xchg((unsigned long)(with), (ptr), sizeof(*(ptr))))
+#define xchg(ptr, with) 						\
+	({								\
+		(__typeof__(*(ptr))) __xchg((unsigned long)(with),	\
+					    (ptr),			\
+					    sizeof(*(ptr)));		\
+	})
 
 #endif /* __ASM_OPENRISC_CMPXCHG_H */
-- 
2.9.3

