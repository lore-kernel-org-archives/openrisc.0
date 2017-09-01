From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Fri, 01 Sep 2017 09:56:54 +0200
Subject: [OpenRISC] [PATCH v4 1/5] sim: cgen: add remainder functions
 (needed for OR1K lf.rem.[sd])
In-Reply-To: <20170831223321.GE2609@lianli.shorne-pla.net>
References: <cover.1496066478.git.shorne@gmail.com>
 <643da7dcb7d9913a1b239f3aae0ebaebb85a00d7.1496066478.git.shorne@gmail.com>
 <fefc0514a4141b314871eb50efc9abf8@polymtl.ca>
 <20170831223321.GE2609@lianli.shorne-pla.net>
Message-ID: <acc55ba51a1e8eee8547422ef78d08c5@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-09-01 00:33, Stafford Horne wrote:
>> I can't tell for sure because I'm not maintainer of sim/, but I 
>> suppose that
>> we would need a proper implementation that doesn't use the host fpu 
>> here.
> 
> Right, as mentioned in the summary, this is the one place that is a bit
> controversial.
> 
> I was thinking its kind of strange to not allow using libmath, since
> integer math runs on the host system, why not FPU as well?
> (probably to implement this I would just copy from libmath in the end:)

That was just my conclusion after reading the comment in sim-fpu.h:

https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=sim/common/sim-fpu.h;h=d27d80a513aa8d996a7b4c6af53fde31dcb8dad7;hb=HEAD#l54

It is easy for floating point unit implementations to return wrong or 
slightly different results.  Integer math is more consistent.

> https://sourceware.org/git/?p=glibc.git;a=blob_plain;f=sysdeps/ieee754/dbl-64/e_remainder.c;hb=HEAD
> 
> There are actually no OpenRISC cores that implement the remainder
> instruction (as its a bit complicated to do in hardware and not really 
> used
> much). I could remove it if the implementation is beyond the scope of 
> this
> series.

Indeed, it can always be contributed later.

Simon
