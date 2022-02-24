From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 24 Feb 2022 09:41:29 +0100
Subject: [OpenRISC] [PATCH v2 13/18] uaccess: generalize access_ok()
In-Reply-To: <YhdB7tNDvtsYLUzr@antec>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-14-arnd@kernel.org>
 <YhdB7tNDvtsYLUzr@antec>
Message-ID: <CAK8P3a3Q6=yzX5hKX45=U80SoUXLU59sFqz-tN6U=Fr5t1m96Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 24, 2022 at 9:29 AM Stafford Horne <shorne@gmail.com> wrote:

> > -
> > -#define access_ok(addr, size)                                                \
> > -({                                                                   \
> > -     __chk_user_ptr(addr);                                           \
> > -     __range_ok((unsigned long)(addr), (size));                      \
> > -})
> > +#include <asm-generic/access_ok.h>
>
> I was going to ask why we are missing __chk_user_ptr in the generic version.
> But this is basically now a no-op so I think its OK.

Correct, the type checking is implied by making __access_ok() an inline
function that takes a __user pointer.

> Acked-by: Stafford Horne <shorne@gmail.com> [openrisc, asm-generic]

Thanks!

       Arnd
