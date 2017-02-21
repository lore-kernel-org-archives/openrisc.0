From: Stafford Horne <shorne@gmail.com>
Date: Wed, 22 Feb 2017 04:11:46 +0900
Subject: [OpenRISC] [PATCH v3 17/25] openrisc: Add .gitignore
In-Reply-To: <cover.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
Message-ID: <3cf0e9fbec60b34cfa8deae9c5b1a0452d1e67d9.1487702890.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This helps to suppress the vmlinux.lds file.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/openrisc/kernel/.gitignore

diff --git a/arch/openrisc/kernel/.gitignore b/arch/openrisc/kernel/.gitignore
new file mode 100644
index 0000000..c5f676c
--- /dev/null
+++ b/arch/openrisc/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
-- 
2.9.3

