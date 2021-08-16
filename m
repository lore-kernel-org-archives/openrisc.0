From: Stafford Horne <shorne@gmail.com>
Date: Tue, 17 Aug 2021 06:54:37 +0900
Subject: [OpenRISC] [PATCH v2] time: Fix overflow itimer tests on 32-bit
 systems
In-Reply-To: <alpine.DEB.2.22.394.2108161710590.136350@digraph.polyomino.org.uk>
References: <20210806094217.3227877-1-shorne@gmail.com>
 <0f577bc8-bef8-6c06-aaa9-57bf16d8443b@linaro.org>
 <YRhCqNWB1MC++TAO@antec>
 <alpine.DEB.2.22.394.2108161710590.136350@digraph.polyomino.org.uk>
Message-ID: <YRrenWZeh103h3zX@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Aug 16, 2021 at 05:12:04PM +0000, Joseph Myers wrote:
> I'm seeing a build failure in the glibc testsuite for i686-gnu:
> 
> tst-itimer.c: In function 'do_test':
> tst-itimer.c:103:11: error: '__KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64' undeclared (first use in this function)
>   103 |       if (__KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64)
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tst-itimer.c:103:11: note: each undeclared identifier is reported only once for each function it appears in
> 
> https://sourceware.org/pipermail/libc-testresults/2021q3/008412.html

Right sorry about that, so __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 only exists in
linux.

So it looks like for non linux the new timer test changes break.

Should we provide __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 for not linux builds,
or remove __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 from the itimer test again?
The reason for using __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 is to pick up the
timeval size which is different on each architecture.

Maybe the easiest is adding something like:

#ifndef __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64
#define __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 (sizeof (__time_t) == 8)
#endif

To the top of tst-itimer.c.  Sorry I don't have time right now to send a patch
or test this.

-Stafford 
