From: Stafford Horne <shorne@gmail.com>
Date: Fri, 20 Mar 2020 16:21:14 +0900
Subject: [OpenRISC] Fpu tininess
Message-ID: <CAAfxs75F6mcX_qHPYLzCbudeONXkSCOqNcXGRR4o+bgMDZ_VxQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Andrey,

Thanks for replying to the question about fusesoc.

I've been meaning to ask you a question about our fpu implementation.
Currently for glibc most  floating point math routines use 64-bit double
precision.  Anything not handled by the architecture is emulated.

I have written the emulation patches but the tests are having issues with
underflow flags being incorrectly set sometimes.

I have a hunch it may be due to my tininess setting.   Do you know what we
should set for:

_FP_TININESS_AFTER_ROUNDING

?

The glibc patch
https://github.com/openrisc/or1k-glibc/commit/4748177bdde92846974fc8ec523d212d6db74aa0

The gcc patch
https://github.com/stffrdhrn/gcc/commit/8e99e252edc130162b6d2d7bdef2180305389053
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20200320/457573eb/attachment.html>
