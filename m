From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 18 Feb 2022 10:20:38 +0100
Subject: [OpenRISC] [PATCH v2 00/18] clean up asm/uaccess.h,
 kill set_fs for good
In-Reply-To: <Yg8CjZwjWYIibrsd@zeniv-ca.linux.org.uk>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
 <CAK8P3a3_dPbjB23QffnYMtw+5ojfwChrVC8LLMQqNctU7Nh+mQ@mail.gmail.com>
 <Yg8CjZwjWYIibrsd@zeniv-ca.linux.org.uk>
Message-ID: <CAK8P3a0_uJQXshn5N0o4J_8dVPNCw885xGHqnKj3i5kYB+GtBg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

n Fri, Feb 18, 2022 at 3:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Feb 17, 2022 at 08:49:59AM +0100, Arnd Bergmann wrote:
>
> > Same here: architectures can already provide a __put_user_fn()
> > and __get_user_fn(), to get the generic versions of the interface,
> > but few architectures use that. You can actually get all the interfaces
> > by just providing raw_copy_from_user() and raw_copy_to_user(),
> > but the get_user/put_user versions you get from that are fairly
> > inefficient.
>
> FWIW, __{get,put}_user_{8,16,32,64} would probably make it easier to
> unify.  That's where the really variable part tends to be, anyway.
> IMO __get_user_fn() had been a mistake.

I've prototyped this now, to see what this might look like, see
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?h=generic-get_user-prototype

This adds generic inline version of {__get,get,__put,put}_user()
and converts x86 to (optionally) use it. This builds with gcc-5
through gcc-11 on 32-bit and 64-bit x86, using asm-goto with
outputs where possible, and requiring a minimum set of macro
definitions from the architecture. Compiling with clang produces
no warnings but does cause a linker issue at the moment, so
there is probably at least one bug in it.

Aside from compile-testing, I have not tried to verify if this
is correct or efficient, but let me know if you think this is headed
in the right direction.

> One thing I somewhat dislike about the series is the boilerplate in
> asm/uaccess.h instances - #include <asm-generic/access-ok.h> in
> a lot of them might make sense as a transitory state, but getting
> stuck with those indefinitely...

Christoph also complained about it, the problem for now is that
asm-generic/access_ok.h must first see the macro definitions for
architectures that override any of the contents, but access_ok()
itself is used at least in some of the asm/uaccess.h files as well,
so it must be included in the middle of it, until more of the uaccess.h
implementation is moved to linux/uaccess.h in an architecture
independent way.

Would you prefer having an asm/access_ok.h that falls back to
the asm-generic version but can have an architecture specific
override when needed (ia64, arm64, x86, um)?

>         BTW, do we need user_addr_max() anymore?  The definition in
> asm-generic/access-ok.h is the only one, so ifndef around it is pointless.

Right, the v2 changes got rid of the last override, so it could get
hardcoded to TASK_SIZE_MAX, or we can convert the five
references to just use that instead and remove it altogether:

arch/arm64/kernel/traps.c:      if (address >= user_addr_max()) {
                 \
arch/parisc/kernel/signal.c:    if (start >= user_addr_max() - sigframe_size)
arch/parisc/kernel/signal.c:            if (A(&usp[0]) >=
user_addr_max() - 5 * sizeof(int))
lib/strncpy_from_user.c:        max_addr = user_addr_max();
lib/strnlen_user.c:     max_addr = user_addr_max();

user_addr_max() first showed up in architecture-independent code in
c5389831cda3 ("sparc: Fix user_addr_max() definition."), and from that
I think the original intent is no longer useful.

          Arnd
