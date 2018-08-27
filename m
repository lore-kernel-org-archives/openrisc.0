From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 27 Aug 2018 09:33:58 +0200
Subject: [OpenRISC] [PATCH] treewide: remove current_text_addr
In-Reply-To: <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
 <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
Message-ID: <20180827073358.GV24124@hirez.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Aug 26, 2018 at 07:52:59PM -0700, Nick Desaulniers wrote:
> On Sun, Aug 26, 2018 at 1:25 PM Linus Torvalds

> > Instead, maybe we could encourage something like
> >
> >   struct kernel_loc { const char *file; const char *fn; int line; };
> >
> >   #define __GEN_LOC__(n) \
> >         ({ static const struct kernel_loc n = { \
> >                 __FILE__, __FUNCTION__, __LINE__  \
> >            }; &n; })
> >
> >   #define _THIS_LOC_ __GEN_LOC__(__UNIQUE_ID(loc))
> >
> > which is a hell of a lot nicer to use, and actually allows gcc to
> > optimize things (try it: if you pass a _THIS_LOC_ off to an inline
> > function, and that inline function uses the name and line number, gcc
> > will pick them up directly, without the extra structure dereference.
> >
> > Wouldn't it be much nicer to pass these kinds of "location pointer"
> > around, rather than the nasty _THIS_IP_ thing?
> >
> > Certainly lockdep looks like it could easily take that "const struct
> > kernel_loc *" instead of "unsigned long ip". Makes it easy to print
> > out the lockdep info.

> This is extremely reasonable.  I can follow up with the lockdep folks
> to see if they really need _THIS_IP_ to solve their problem, or if
> there's a simpler solution that can solve their needs.  Sometimes
> taking a step back and asking for clarity around the big picture
> allows simpler solutions to shake out.

What problem are we trying to solve? _THIS_IP_ and _RET_IP_ work fine.
We're 'good' at dealing with text addresses, we use them for call stacks
and all sorts. Why does this need changing?
