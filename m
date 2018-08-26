From: H. Peter Anvin <hpa@zytor.com>
Date: Sat, 25 Aug 2018 19:38:47 -0700
Subject: [OpenRISC] [PATCH] treewide: remove current_text_addr
In-Reply-To: <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
Message-ID: <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/25/18 03:48, Helge Deller wrote:
> 
> Currently alpha, s390, sparc, sh, c6x, ia64 and parisc provide an
> inline assembly function to get the current instruction pointer. 
> As mentioned in an earlier thread, I personally would *prefer* if 
> _THIS_IP_ would use those inline assembly instructions on those
> architectures instead of the (currently used) higher C-level
> implementation.
> 

Older ones have as well, e.g. x86.

The only reason to retain the use of an assembly function would be in
the case where either:

a) the C implementation produces bad or invalid code on certain
   architectures;
b) there is a specific requirement that either an absolute or a relative
   value is used in the binary, e.g. due to constraints on relocation.
   The latter particularly comes to mind since the x86-64 implementation
   in assembly will produce movq $.,%reg (which requires relocation)
   instead of the more natural leaq .(%rip),%reg.

In the case (a) those architectures ought to be able to simply

#undef _THIS_IP_
#define _THIS_IP_ blah...

and in case (b) *those specific instances* should be using some kind of
specially flagged function e.g. current_true_ip() vs.
current_linktime_ip() or somesuch.

I also note that a lot of those functions are not marked
__always_inline, which is a serious error should the compiler ever get
the idea to out-of-line these functions, which could potentially happen
as gcc is rather bad at assigning weight to an assembly statement.

I'm also going to throw in a perhaps ugly bomb into this discussion:

_THIS_IP_ seems to be horribly ill-defined; there is no kind of
serialization, and no reason to believe it can't be arbitrarily hoisted
inside a function. Furthermore, *most of the uses of _THIS_IP_ seem to
be either discarded or passed to a function*, and the location of a
function call, unlike _THIS_IP_ is very well defined.

In that case, the use of this mechanism is completely pointless and
ought to be replaced with _RET_IP_.  It seems like most invocations of
_THIS_IP_ can be trivially replaced with _RET_IP_ inside the function,
which would also reduce the footprint of the function call, for example:

__trace_puts() is only ever called with _THIS_IP_ as the first argument;
drop that argument and use _RET_IP_ inside the function (also,
__trace_puts() only ever uses strlen() as the third argument, which gcc
can of course optimize into a constant for the case of a consta t
string, but *is that optimization actually worth it*?  In the case of
__trace_puts(), a variable strlen() would only ever need to be called in
the case of an allocation actually happening -- otherwise str is never
examined -- and again, it increases the *code size* of the call site.
If it was worthwhile it would make more sense to at least force this
into the rodata section with the string, something like the attached
file for an example; however, I have a hunch it doesn't matter.

I wouldn't be surprised if all or nearly all instances of _THIS_IP_ can
be completely removed.

	-hpa
-------------- next part --------------
A non-text attachment was scrubbed...
Name: str.c
Type: text/x-csrc
Size: 1231 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180825/4ccafb33/attachment.c>
