From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Dec 2021 00:46:26 +0900
Subject: [OpenRISC] [PATCH v3 00/13] Glibc OpenRISC port
In-Reply-To: <Ybl/E2BWBGRMwF0G@antec>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <cedcb34e-36e3-3bb8-07b7-8412c052b81d@linaro.org>
 <Ybl/E2BWBGRMwF0G@antec>
Message-ID: <YcSZ0iyC6STzh9uP@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Dec 15, 2021 at 02:37:23PM +0900, Stafford Horne wrote:
> On Tue, Dec 14, 2021 at 05:25:09PM -0300, Adhemerval Zanella wrote:
> > 
> > 
> > On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> > > This is the OpenRISC port for glibc that I have been working on.
> > > 
> > > Changes since v2:
> > >  - Fixed suggestions from Joseph Myers:
> > >    - Fix comment style, and description on top of each file
> > >    - Make sure macros have parentheses when needed,
> > >    - Bump required kernel down to 5.4.0 and document
> > >    - Regenerate arch-syscall.h
> > >  - Fixed suggestions from Adhemerval:
> > >    - Remove kernel_stat.h
> > >    - Just set MMAP2_PAGE_UNIT to 8K
> > >    - Remove ioctl.c and syscall.c files
> > >  - Update TCB alignment to 32 bytes
> > > 
> > > Changes since v1:
> > >  - Update api's as suggested by Florian
> > >  - Remove hard float support
> > >  - Updates to get all tests passing
> > >  - Split patch into managable bits similar to recent ARC port
> > > 
> > > Documentation:
> > > 
> > >   Architecture / ABI docs:
> > >    https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf
> > > 
> > > Test Results:
> > > 
> > >   build-many-glibcs.py:
> > > 
> > >    PASS with mainline ang gcc-11.
> > > 
> > >   Full test suite:
> > > 
> > >    The full suite is running using the gcc-11 branch of GCC, mainline shows
> > >    issues with math soft-fp.
> > > 
> > >    Note, there are a few more failures compared to before, this is due to me
> > >    running with a timeout of 30 vs usual 300.  It allows the tests to complete
> > >    faster, but I get a few more timeouts.  There were 15 timeouts which I
> > >    confirm do work if I increase the timeoutfactor. The 2 real failures marked
> > >    with * below.
> > > 
> > >     # test start:    2021-12-08T19:59:00+09:00
> > > 
> > >     # failures
> > >     FAIL:*elf/tst-bz15311
> > 
> > This seems to be a real issue, the output shows the new sorting algorithm seems 
> > not be enabled (the output shows the destructor order for dynamic_sort=1).  We 
> > need to figure out what is happening here.
> >
> > >     FAIL: locale/tst-localedef-path-norm
> > >     FAIL: malloc/tst-dynarray-fail
> > >     FAIL: malloc/tst-dynarray-fail-mem
> > >     FAIL: nptl/tst-mutex10
> > >     FAIL: nss/tst-nss-files-hosts-getent
> > >     FAIL: nss/tst-nss-files-hosts-multi
> > >     FAIL: posix/tst-regcomp-truncated
> > >     FAIL: stdio-common/tst-vfprintf-width-prec
> > >     FAIL: stdio-common/tst-vfprintf-width-prec-alloc
> > >     FAIL: stdio-common/tst-vfprintf-width-prec-mem
> > >     FAIL: string/test-memcpy
> > >     FAIL: string/test-memcpy-large
> > >     FAIL: string/test-mempcpy
> > >     FAIL: string/tst-cmp
> > >     FAIL: support/tst-support_blob_repeat
> > >     FAIL:*timezone/tst-tzset
> > 
> > It seems the testing file system does not support sparse files or at least
> > has some limits of the file size and support_descriptor_supports_holes is
> > no deteting it.
> 
> Let me see if I can figure out the sparse file support.  If that can work
> then it would be good.  The filesystem I am using is:
> 
>  tmpfs on /tmp type tmpfs (rw,relatime)
> 
> > I think we should use a large write_offset and block_headroom, maybe
> > something larger than 32-bit offset to actually check it.  Could you
> > check if increasing both values does make the test unsupported.
> 
> I will check.

I looked into this, the following patch seems to help.  Below are some notes I was
keeping as I debugged it.

It seems the write to the tmp file was failing due the re-open not passing
O_LARGEFILE.  I am running with this patch now, and instead of failing it is
working on creating the file, but taking a long time.  I will let it run, but
need to step away now.

diff --git a/timezone/tst-tzset.c b/timezone/tst-tzset.c
index 3dad42e041..65633c4a25 100644
--- a/timezone/tst-tzset.c
+++ b/timezone/tst-tzset.c
@@ -44,7 +44,7 @@ create_tz_file (off64_t size)
 
   // Reopen for large-file support.
   close (fd);
