From: Joseph Myers <joseph@codesourcery.com>
Date: Mon, 16 Aug 2021 17:12:04 +0000
Subject: [OpenRISC] [PATCH v2] time: Fix overflow itimer tests on 32-bit
 systems
In-Reply-To: <YRhCqNWB1MC++TAO@antec>
References: <20210806094217.3227877-1-shorne@gmail.com>
 <0f577bc8-bef8-6c06-aaa9-57bf16d8443b@linaro.org> <YRhCqNWB1MC++TAO@antec>
Message-ID: <alpine.DEB.2.22.394.2108161710590.136350@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

I'm seeing a build failure in the glibc testsuite for i686-gnu:

tst-itimer.c: In function 'do_test':
tst-itimer.c:103:11: error: '__KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64' undeclared (first use in this function)
  103 |       if (__KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64)
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tst-itimer.c:103:11: note: each undeclared identifier is reported only once for each function it appears in

https://sourceware.org/pipermail/libc-testresults/2021q3/008412.html

-- 
Joseph S. Myers
joseph at codesourcery.com
