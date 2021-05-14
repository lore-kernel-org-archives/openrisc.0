From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Fri, 14 May 2021 19:45:16 +0000
Subject: [OpenRISC] [PATCH v2 00/13] Unify asm/unaligned.h around struct
 helper
In-Reply-To: <CAHk-=wih8UHDwJ8x6m-p0PQ7o4S4gOBwGNs=w=q10GNY7A-70w@mail.gmail.com>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com>
 <2408c893-4ae7-4f53-f58c-497c91f5b034@synopsys.com>
 <CAHk-=wih8UHDwJ8x6m-p0PQ7o4S4gOBwGNs=w=q10GNY7A-70w@mail.gmail.com>
Message-ID: <14016937-b9c3-c131-db18-f97081806c7f@synopsys.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 5/14/21 12:22 PM, Linus Torvalds wrote:
> On Fri, May 14, 2021 at 11:52 AM Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
>> Wasn't the new zlib code slated for 5.14. I don't see it in your master yet
> You're right, I never actually committed it, since it was specific to
> ARC and -O3

Well, not really, the issue manifested in ARC O3 testing, but I showed 
the problem existed for arm64 gcc too.

> and I wasn't entirely happy with the amount of testing it
> got (with Heiko pointing out that the s390 stuff needed more fixes for
> the change).

With his addon patch everything seemed hunky dory.

> The patch below is required on top of your patch to make it compile
> for s390 as well.
> Tested with kernel image decompression, and also btrfs with file
> compression; both software and hardware compression.
> Everything seems to work.

> So in fact it's not even queued up for 5.14 due to this all, I just dropped it.

But Why. Can't we throw it in linux-next for 5.14. I promise to test it 
- and will likely hit any corner cases. Also for the time being we could 
force just that file/files to build for -O3 to stress test the aspects 
that were fragile.

>>>    and the biggy
>>> case didn't even use "get_unaligned()").
>> Indeed this series is sort of orthogonal to that bug, but IMO that bug
>> still exists in 5.13 for -O3 build, granted that is not enabled for !ARC.
> Right, the zlib bug is still there.
>
> But Arnd's series wouldn't even fix it: right now inffast has its own
> - ugly and slow - special 2-byte-only version of "get_unaligned()",
> called "get_unaligned16()".

I know that's why said they are orthogonal.


> And because it's ugly and slow, it's not actually used for
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
>
> Vineet - maybe the fix is to not take my patch to update to a newer
> zlib, but to just fix inffast to use the proper get_unaligned(). Then
> Arnd's series _would_ actually fix all this..

OK if you say so.

-Vineet
