From: Stafford Horne <shorne@gmail.com>
Date: Wed, 20 May 2020 05:37:47 +0900
Subject: [OpenRISC] [PATCH 2/5] or1k: Add builtin define to detect hard float
In-Reply-To: <20200519203750.401593-1-shorne@gmail.com>
References: <20200519203750.401593-1-shorne@gmail.com>
Message-ID: <20200519203750.401593-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This is used in libgcc and now glibc to detect when hardware floating
point operations are supported by the target.

gcc/ChangeLog:

	* config/or1k/or1k.h (TARGET_CPU_CPP_BUILTINS): Add builtin
	  define for __or1k_hard_float__.
---
 gcc/config/or1k/or1k.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
index be089900fd4..0d6fed5f4ca 100644
--- a/gcc/config/or1k/or1k.h
+++ b/gcc/config/or1k/or1k.h
@@ -30,6 +30,8 @@
       builtin_define ("__or1k__");		\
       if (TARGET_CMOV)				\
 	builtin_define ("__or1k_cmov__");	\
+      if (TARGET_HARD_FLOAT)			\
+	builtin_define ("__or1k_hard_float__");	\
       builtin_assert ("cpu=or1k");		\
       builtin_assert ("machine=or1k");		\
     }						\
-- 
2.26.2

