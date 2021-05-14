From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 14 May 2021 21:31:59 +0200
Subject: [OpenRISC] [PATCH v2 00/13] Unify asm/unaligned.h around struct
 helper
In-Reply-To: <CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com>
Message-ID: <CAK8P3a2q8zEy+eQ1RJHT7UbD9E+KofKNjKxMHJ6hreHN0J_mEQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, May 14, 2021 at 7:32 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, May 14, 2021 at 3:02 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > I've included this version in the asm-generic tree for 5.14 already,
> > addressing the few issues that were pointed out in the RFC. If there
> > are any remaining problems, I hope those can be addressed as follow-up
> > patches.
>
> This continues to look great to me, and now has the even simpler
> remaining implementation.
>
> I'd be tempted to just pull it in for 5.13, but I guess we don't
> actually have any _outstanding_ bug in this area (the bug was in our
> zlib code, required -O3 to trigger, has been fixed now, and the biggy
> case didn't even use "get_unaligned()").
>
> So I guess your 5.14 timing is the right thing to do.

Yes, I think that's best, just in case something does come up. While all the
object code I looked at does appear better, this is one of those areas that
can be hard to pinpoint if we hit a regression in a particular combination of
architecture+compiler+source file.

I have pushed a signed tag to
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
asm-generic-unaligned-5.14

and plan to send that in the 5.14 merge window unless you decide to
take it now after all.

        Arnd
