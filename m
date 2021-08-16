From: Joseph Myers <joseph@codesourcery.com>
Date: Mon, 16 Aug 2021 22:32:59 +0000
Subject: [OpenRISC] [PATCH v2] time: Fix overflow itimer tests on 32-bit
 systems
In-Reply-To: <YRrenWZeh103h3zX@antec>
References: <20210806094217.3227877-1-shorne@gmail.com>
 <0f577bc8-bef8-6c06-aaa9-57bf16d8443b@linaro.org> <YRhCqNWB1MC++TAO@antec>
 <alpine.DEB.2.22.394.2108161710590.136350@digraph.polyomino.org.uk>
 <YRrenWZeh103h3zX@antec>
Message-ID: <alpine.DEB.2.22.394.2108162231010.136350@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, 17 Aug 2021, Stafford Horne via Libc-alpha wrote:

> Should we provide __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 for not linux builds,
> or remove __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 from the itimer test again?
> The reason for using __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 is to pick up the
> timeval size which is different on each architecture.

I'd suggest having a macro that doesn't refer to either "kernel" or "old 
timeval" (and that is defined for both Linux and Hurd).  As far as I 
understand, the logical concept that's relevant for this test isn't either 
one of those, it's more like "setitimer supports times that cannot be 
represented in 32 bits".

-- 
Joseph S. Myers
joseph at codesourcery.com
