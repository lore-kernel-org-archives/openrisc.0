From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Jan 2017 08:08:14 +0900
Subject: [OpenRISC] [PATCH 17/22] openrisc: Add .gitignore
In-Reply-To: <cover.1484432596.git.shorne@gmail.com>
References: <cover.1484432596.git.shorne@gmail.com>
Message-ID: <ba2a928e935708cfd7839f9a74e4a5a13d11e6c1.1484432596.git.shorne@gmail.com>
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

