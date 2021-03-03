From: Stafford Horne <shorne@gmail.com>
Date: Wed,  3 Mar 2021 22:50:24 +0900
Subject: [OpenRISC] [PATCH 2/4] openrisc: Add gitignore for dtb files
In-Reply-To: <20210303135026.3450789-1-shorne@gmail.com>
References: <20210303135026.3450789-1-shorne@gmail.com>
Message-ID: <20210303135026.3450789-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/dts/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/openrisc/dts/.gitignore

diff --git a/arch/openrisc/dts/.gitignore b/arch/openrisc/dts/.gitignore
new file mode 100644
index 000000000..077903c50
--- /dev/null
+++ b/arch/openrisc/dts/.gitignore
@@ -0,0 +1 @@
+*dtb*
-- 
2.26.2

