From: Palmer Dabbelt <palmer@sifive.com>
Date: Tue, 27 Mar 2018 09:19:04 -0700
Subject: [OpenRISC] [PATCH v4 1/8] arm64: Set CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <20180327161911.14086-1-palmer@sifive.com>
References: <20180327161911.14086-1-palmer@sifive.com>
Message-ID: <20180327161911.14086-2-palmer@sifive.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

arm has an optional MULTI_IRQ_HANDLER, which arm64 copied but didn't
make optional.  I'm converting this to generic code, but in order to
ensure everything stays bisectable I want this defined on arm64 for now.
This will go away by the end of the patch set.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb7ef8e..302d0b681676 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,7 @@ config ARM64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
+	select MULTI_IRQ_HANDLER
 	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
@@ -275,6 +276,9 @@ config ARCH_SUPPORTS_UPROBES
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
+config MULTI_IRQ_HANDLER
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
-- 
2.16.1

