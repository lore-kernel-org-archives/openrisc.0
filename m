From: Stafford Horne <shorne@gmail.com>
Date: Sat, 7 Aug 2021 13:49:25 +0900
Subject: [OpenRISC] [PATCH] openrisc: Fix compiler warnings in setup
In-Reply-To: <655ef6e0-defb-7467-25df-f9a13ab96694@infradead.org>
References: <20210805030035.2994973-1-shorne@gmail.com>
 <655ef6e0-defb-7467-25df-f9a13ab96694@infradead.org>
Message-ID: <CAAfxs7653w00yKVuRy4K-H3_Pe=WCutB8Tfja-hdh1rG-K+yxA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Aug 6, 2021, 4:32 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/4/21 8:00 PM, Stafford Horne wrote:
> > This was pointed out with the recent name change of or32_early_setup to
> > or1k_early_setup.  Investigating the file I found a few other warnings
> > so cleaning them up here.
> >
> >      arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype
> for 'or1k_early_setup' [-Wmissing-prototypes]
> >        220 | void __init or1k_early_setup(void *fdt)
> >         |             ^~~~~~~~~~~~~~~~
> >
> > Fix this the missing or1k_early_setup prototype warning by adding an
> > asm/setup.h file to define the prototype.
> >
> >      arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype
> for 'detect_unit_config' [-Wmissing-prototypes]
> >        246 | void __init detect_unit_config(unsigned long upr, unsigned
> long mask,
> >         |             ^~~~~~~~~~~~~~~~~~
> >
> > The function detect_unit_config is not used, just remove it.
> >
> >      arch/openrisc/kernel/setup.c:221: warning: Function parameter or
> member 'fdt' not described in 'or1k_early_setup'
> >
> > Add @fdt docs to the function comment to suppress this warning.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
>
> Hi Stafford,
>
> Does this patch apply to your openrisc tree, but not to
> linux-next?  I get a patch error when trying to apply it
> to linux-next-20210805 and this warning is still present:
>
> ../arch/openrisc/kernel/setup.c:221:13: warning: no previous prototype for
> 'or32_early_setup' [-Wmissing-prototypes]
>    221 | void __init or32_early_setup(void *fdt)
>        |             ^~~~~~~~~~~~~~~~
>
> presumably because some openrisc patches are not yet in linux-next??
>
> thanks.
>

Hi Randy,

Thats right, this patch is on top of my openrisc/for-next branch.  It
should show up in linux-next soon.

The branch is here.


https://github.com/openrisc/linux/commit/19e14f3a81d227f1c8b8d5371de28b3ab3deb556

I put this patch on the branch already. I plan to adjust if any feedback.

-stafford

>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210807/0f8dbb35/attachment.htm>
