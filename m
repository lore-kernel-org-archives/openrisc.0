From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:36 +0900
Subject: [OpenRISC] [PATCH v4 16/24] openrisc: Add .gitignore
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <d1deb3906e9e508dba5e1ae306c41930f08eae37.1487910170.git.shorne@gmail.com>
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

