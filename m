From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Aug 2018 14:02:43 -0700
Subject: [OpenRISC] [PATCH] treewide: remove current_text_addr
In-Reply-To: <20180821202900.208417-1-ndesaulniers@google.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
Message-ID: <CA+55aFxL-u3uvGGv0GOoHhEwV8fy=BCN1yScxKQiVMPoHtg=Wg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Aug 21, 2018 at 1:31 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I suspect that current_text_addr predated GNU C extensions for statement
> expressions and/or taking the address of a label, then the macro was
> reimplemented for every new archs include/asm/processor.h, even though
> there were very few call sites, and none required an assembly
> implementation vs the C implementation.

I actually have this very dim memory that we had some compiler issues
where a label in the code resulted in gcc generating worse code
elsewhere in that same function.

But current_text_addr() predates both the git and the BK history, so
it's all shrouded in antiquity, and even if my dim recollection is
true, it may not be true any more. There aren't so many call sites
that it is likely to matter anyway.

             Linus
