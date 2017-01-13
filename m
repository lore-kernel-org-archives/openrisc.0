From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri, 13 Jan 2017 11:46:43 +0100
Subject: [OpenRISC] [PATCH v3 5/8] Makefile.headersinst: cleanup input files
In-Reply-To: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
References: <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <1484304406-10820-6-git-send-email-nicolas.dichtel@6wind.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

After the last four patches, all exported headers are under uapi/, thus
input-files2 are not needed anymore.
The side effect is that input-files1-name is exactly header-y.

Note also that input-files3-name is genhdr-y.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 scripts/Makefile.headersinst | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 1106d6ca3a38..3e20d03432d2 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -40,31 +40,20 @@ wrapper-files := $(filter $(header-y), $(generic-y))
 srcdir        := $(srctree)/$(obj)
 gendir        := $(objtree)/$(gen)
 
-oldsrcdir     := $(srctree)/$(subst /uapi,,$(obj))
-
 # all headers files for this dir
 header-y      := $(filter-out $(generic-y), $(header-y))
 all-files     := $(header-y) $(genhdr-y) $(wrapper-files)
 output-files  := $(addprefix $(installdir)/, $(all-files))
 
-input-files1  := $(foreach hdr, $(header-y), \
-		   $(if $(wildcard $(srcdir)/$(hdr)), \
-			$(wildcard $(srcdir)/$(hdr))) \
-		   )
-input-files1-name := $(notdir $(input-files1))
-input-files2  := $(foreach hdr, $(header-y), \
-		   $(if  $(wildcard $(srcdir)/$(hdr)),, \
-			$(if $(wildcard $(oldsrcdir)/$(hdr)), \
-				$(wildcard $(oldsrcdir)/$(hdr)), \
-				$(error Missing UAPI file $(srcdir)/$(hdr))) \
-		   ))
-input-files2-name := $(notdir $(input-files2))
-input-files3  := $(foreach hdr, $(genhdr-y), \
-		   $(if	$(wildcard $(gendir)/$(hdr)), \
-			$(wildcard $(gendir)/$(hdr)), \
-			$(error Missing generated UAPI file $(gendir)/$(hdr)) \
-		   ))
-input-files3-name := $(notdir $(input-files3))
+# Check that all expected files exist
+$(foreach hdr, $(header-y), \
+  $(if $(wildcard $(srcdir)/$(hdr)),, \
+       $(error Missing UAPI file $(srcdir)/$(hdr)) \
+   ))
+$(foreach hdr, $(genhdr-y), \
+  $(if	$(wildcard $(gendir)/$(hdr)),, \
+       $(error Missing generated UAPI file $(gendir)/$(hdr)) \
+  ))
 
 # Work out what needs to be removed
 oldheaders    := $(patsubst $(installdir)/%,%,$(wildcard $(installdir)/*.h))
@@ -78,9 +67,8 @@ printdir = $(patsubst $(INSTALL_HDR_PATH)/%/,%,$(dir $@))
 quiet_cmd_install = INSTALL $(printdir) ($(words $(all-files))\
                             file$(if $(word 2, $(all-files)),s))
       cmd_install = \
-        $(CONFIG_SHELL) $< $(installdir) $(srcdir) $(input-files1-name); \
-        $(CONFIG_SHELL) $< $(installdir) $(oldsrcdir) $(input-files2-name); \
-        $(CONFIG_SHELL) $< $(installdir) $(gendir) $(input-files3-name); \
+        $(CONFIG_SHELL) $< $(installdir) $(srcdir) $(header-y); \
+        $(CONFIG_SHELL) $< $(installdir) $(gendir) $(genhdr-y); \
         for F in $(wrapper-files); do                                   \
                 echo "\#include <asm-generic/$$F>" > $(installdir)/$$F;    \
         done;                                                           \
-- 
2.8.1

