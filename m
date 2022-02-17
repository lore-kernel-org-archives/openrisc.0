From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Thu, 17 Feb 2022 07:20:11 +0000
Subject: [OpenRISC] [PATCH v2 00/18] clean up asm/uaccess.h,
 kill set_fs for good
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
Message-ID: <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 16/02/2022 à 14:13, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Christoph Hellwig and a few others spent a huge effort on removing
> set_fs() from most of the important architectures, but about half the
> other architectures were never completed even though most of them don't
> actually use set_fs() at all.
> 
> I did a patch for microblaze at some point, which turned out to be fairly
> generic, and now ported it to most other architectures, using new generic
> implementations of access_ok() and __{get,put}_kernel_nocheck().
> 
> Three architectures (sparc64, ia64, and sh) needed some extra work,
> which I also completed.
> 
> The final series contains extra cleanup changes that touch all
> architectures. Please review and test these, so we can merge them
> for v5.18.

As a further cleanup, have you thought about making a generic version of 
clear_user() ? On almost all architectures, clear_user() does an 
access_ok() then calls __clear_user() or similar.

Maybe also the same with put_user() and get_user() ? After all it is 
just access_ok() followed by __put_user() or __get_user() ? It seems 
more tricky though, as some architectures seems to have less trivial 
stuff there.

I also see all architectures have a prototype for strncpy_from_user() 
and strnlen_user(). Could be a common prototype instead when we have 
GENERIC_STRNCPY_FROM_USER / GENERIC_STRNLEN_USER

And we have also 
user_access_begin()/user_read_access_begin()/user_write_access_begin() 
which call access_ok() then do the real work. Could be made generic with 
call to some arch specific __user_access_begin() and friends after the 
access_ok() and eventually the might_fault().

Christophe
