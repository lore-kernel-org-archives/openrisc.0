From: Changbin Du <changbin.du@gmail.com>
Date: Wed, 14 Nov 2018 02:19:53 +0000
Subject: [OpenRISC] [PATCH] openrisc: make function cache_loop() inline
In-Reply-To: <20181113204953.GF2718@lianli.shorne-pla.net>
References: <20181112155544.7230-1-changbin.du@gmail.com>
 <20181113204953.GF2718@lianli.shorne-pla.net>
Message-ID: <20181114021952.r4wvjrvgy6hb24xh@mail.google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Nov 14, 2018 at 05:49:53AM +0900, Stafford Horne wrote:
> On Mon, Nov 12, 2018 at 11:55:44PM +0800, Changbin Du wrote:
> > The third operand of mtspr instruction must be a constraint. To guarantee
> > this condition, function cache_loop() which uses macro mtspr() must be
> > inlined. So let's force it as 'inline'. This is to fix compiling error with
> > new option CONFIG_NO_AUTO_INLINE.
> 
> Thanks for looking at this.
> 
> Do you mean, must be a 'constant'?
>
yes, it is 'constant'.  sorry for the misstake.
> I think this fix is fine for now.  Can you add it to your 'kernel hacking: GCC
> optimization for better debug experience' series?
> 
hi Yamada, could you add this patch to your kbuild tree? thanks!

> > In file included from arch/openrisc/mm/cache.c:17:0:
> > arch/openrisc/mm/cache.c: In function 'cache_loop':
> > arch/openrisc/include/asm/spr.h:20:27: warning: asm operand 0 probably doesn't match constraints
> >                               ^
> > arch/openrisc/mm/cache.c:29:3: note: in expansion of macro 'mtspr'
> >       mtspr(reg, line);
> >       ^~~~~
> > arch/openrisc/include/asm/spr.h:20:27: error: impossible constraint in 'asm'
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> Acked-by: Stafford Horne <shorne@gmail.com>
> 
> > ---
> >  arch/openrisc/mm/cache.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
> > index b747bf1fc1b6..4a4b2b6e006b 100644
> > --- a/arch/openrisc/mm/cache.c
> > +++ b/arch/openrisc/mm/cache.c
> > @@ -20,7 +20,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/tlbflush.h>
> >  
> > -static void cache_loop(struct page *page, const unsigned int reg)
> > +static inline void cache_loop(struct page *page, const unsigned int reg)
> >  {
> >  	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
> >  	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
> > -- 
> > 2.17.1
> > 

-- 
Thanks,
Changbin Du
