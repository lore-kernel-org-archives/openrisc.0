From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 12 Jul 2018 17:01:31 +0900
Subject: [OpenRISC] [PATCH 1/6] um: remove redundant 'export LDFLAGS' in
	arch/x86/Makefile.um
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1531382496-3719-2-git-send-email-yamada.masahiro@socionext.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This is already exported by the top-level Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile.um | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 45af199..5296f8c 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -13,8 +13,6 @@ KBUILD_CFLAGS		+= $(call cc-option,-m32)
 KBUILD_AFLAGS		+= $(call cc-option,-m32)
 LINK-y			+= $(call cc-option,-m32)
 
-export LDFLAGS
-
 LDS_EXTRA		:= -Ui386
 export LDS_EXTRA
 
-- 
2.7.4

