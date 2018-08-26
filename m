From: H. Peter Anvin <hpa@zytor.com>
Date: Sun, 26 Aug 2018 16:20:19 -0700
Subject: [OpenRISC] [PATCH] treewide: remove current_text_addr
In-Reply-To: <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
Message-ID: <e425d208-214b-06a2-a032-7442a10388fc@zytor.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/26/18 12:30, H. Peter Anvin wrote:
> Here is a full-blown (user space) test program demonstrating the whole
> technique and how to use it.
> 
> 	-hpa

Incidentally, it looks like _RET_IP_ really should be defined as:


/*
 * Is there any reason whatsoever to have _RET_IP_ an unsigned int
 * rather than a pointer throughout?
 */

#define _RET_IP_PTR_ \
	__builtin_extract_return_addr(__builtin_return_addr(0))
#define _RET_IP_ ((unsigned long)_RET_IP_PTR_)

On some architectures __builtin_extract_return_addr() is apparently
necessary; its a nop on x86.  Why that isn't part of
__builtin_return_addr() one can really wonder.

So, checking into all of this, the generic _THIS_IP_ DOES NOT WORK on
x86.  I have tried a tons of variants, including adding various asm
volatile(...) instructions, and no matter what I do, it will always
return the address of the surrounding function rather than any kind of
local IP.  The only way to get a localized address seems to be in
assembly, but even so, there is absolutely no guarantee that the value
of _THIS_IP_ has anything to do with where the code is otherwise
localized in the function.

From examining the output of gcc, the fundamental problem seems to be
that *no matter what* one do with the label, unless gcc actually
produces a computed goto somewhere in the code, that it can't remove
with dead-code elimination or constant propagation, it will arbitrarily
hoist the labels all the way to the beginning of the function. Given
that, I suspect that other versions of gcc might have similar problems.

This is the closest thing to arch-neutral I have been able to find that
also works on x86, while not at the same time horribly polluting the
namespace:

#define __here(n) ___here_ ## n
#define __hereasm(n) ".L___here_" #n
#define _THIS_IP_CTR_(n)					\
	({							\
		extern const char __here(n) asm(__hereasm(n));	\
		asm volatile(__hereasm(n) ": /* _THIS_IP_ */"); \
		(unsigned long)&__here(n);			\
	})
#define _THIS_IP_ _THIS_IP_CTR_(__COUNTER__)

The use of asm volatile() to define a label means that the position in
the instruction stream is at least reasonably well-defined.

	-hpa
