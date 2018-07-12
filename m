From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 12 Jul 2018 17:01:32 +0900
Subject: [OpenRISC] [PATCH 2/6] ARM: vfp: clean-up arch/arm/vfp/Makefile
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1531382496-3719-3-git-send-email-yamada.masahiro@socionext.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Since commit 799c43415442 ("kbuild: thin archives make default for
all archs"), $(AR) is used instead of $(LD) to combine object files.

  LDFLAGS         +=--no-warn-mismatch

... is unused code now.

arch/arm/Makefile already guards arch/arm/vfp/ by a boolean symbol,
CONFIG_VFP, like this:

  core-$(CONFIG_VFP)              += arch/arm/vfp/

..., so $(CONFIG_VFP) is always evaluated to y in arch/arm/vfp/Makefile.

Also, there is no point to use pseudo object, vfp.o, which never becomes
a module.  Add all objects directly to obj-y.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/vfp/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/vfp/Makefile b/arch/arm/vfp/Makefile
index a81404c..94516c4 100644
--- a/arch/arm/vfp/Makefile
+++ b/arch/arm/vfp/Makefile
@@ -8,8 +8,5 @@
 # asflags-y := -DDEBUG
 
 KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp -mfloat-abi=soft)
-LDFLAGS		+=--no-warn-mismatch
 
-obj-y			+= vfp.o
-
-vfp-$(CONFIG_VFP)	+= vfpmodule.o entry.o vfphw.o vfpsingle.o vfpdouble.o
+obj-y		+= vfpmodule.o entry.o vfphw.o vfpsingle.o vfpdouble.o
-- 
2.7.4

