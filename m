From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Fri, 14 May 2021 18:51:59 +0000
Subject: [OpenRISC] [PATCH v2 00/13] Unify asm/unaligned.h around struct
 helper
In-Reply-To: <CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com>
Message-ID: <2408c893-4ae7-4f53-f58c-497c91f5b034@synopsys.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 5/14/21 10:32 AM, Linus Torvalds wrote:
> On Fri, May 14, 2021 at 3:02 AM Arnd Bergmann <arnd@kernel.org> wrote:
>> I've included this version in the asm-generic tree for 5.14 already,
>> addressing the few issues that were pointed out in the RFC. If there
>> are any remaining problems, I hope those can be addressed as follow-up
>> patches.
> This continues to look great to me, and now has the even simpler
> remaining implementation.
>
> I'd be tempted to just pull it in for 5.13, but I guess we don't
> actually have any _outstanding_ bug in this area (the bug was in our
> zlib code, required -O3 to trigger, has been fixed now,

Wasn't the new zlib code slated for 5.14. I don't see it in your master yet

>   and the biggy
> case didn't even use "get_unaligned()").

Indeed this series is sort of orthogonal to that bug, but IMO that bug 
still exists in 5.13 for -O3 build, granted that is not enabled for !ARC.

-Vineet

>
> So I guess your 5.14 timing is the right thing to do.
>
>          Linus

