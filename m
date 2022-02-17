From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 17 Feb 2022 08:49:59 +0100
Subject: [OpenRISC] [PATCH v2 00/18] clean up asm/uaccess.h,
 kill set_fs for good
In-Reply-To: <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
Message-ID: <CAK8P3a3_dPbjB23QffnYMtw+5ojfwChrVC8LLMQqNctU7Nh+mQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Thu, Feb 17, 2022 at 8:20 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 16/02/2022 à 14:13, Arnd Bergmann a écrit :
> >
> > Christoph Hellwig and a few others spent a huge effort on removing
> > set_fs() from most of the important architectures, but about half the
> > other architectures were never completed even though most of them don't
> > actually use set_fs() at all.
> >
> > I did a patch for microblaze at some point, which turned out to be fairly
> > generic, and now ported it to most other architectures, using new generic
> > implementations of access_ok() and __{get,put}_kernel_nocheck().
> >
> > Three architectures (sparc64, ia64, and sh) needed some extra work,
> > which I also completed.
> >
> > The final series contains extra cleanup changes that touch all
> > architectures. Please review and test these, so we can merge them
> > for v5.18.
>
> As a further cleanup, have you thought about making a generic version of
> clear_user() ? On almost all architectures, clear_user() does an
> access_ok() then calls __clear_user() or similar.

This already exists in include/asm-generic/uaccess.h, but that file is
currently not as easy to use as it should be. I've previously looked into
what it would take to get more architectures to use common code
in that file, but I currently have no plans to work on that.

> Maybe also the same with put_user() and get_user() ? After all it is
> just access_ok() followed by __put_user() or __get_user() ? It seems
> more tricky though, as some architectures seems to have less trivial
> stuff there.

Same here: architectures can already provide a __put_user_fn()
and __get_user_fn(), to get the generic versions of the interface,
but few architectures use that. You can actually get all the interfaces
by just providing raw_copy_from_user() and raw_copy_to_user(),
but the get_user/put_user versions you get from that are fairly
inefficient.

> I also see all architectures have a prototype for strncpy_from_user()
> and strnlen_user(). Could be a common prototype instead when we have
> GENERIC_STRNCPY_FROM_USER / GENERIC_STRNLEN_USER
>
> And we have also
> user_access_begin()/user_read_access_begin()/user_write_access_begin()
> which call access_ok() then do the real work. Could be made generic with
> call to some arch specific __user_access_begin() and friends after the
> access_ok() and eventually the might_fault().

In my opinion, the biggest win would be to move the type-agnostic part of
get_user/put_user into completely generic code, this is what architectures
get wrong the most, see patch 02/18 in this series for instance.

What I'd like to see is that architectures only provide fixed-length
versions of unsafe_get_user()/unsafe_put_user(), with the type-agnostic
versions (get_user(), __get_user(), unsafe_get_user() and their put
versions) all defined once in include/linux/uaccess.h based on those.

I tried implementing this in the past, but unfortunately the resulting
object code from my generalized implementation was worse than
what we have today, so I did not continue that work.

      Arnd
