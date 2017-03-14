From: Stafford Horne <shorne@gmail.com>
Date: Tue, 14 Mar 2017 23:56:27 +0900
Subject: [OpenRISC] [PATCH 2/3] openrisc: fix issue handling 8 byte get_user
	calls
In-Reply-To: <cover.1489502779.git.shorne@gmail.com>
References: <cover.1489502779.git.shorne@gmail.com>
Message-ID: <0919e155a0de5d4e6fd8a70c56b8ee44eac37dd2.1489502779.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Was getting the following error with allmodconfig:

  ERROR: "__get_user_bad" [lib/test_user_copy.ko] undefined!

This was simply a missing break statement, causing an unwanted fall
through.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 140faa1..1311e6b 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -211,7 +211,7 @@ do {									\
 	case 1: __get_user_asm(x, ptr, retval, "l.lbz"); break;		\
 	case 2: __get_user_asm(x, ptr, retval, "l.lhz"); break;		\
 	case 4: __get_user_asm(x, ptr, retval, "l.lwz"); break;		\
-	case 8: __get_user_asm2(x, ptr, retval);			\
+	case 8: __get_user_asm2(x, ptr, retval); break;			\
 	default: (x) = __get_user_bad();				\
 	}								\
 } while (0)
-- 
2.9.3

