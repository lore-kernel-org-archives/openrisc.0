From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 16 Dec 2021 12:56:20 -0600
Subject: [OpenRISC] [PATCH v2 00/13] Unify asm/unaligned.h around struct
 helper
In-Reply-To: <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
Message-ID: <20211216185620.GP614@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Dec 16, 2021 at 06:29:40PM +0100, Ard Biesheuvel wrote:
> I think this series is a huge improvement, but it does not solve the
> UB problem completely. As we found, there are open issues in the GCC
> bugzilla regarding assumptions in the compiler that aligned quantities
> either overlap entirely or not at all. (e.g.,
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100363)

That isn't open, it was closed as INVALID back in May.

(Naturally) aligned quantities only overlap if they are the same datum.
This follows directly from the definition of (naturally) aligned.  There
is no mystery here.

All unaligned data need to be marked up properly.

> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is used in many places to
> conditionally emit code that violates C alignment rules.

Most of this is ABI, not C.  It is the ABI that requires certain
alignments.  Ignoring that plain does not work, but even if it would
you will end up with much slower generated code.

> whereas the following pattern makes more sense, I think, and does not
> violate any C rules in the common case:
> 
> #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>   // use unaligned accessors, which are cheap or even entirely free
> #else
>   // avoid unaligned accessors, as they are expensive; instead, reorganize
>   // the data so we don't need them (similar to setting NET_IP_ALIGN to 2)
> #endif

Yes, this looks more reasonable.

> The only remaining problem here is reinterpreting a char* pointer to a
> u32*, e.g., for accessing the IP address in an Ethernet frame when
> NET_IP_ALIGN == 2, which could suffer from the same UB problem again,
> as I understand it.

The problem is never casting a pointer to pointer to character type, and
then later back to an appriopriate pointer type.  These things are both
required to work.  The problem always is accessing something as if it
was something of another type, which is not valid C.  This however is
exactly what -fno-strict-aliasing allows, so that works as well.

But this does not have much to do with alignment.


Segher
