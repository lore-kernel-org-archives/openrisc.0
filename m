From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Sat, 30 Apr 2022 21:11:22 +0200
Subject: [OpenRISC] [PATCH] openrisc: fix typos in comments
Message-ID: <20220430191122.8667-8-Julia.Lawall@inria.fr>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/openrisc/mm/tlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 2b6feabf6381..e2f2a3c3bb22 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -128,7 +128,7 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 
 	/* Was seeing bugs with the mm struct passed to us. Scrapped most of
 	   this function. */
-	/* Several architctures do this */
+	/* Several architectures do this */
 	local_flush_tlb_all();
 }
 

