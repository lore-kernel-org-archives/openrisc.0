From: Stafford Horne <shorne@gmail.com>
Date: Wed, 15 Dec 2021 14:34:23 +0900
Subject: [OpenRISC] [PATCH v3 00/13] Glibc OpenRISC port
In-Reply-To: <ff7628e1-152e-10a0-d58b-9eabca4fbe12@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <cedcb34e-36e3-3bb8-07b7-8412c052b81d@linaro.org>
 <ff7628e1-152e-10a0-d58b-9eabca4fbe12@linaro.org>
Message-ID: <Ybl+XwglUy84hFd6@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Dec 14, 2021 at 10:19:03PM -0300, Adhemerval Zanella wrote:
> 
> 
> On 14/12/2021 17:25, Adhemerval Zanella wrote:
> > 
> > 
> > On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> >> This is the OpenRISC port for glibc that I have been working on.
> >>
> >> Changes since v2:
> >>  - Fixed suggestions from Joseph Myers:
> >>    - Fix comment style, and description on top of each file
> >>    - Make sure macros have parentheses when needed,
> >>    - Bump required kernel down to 5.4.0 and document
> >>    - Regenerate arch-syscall.h
> >>  - Fixed suggestions from Adhemerval:
> >>    - Remove kernel_stat.h
> >>    - Just set MMAP2_PAGE_UNIT to 8K
> >>    - Remove ioctl.c and syscall.c files
> >>  - Update TCB alignment to 32 bytes
> >>
> >> Changes since v1:
> >>  - Update api's as suggested by Florian
> >>  - Remove hard float support
> >>  - Updates to get all tests passing
> >>  - Split patch into managable bits similar to recent ARC port
> >>
> >> Documentation:
> >>
> >>   Architecture / ABI docs:
> >>    https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf
> >>
> >> Test Results:
> >>
> >>   build-many-glibcs.py:
> >>
> >>    PASS with mainline ang gcc-11.
> >>
> >>   Full test suite:
> >>
> >>    The full suite is running using the gcc-11 branch of GCC, mainline shows
> >>    issues with math soft-fp.
> >>
> >>    Note, there are a few more failures compared to before, this is due to me
> >>    running with a timeout of 30 vs usual 300.  It allows the tests to complete
> >>    faster, but I get a few more timeouts.  There were 15 timeouts which I
> >>    confirm do work if I increase the timeoutfactor. The 2 real failures marked
> >>    with * below.
> >>
> >>     # test start:    2021-12-08T19:59:00+09:00
> >>
> >>     # failures
> >>     FAIL:*elf/tst-bz15311
> > 
> > This seems to be a real issue, the output shows the new sorting algorithm seems 
> > not be enabled (the output shows the destructor order for dynamic_sort=1).  We 
> > need to figure out what is happening here.
> 
> It does like the destructor ordering  issue Florian has posted a patch [1].
> 
> [1] https://sourceware.org/pipermail/libc-alpha/2021-December/134165.html

I confirm applying these 2 patches from Florian does fix elf/tst-bz15311 for me.
Thanks for the heads up.

-Stafford
