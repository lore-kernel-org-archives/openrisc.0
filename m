From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Mar 2018 15:11:27 +0100
Subject: [OpenRISC] [RFC PATCH 6/6] arch: add untagged_addr definition
	for other arches
In-Reply-To: <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
 <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
Message-ID: <CAK8P3a0NZfxoxeJbrebBmZDqQhD9s12xpUwMoM-rZzH8aezuYA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 9, 2018 at 3:02 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> To allow arm64 syscalls accept tagged pointers from userspace, we must
> untag them when they are passed to the kernel. Since untagging is done in
> generic parts of the kernel (like the mm subsystem), the untagged_addr
> macro should be defined for all architectures.
>
> Define it as a noop for all other architectures besides arm64.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/alpha/include/asm/uaccess.h      | 2 ++
>  arch/arc/include/asm/uaccess.h        | 1 +
>  arch/arm/include/asm/uaccess.h        | 2 ++
>  arch/blackfin/include/asm/uaccess.h   | 2 ++
>  arch/c6x/include/asm/uaccess.h        | 2 ++
>  arch/cris/include/asm/uaccess.h       | 2 ++
>  arch/frv/include/asm/uaccess.h        | 2 ++
>  arch/ia64/include/asm/uaccess.h       | 2 ++
>  arch/m32r/include/asm/uaccess.h       | 2 ++
>  arch/m68k/include/asm/uaccess.h       | 2 ++
>  arch/metag/include/asm/uaccess.h      | 2 ++
>  arch/microblaze/include/asm/uaccess.h | 2 ++
>  arch/mips/include/asm/uaccess.h       | 2 ++
>  arch/mn10300/include/asm/uaccess.h    | 2 ++
>  arch/nios2/include/asm/uaccess.h      | 2 ++
>  arch/openrisc/include/asm/uaccess.h   | 2 ++
>  arch/parisc/include/asm/uaccess.h     | 2 ++
>  arch/powerpc/include/asm/uaccess.h    | 2 ++
>  arch/riscv/include/asm/uaccess.h      | 2 ++
>  arch/score/include/asm/uaccess.h      | 2 ++
>  arch/sh/include/asm/uaccess.h         | 2 ++
>  arch/sparc/include/asm/uaccess.h      | 2 ++
>  arch/tile/include/asm/uaccess.h       | 2 ++
>  arch/x86/include/asm/uaccess.h        | 2 ++
>  arch/xtensa/include/asm/uaccess.h     | 2 ++
>  include/asm-generic/uaccess.h         | 2 ++
>  26 files changed, 51 insertions(+)

I have patches to remove the blackfin, cris, frv, m32r, metag, mn10300,
score, tile and unicore32 architectures from the kernel, these should be
part of linux-next in the next few days. It's not a big issue, but if you keep
patching them, this will cause a merge conflict.

It might be easier to drop them from your patch as well.

    Arnd
