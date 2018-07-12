From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 12 Jul 2018 17:01:34 +0900
Subject: [OpenRISC] [PATCH 4/6] kbuild: replace $(LDFLAGS) $(ldflags-y) with
	$(ld_flags)
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1531382496-3719-5-git-send-email-yamada.masahiro@socionext.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

$(LDFLAGS) $(ldflags-y) is equivalent to $(ld_flags).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1bb594f..1915574 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -225,8 +225,7 @@ $(obj)/%: $(src)/%_shipped
 # ---------------------------------------------------------------------------
 
 quiet_cmd_ld = LD      $@
-cmd_ld = $(LD) $(LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F)) \
-	       $(filter-out FORCE,$^) -o $@
+cmd_ld = $(LD) $(ld_flags) $(LDFLAGS_$(@F)) $(filter-out FORCE,$^) -o $@
 
 # Objcopy
 # ---------------------------------------------------------------------------
-- 
2.7.4

