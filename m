From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 13 Aug 2021 12:27:58 +1000
Subject: [OpenRISC] [PATCH -next] trap: Cleanup trap_init()
In-Reply-To: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
References: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
Message-ID: <87czqim635.fsf@mpe.ellerman.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> There are some empty trap_init() in different ARCHs, introduce
> a new weak trap_init() function to cleanup them.
>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <palmerdabbelt@google.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arc/kernel/traps.c      | 5 -----
>  arch/arm/kernel/traps.c      | 5 -----
>  arch/h8300/kernel/traps.c    | 4 ----
>  arch/hexagon/kernel/traps.c  | 4 ----
>  arch/nds32/kernel/traps.c    | 5 -----
>  arch/nios2/kernel/traps.c    | 5 -----
>  arch/openrisc/kernel/traps.c | 5 -----
>  arch/parisc/kernel/traps.c   | 4 ----
>  arch/powerpc/kernel/traps.c  | 5 -----

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
