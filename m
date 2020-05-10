From: Christoph Hellwig <hch@lst.de>
Date: Sun, 10 May 2020 09:55:06 +0200
Subject: [OpenRISC] [PATCH 27/31] exec: only build read_code when needed
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Message-ID: <20200510075510.987823-28-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Only build read_code when binary formats that use it are built into the
kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d9..a4f766f296f8f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1027,6 +1027,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
 
+#if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
+    defined(CONFIG_BINFMT_ELF_FDPIC)
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
@@ -1035,6 +1037,7 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 	return res;
 }
 EXPORT_SYMBOL(read_code);
+#endif
 
 /*
  * Maps the mm_struct mm into the current task struct.
-- 
2.26.2

