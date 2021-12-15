From: Stafford Horne <shorne@gmail.com>
Date: Wed, 15 Dec 2021 14:37:23 +0900
Subject: [OpenRISC] [PATCH v3 00/13] Glibc OpenRISC port
In-Reply-To: <cedcb34e-36e3-3bb8-07b7-8412c052b81d@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <cedcb34e-36e3-3bb8-07b7-8412c052b81d@linaro.org>
Message-ID: <Ybl/E2BWBGRMwF0G@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Dec 14, 2021 at 05:25:09PM -0300, Adhemerval Zanella wrote:
> 
> 
> On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> > This is the OpenRISC port for glibc that I have been working on.
> > 
> > Changes since v2:
> >  - Fixed suggestions from Joseph Myers:
> >    - Fix comment style, and description on top of each file
> >    - Make sure macros have parentheses when needed,
> >    - Bump required kernel down to 5.4.0 and document
> >    - Regenerate arch-syscall.h
> >  - Fixed suggestions from Adhemerval:
> >    - Remove kernel_stat.h
> >    - Just set MMAP2_PAGE_UNIT to 8K
> >    - Remove ioctl.c and syscall.c files
> >  - Update TCB alignment to 32 bytes
> > 
> > Changes since v1:
> >  - Update api's as suggested by Florian
> >  - Remove hard float support
> >  - Updates to get all tests passing
> >  - Split patch into managable bits similar to recent ARC port
> > 
> > Documentation:
> > 
> >   Architecture / ABI docs:
> >    https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf
> > 
> > Test Results:
> > 
> >   build-many-glibcs.py:
> > 
> >    PASS with mainline ang gcc-11.
> > 
> >   Full test suite:
> > 
> >    The full suite is running using the gcc-11 branch of GCC, mainline shows
> >    issues with math soft-fp.
> > 
> >    Note, there are a few more failures compared to before, this is due to me
> >    running with a timeout of 30 vs usual 300.  It allows the tests to complete
> >    faster, but I get a few more timeouts.  There were 15 timeouts which I
> >    confirm do work if I increase the timeoutfactor. The 2 real failures marked
> >    with * below.
> > 
> >     # test start:    2021-12-08T19:59:00+09:00
> > 
> >     # failures
> >     FAIL:*elf/tst-bz15311
> 
> This seems to be a real issue, the output shows the new sorting algorithm seems 
> not be enabled (the output shows the destructor order for dynamic_sort=1).  We 
> need to figure out what is happening here.
>
> >     FAIL: locale/tst-localedef-path-norm
> >     FAIL: malloc/tst-dynarray-fail
> >     FAIL: malloc/tst-dynarray-fail-mem
> >     FAIL: nptl/tst-mutex10
> >     FAIL: nss/tst-nss-files-hosts-getent
> >     FAIL: nss/tst-nss-files-hosts-multi
> >     FAIL: posix/tst-regcomp-truncated
> >     FAIL: stdio-common/tst-vfprintf-width-prec
> >     FAIL: stdio-common/tst-vfprintf-width-prec-alloc
> >     FAIL: stdio-common/tst-vfprintf-width-prec-mem
> >     FAIL: string/test-memcpy
> >     FAIL: string/test-memcpy-large
> >     FAIL: string/test-mempcpy
> >     FAIL: string/tst-cmp
> >     FAIL: support/tst-support_blob_repeat
> >     FAIL:*timezone/tst-tzset
> 
> It seems the testing file system does not support sparse files or at least
> has some limits of the file size and support_descriptor_supports_holes is
> no deteting it.

Let me see if I can figure out the sparse file support.  If that can work
then it would be good.  The filesystem I am using is:

 tmpfs on /tmp type tmpfs (rw,relatime)

> I think we should use a large write_offset and block_headroom, maybe
> something larger than 32-bit offset to actually check it.  Could you
> check if increasing both values does make the test unsupported.

I will check.

-Stafford
