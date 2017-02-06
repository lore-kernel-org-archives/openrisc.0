From: Stafford Horne <shorne@gmail.com>
Date: Mon,  6 Feb 2017 23:38:38 +0900
Subject: [OpenRISC] [PATCH 1/3] or1k: Make open reentrant
In-Reply-To: <cover.1486391219.git.shorne@gmail.com>
References: <cover.1486391219.git.shorne@gmail.com>
Message-ID: <608a0c980e753934e9bb15fb02e2e9302bad1b4f.1486391219.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Olof Kindgren <olof.kindgren@gmail.com>

or1k uses reentrant calls by default, but there was no open_r defined
which caused failure in C++/C code such as:

int main() { std::cout << "test\n";  return 0; }

or

int main() {open(".", 0);}
---
 libgloss/or1k/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libgloss/or1k/syscalls.c b/libgloss/or1k/syscalls.c
index 690d21a..3e2ad22 100644
--- a/libgloss/or1k/syscalls.c
+++ b/libgloss/or1k/syscalls.c
@@ -124,7 +124,7 @@ _lseek_r(struct _reent *reent, int file, _off_t ptr, int dir)
 }
 
 int
-_open(struct _reent *reent, char *file, int flags, int mode)
+_open_r(struct _reent *reent, const char *file, int flags, int mode)
 {
 	reent->_errno = ENOSYS;
 	return -1;
-- 
2.9.3

