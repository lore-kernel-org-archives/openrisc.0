From: Nick Desaulniers <ndesaulniers@google.com>
Date: Sun, 26 Aug 2018 19:52:59 -0700
Subject: [OpenRISC] [PATCH] treewide: remove current_text_addr
In-Reply-To: <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
Message-ID: <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Aug 26, 2018 at 1:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Honestly, I'd suggest:
>
>  - just do the current_text_addr() to _THIS_IP_ conversion
>
>  - keep _THIS_IP_ and make it be the generic one, and screw the whole
> "some architectures might implement is better" issue. Nobody cares.

And mention it to the compiler vendors as this seems like a case where
code gen can be improved.

>
>  - try to convince people to move away from the "we want the kernel
> instruction pointer for the call" model entirely, and consider this a
> "legacy" issue.
>
> The whole instruction pointer is a nasty thing. We should discourage
> it and not make complex infrastructure for it.

Yes, please.  I think we should strive for simplicity here.

>
> Instead, maybe we could encourage something like
>
>   struct kernel_loc { const char *file; const char *fn; int line; };
>
>   #define __GEN_LOC__(n) \
>         ({ static const struct kernel_loc n = { \
>                 __FILE__, __FUNCTION__, __LINE__  \
>            }; &n; })
>
>   #define _THIS_LOC_ __GEN_LOC__(__UNIQUE_ID(loc))
>
> which is a hell of a lot nicer to use, and actually allows gcc to
> optimize things (try it: if you pass a _THIS_LOC_ off to an inline
> function, and that inline function uses the name and line number, gcc
> will pick them up directly, without the extra structure dereference.
>
> Wouldn't it be much nicer to pass these kinds of "location pointer"
> around, rather than the nasty _THIS_IP_ thing?
>
> Certainly lockdep looks like it could easily take that "const struct
> kernel_loc *" instead of "unsigned long ip". Makes it easy to print
> out the lockdep info.
>
> Ok, I didn't try to convert anybody, so maybe people who currently use
> _THIS_IP_ or current_text_addr() have some fundamental reason why they
> want just that, but let's not male _THIS_IP_ more complex than it
> needs to be.
>
> Hmm?
>
>              Linus

This is extremely reasonable.  I can follow up with the lockdep folks
to see if they really need _THIS_IP_ to solve their problem, or if
there's a simpler solution that can solve their needs.  Sometimes
taking a step back and asking for clarity around the big picture
allows simpler solutions to shake out.
-- 
Thanks,
~Nick Desaulniers
