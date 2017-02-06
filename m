From: Stafford Horne <shorne@gmail.com>
Date: Mon,  6 Feb 2017 23:38:40 +0900
Subject: [OpenRISC] [PATCH 3/3] libgloss: Remove duplicate definition of
	environ
In-Reply-To: <cover.1486391219.git.shorne@gmail.com>
References: <cover.1486391219.git.shorne@gmail.com>
Message-ID: <ac05ff603f3fc6ba605191dd6a3960c8c68c1da4.1486391219.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Environ is defined in libgloss and libc:
 - libgloss/or1k/syscalls.c
 - libc/stdlib/environ.c

When linking we sometimes get errors:
or1k-elf-g++ test.o -mnewlib -mboard=or1ksim -lm -o  test
/opt/shorne/software/or1k/lib/gcc/or1k-elf/5.3.0/../../../../or1k-elf/lib/libor1k.a(syscalls.o):(.data+0x0):
multiple definition of `environ'
/opt/shorne/software/or1k/lib/gcc/or1k-elf/5.3.0/../../../../or1k-elf/lib/libc.a(lib_a-environ.o):(.data+0x0):
first defined here
collect2: error: ld returned 1 exit status

This doesnt happen after the fix. Basic things build fine too.
---
 libgloss/or1k/syscalls.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libgloss/or1k/syscalls.c b/libgloss/or1k/syscalls.c
index 3e2ad22..92bff49 100644
--- a/libgloss/or1k/syscalls.c
+++ b/libgloss/or1k/syscalls.c
@@ -56,9 +56,6 @@ _close_r(struct _reent *reent, int fildes)
 	return -1;
 }
 
-char *__env[1] = { 0 };
-char **environ = __env;
-
 int
 _execve_r(struct _reent *reent, const char *name, char * const *argv,
 		char * const *env)
-- 
2.9.3