-  fd = open64 (path, O_WRONLY);
+  fd = open64 (path, O_WRONLY|O_LARGEFILE);
   if (fd < 0)
     {
       printf ("open64 (%s) failed: %m\n", path);




Debugging

The patch below and notes are how I got to the conclusion.

  - tmsfs does support sparse files, but I am not able to write files larger
    than 4GiB.  But also as per below 2GiB seems to be a boundary.
  - We get an write error 'File too large'
  - Looking@ther kernel code I see two paths that generate this error
    but it doesn't look like I should be hitting them.
    * write size exceeds RLIMIT - though I have it set to unlimited
    * write size exceeds fs_maxbytes - on tmpfs sb->s_maxbytes = MAX_LFS_FILESIZE
                                       on 32-bit MAX_LFS_FILESIZE ((loff_t)ULONG_MAX << PAGE_SHIFT)
  - support_descriptor_supports_holes will not fail unless we run it on files
    re-opened with open64.
  - This is where I noticed that open64 was missing O_LARGEFILE.

Output with write_offset = 2LL * 1024 * 1024 * 1024 - 2;
    File size : 16 limit 160
    1x: File size : 32/2147483646 limit 160
    2x: File size : 32/4294967292 limit 160
    File size : 16 limit 160
    1x: File size : 32/2147483646 limit 160
    2x: File size : 32/4294967292 limit 160
    Single-byte write failed
    creating timezone file of size: 4095MiB failed.

Output with write_offset = 2LL * 1024 * 1024 * 1024 - 1;
    File size : 16 limit 160
    error: xwrite.c:32: write of 1 bytes failed after 0: File too large
    error: 1 test failures

Strace of running the patch, we see no O_LARGEFILE after re-open.

[pid 11318] openat(AT_FDCWD, "/tmp/tst-tzset-v0uEVn", O_RDWR|O_CREAT|O_EXCL|O_LARGEFILE, 0600) = 3
[pid 11318] getpid()                    = 11318
[pid 11318] close(3)                    = 0
[pid 11318] openat(AT_FDCWD, "/tmp/tst-tzset-v0uEVn", O_WRONLY) = 3
[pid 11318] statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0600, stx_size=0, ...}) = 0
[pid 11318] _llseek(3, 0, [0], SEEK_SET) = 0
[pid 11318] write(3, "@", 1)            = 1
[pid 11318] fsync(3)                    = 0
[pid 11318] statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0600, stx_size=1, ...}) = 0
[pid 11318] write(1, "File size : 16 limit 160\n", 25File size : 16 limit 160
) = 25
[pid 11318] _llseek(3, 2147483647, [2147483647], SEEK_SET) = 0
[pid 11318] write(3, "@", 1)            = -1 EFBIG (File too large)

diff --git a/support/support_descriptor_supports_holes.c b/support/support_descriptor_supports_holes.c
index 83bdcc71dc..46fdb6174a 100644
--- a/support/support_descriptor_supports_holes.c
+++ b/support/support_descriptor_supports_holes.c
@@ -31,15 +31,17 @@ support_descriptor_supports_holes (int fd)
          and hopefully large enough to trigger the creation of holes.
          We cannot use the file system block size as a reference here
          because it is incorrect for network file systems.  */
-      write_offset = 16 * 1024 * 1024,
+  //    write_offset = 125 * 1024 * 1024,
 
       /* Our write may add this number of additional blocks (see
          block_limit below): writing at offset 16M can require two data block
          indirections, each of which can be as large as 8KB on ext2, thus 32
          512B sectors.  */
-      block_headroom = 32,
+      block_headroom = 128,
     };
 
+  unsigned long long int write_offset = 2LL * 1024 * 1024 * 1024 - 1;
+
   struct stat64 st;
   xfstat (fd, &st);
   if (!S_ISREG (st.st_mode))
@@ -66,6 +68,7 @@ support_descriptor_supports_holes (int fd)
      the write offset.  */
   unsigned long long int block_limit = 2 * st.st_blocks + block_headroom;
 
+printf ("File size : %lld limit %lld\n", (long long int) st.st_blocks, block_limit);
   /* Write a single byte@16 megabytes.  */
   xlseek (fd, write_offset, SEEK_SET);
   xwrite (fd, &b, 1);
@@ -74,6 +77,8 @@ support_descriptor_supports_holes (int fd)
   xfstat (fd, &st);
   bool supports_holes = st.st_blocks <= block_limit;
 
+printf ("1x: File size : %lld/%lld limit %lld\n", (long long int) st.st_blocks, write_offset, block_limit);
+
   /* Also check that extending the file does not fill up holes.  */
   xftruncate (fd, 2 * write_offset);
   /* Attempt to bypass delayed allocation.  */
@@ -81,6 +86,8 @@ support_descriptor_supports_holes (int fd)
   xfstat (fd, &st);
   supports_holes = supports_holes && st.st_blocks <= block_limit;
 
+printf ("2x: File size : %lld/%lld limit %lld\n", (long long int) st.st_blocks, 2 * write_offset, block_limit);
+
   /* Return to a zero-length file.  */
   xftruncate (fd, 0);
   xlseek (fd, 0, SEEK_SET);
diff --git a/timezone/tst-tzset.c b/timezone/tst-tzset.c
index 3dad42e041..0fa06f7206 100644
--- a/timezone/tst-tzset.c
+++ b/timezone/tst-tzset.c
@@ -39,8 +39,6 @@ create_tz_file (off64_t size)
   int fd = create_temp_file ("tst-tzset-", &path);
   if (fd < 0)
     exit (1);
-  if (!support_descriptor_supports_holes (fd))
-    FAIL_UNSUPPORTED ("File %s does not support holes", path);
 
   // Reopen for large-file support.
   close (fd);
@@ -51,6 +49,9 @@ create_tz_file (off64_t size)
       exit (1);
     }
 
+  if (!support_descriptor_supports_holes (fd))
+    FAIL_UNSUPPORTED ("File %s does not support holes", path);
+
   static const char data[] = {
     0x54, 0x5a, 0x69, 0x66, 0x32, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
