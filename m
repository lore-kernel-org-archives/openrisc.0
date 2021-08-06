From: Stafford Horne <shorne@gmail.com>
Date: Fri,  6 Aug 2021 18:42:17 +0900
Subject: [OpenRISC] [PATCH v2] time: Fix overflow itimer tests on 32-bit
 systems
Message-ID: <20210806094217.3227877-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On the port of OpenRISC I am working on and it appears the rv32 port
we have sets __TIMESIZE == 64 && __WORDSIZE == 32.  This causes the
size of time_t to be 8 bytes, but the tv_sec in the kernel is still 32-bit
causing truncation.

The truncations are unavoidable on these systems so skip the
testing/failures by guarding with __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64.

Also, futher in the tests and in other parts of code checking for time_t
overflow does not work on 32-bit systems when time_t is 64-bit.  As
suggested by Adhemerval, update the in_time_t_range function to assume
32-bits by using int32_t.

This also brings in the header for stdint.h so we can update other
usages of __int32_t to int32_t as suggested by Adhemerval.
---

Hello,

Sorry for the delay to get this out I have been busy on the hardware side of
openrisc the last month so I haven't been able to spend time on getting this
out.

The patch ends up doing a test fix and some lib code fixes, I can split it to
separate small patches.  But since as a whole it's small I feel leaving it
together is best.

-Stafford

 include/time.h    | 10 ++++++----
 time/tst-itimer.c |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/time.h b/include/time.h
index 4372bfbd96..ba3c5116cf 100644
--- a/include/time.h
+++ b/include/time.h
@@ -11,6 +11,7 @@
 # include <sys/time.h>
 # include <time-clockid.h>
 # include <sys/time.h>
+# include <stdint.h>
 
 extern __typeof (strftime_l) __strftime_l;
 libc_hidden_proto (__strftime_l)
@@ -334,11 +335,12 @@ libc_hidden_proto (__time64)
    actual clock ID.  */
 #define CLOCK_IDFIELD_SIZE	3
 
-/* Check whether T fits in time_t.  */
+/* Check whether T fits in int32_t, assume all usages are for
+   sizeof(time_t) == 32.  */
 static inline bool
 in_time_t_range (__time64_t t)
 {
-  time_t s = t;
+  int32_t s = t;
   return s == t;
 }
 
@@ -445,8 +447,8 @@ timespec64_to_timeval64 (const struct __timespec64 ts64)
    and suseconds_t.  */
 struct __timeval32
 {
-  __int32_t tv_sec;         /* Seconds.  */
-  __int32_t tv_usec;        /* Microseconds.  */
+  int32_t tv_sec;         /* Seconds.  */
+  int32_t tv_usec;        /* Microseconds.  */
 };
 
 /* Conversion functions for converting to/from __timeval32  */
diff --git a/time/tst-itimer.c b/time/tst-itimer.c
index 929c2b74c7..bd7d7afe83 100644
--- a/time/tst-itimer.c
+++ b/time/tst-itimer.c
@@ -100,7 +100,7 @@ do_test (void)
 
       /* Linux does not provide 64 bit time_t support for getitimer and
 	 setitimer on architectures with 32 bit time_t support.  */
-      if (sizeof (__time_t) == 8)
+      if (__KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64)
 	{
 	  TEST_COMPARE (setitimer (timers[i], &it, NULL), 0);
 	  TEST_COMPARE (setitimer (timers[i], &(struct itimerval) { 0 },
@@ -131,7 +131,7 @@ do_test (void)
       it.it_interval.tv_usec = 20;
       it.it_value.tv_sec = 30;
       it.it_value.tv_usec = 40;
-      if (sizeof (__time_t) == 8)
+      if (__KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64)
 	{
 	  TEST_COMPARE (setitimer (timers[i], &it, NULL), 0);
 
-- 
2.31.1

