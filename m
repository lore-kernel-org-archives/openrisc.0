From: Stafford Horne <shorne@gmail.com>
Date: Sat, 31 Dec 2016 20:52:57 +0900
Subject: [OpenRISC] [PATCH 1/3] openrisc: Add _text symbol to fix ksym build
	error
In-Reply-To: <cover.1483184705.git.shorne@gmail.com>
References: <cover.1483184705.git.shorne@gmail.com>
Message-ID: <da0fbe6c8413d990849d8f8764033810b18b83e9.1483184705.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The build robot reports:

   .tmp_kallsyms1.o: In function `kallsyms_relative_base':
>> (.rodata+0x8a18): undefined reference to `_text'

This is when using 'make alldefconfig'. Adding this _text symbol to mark
the start of the kernel as in other architecture fixes this.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index ef31fc2..5525446 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -44,6 +44,8 @@ SECTIONS
         /* Read-only sections, merged into text segment: */
         . = LOAD_BASE ;
 
+	_text = .;
+
 	/* _s_kernel_ro must be page aligned */
 	. = ALIGN(PAGE_SIZE);
 	_s_kernel_ro = .;
-- 
2.9.3


