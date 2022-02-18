From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 18 Feb 2022 02:21:01 +0000
Subject: [OpenRISC] [PATCH v2 00/18] clean up asm/uaccess.h,
 kill set_fs for good
In-Reply-To: <CAK8P3a3_dPbjB23QffnYMtw+5ojfwChrVC8LLMQqNctU7Nh+mQ@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
 <CAK8P3a3_dPbjB23QffnYMtw+5ojfwChrVC8LLMQqNctU7Nh+mQ@mail.gmail.com>
Message-ID: <Yg8CjZwjWYIibrsd@zeniv-ca.linux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 17, 2022 at 08:49:59AM +0100, Arnd Bergmann wrote:

> Same here: architectures can already provide a __put_user_fn()
> and __get_user_fn(), to get the generic versions of the interface,
> but few architectures use that. You can actually get all the interfaces
> by just providing raw_copy_from_user() and raw_copy_to_user(),
> but the get_user/put_user versions you get from that are fairly
> inefficient.

FWIW, __{get,put}_user_{8,16,32,64} would probably make it easier to
unify.  That's where the really variable part tends to be, anyway.
IMO __get_user_fn() had been a mistake.

One thing I somewhat dislike about the series is the boilerplate in
asm/uaccess.h instances - #include <asm-generic/access-ok.h> in
a lot of them might make sense as a transitory state, but getting
stuck with those indefinitely...

	BTW, do we need user_addr_max() anymore?  The definition in
asm-generic/access-ok.h is the only one, so ifndef around it is pointless.
