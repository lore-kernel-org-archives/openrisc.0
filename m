From: H. Peter Anvin <hpa@zytor.com>
Date: Mon, 27 Aug 2018 05:26:53 -0700
Subject: [OpenRISC] [PATCH] treewide: remove current_text_addr
In-Reply-To: <20180827073358.GV24124@hirez.programming.kicks-ass.net>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
 <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
 <20180827073358.GV24124@hirez.programming.kicks-ass.net>
Message-ID: <f9896d68-4a49-e666-cea5-a9c0522f1658@zytor.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/27/18 00:33, Peter Zijlstra wrote:
> 
> What problem are we trying to solve? _THIS_IP_ and _RET_IP_ work fine.
> We're 'good' at dealing with text addresses, we use them for call stacks
> and all sorts. Why does this need changing?
> 

_RET_IP_ works fine, with the following two caveats:

1. To get a unique IP for each call site, the function call needs to be
   tailcall protected (easily done by wrapping the function in an
  __always_inline function with the notailcall() function I described
  earlier.  Alternatively, a generic macro wrapper for the same thing:

  #define notailcall(x) ({ typeof(x) _x = (x); asm volatile("");  _x; })

2. To uniformly get the return IP, it needs to be defined as:

#define _RET_IP_((unsigned long) \
__builtin_extract_return_addr(__builtin_return_address(0)))

[sorry for the line wrapping]

Using the type unsigned long instead of void * seems kind of pointless
though.


_THIS_IP_, however, is completely ill-defined, other than being an
address *somewhere* in the same global function (not even necessarily
the same function if the function is static!)  As my experiment show, in
many (nearly) cases gcc will hoist the address all the way to the top of
the function, at least for the current generic implementation.

For the case where _THIS_IP_ is passed to an out-of-line function in all
cases, it is extra pointless because all it does is increase the
footprint of every caller: _RET_IP_ is inherently passed to the function
anyway, and with tailcall protection it will uniquely identify a callsite.

For the case where _THIS_IP_ is used inline, I believe the version I
described will at the very least avoid hoisting around volatile accesses
like READ_ONCE(). Surrounding the marked code with asm volatile("");
[which should be turned into a macro or inline, obviously] might be
necessary for it to make any kind of inherent sense.

The proposed "location identifier" does have a serious problem: with
inline functions you might very well have a bunch of duplicates pointing
into the inline function, so a single callsite isn't identifiable.

	-hpa

