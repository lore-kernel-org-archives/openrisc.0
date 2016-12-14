From: Stafford Horne <shorne@gmail.com>
Date: Wed, 14 Dec 2016 22:27:24 +0900
Subject: [OpenRISC] [PATCH v2] openrisc: Add _text symbol to fix ksym build
	error
Message-ID: <1481722044-20901-1-git-send-email-shorne@gmail.com>
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
Change in v2:
 - dont add _data since its not needed

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
2.7.4


