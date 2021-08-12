From: Vineet Gupta <vgupta@kernel.org>
Date: Thu, 12 Aug 2021 11:57:49 -0700
Subject: [OpenRISC] [PATCH -next] trap: Cleanup trap_init()
In-Reply-To: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
References: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
Message-ID: <b49eed44-0837-906c-8779-4fffb5609653@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 8/12/21 5:36 AM, Kefeng Wang wrote:
> There are some empty trap_init() in different ARCHs, introduce
> a new weak trap_init() function to cleanup them.
>
> Cc: Vineet Gupta<vgupta@kernel.org>
> Cc: Russell King<linux@armlinux.org.uk>
> Cc: Yoshinori Sato<ysato@users.sourceforge.jp>
> Cc: Ley Foon Tan<ley.foon.tan@intel.com>
> Cc: Jonas Bonn<jonas@southpole.se>
> Cc: Stefan Kristiansson<stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne<shorne@gmail.com>
> Cc: James E.J. Bottomley<James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller<deller@gmx.de>
> Cc: Michael Ellerman<mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Paul Mackerras<paulus@samba.org>
> Cc: Paul Walmsley<palmerdabbelt@google.com>
> Cc: Jeff Dike<jdike@addtoit.com>
> Cc: Richard Weinberger<richard@nod.at>
> Cc: Anton Ivanov<anton.ivanov@cambridgegreys.com>
> Cc: Andrew Morton<akpm@linux-foundation.org>
> Signed-off-by: Kefeng Wang<wangkefeng.wang@huawei.com>
> ---
>   arch/arc/kernel/traps.c      | 5 -----

Acked-by: Vineet Gupta <vgupt@kernel.org>  #arch/arc
