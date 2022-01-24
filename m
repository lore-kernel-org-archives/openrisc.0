From: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Date: Mon, 24 Jan 2022 09:02:49 +0900
Subject: [OpenRISC] [PATCH] openrisc/boot: Remove unnecessary
 initialisation in memcpy().
In-Reply-To: <Ye3keps4aHhkbYzr@antec>
References: <Ye3keps4aHhkbYzr@antec>
Message-ID: <20220124000249.4295-1-kuniyu@amazon.co.jp>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From:   Stafford Horne <shorne@gmail.com>
Date:   Mon, 24 Jan 2022 08:27:54 +0900
> On Sun, Jan 23, 2022 at 11:01:00AM +0900, Kuniyuki Iwashima wrote:
> > 'd' and 's' are initialised later with 'dest_w' and 'src_w', so we need not
> > initialise them before that.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> 
> This looks fine to me.  I will queue this for the next release.

Thank you.


> 
> Just curious why are you working on OpenRISC?

While reading memcpy() variants, I found a nit to fix in x86 boot-time
memcpy() [0].  While I'm at it, I just started reading all arch ones ;)

[0]: https://lore.kernel.org/lkml/20220123015807.45005-1-kuniyu at amazon.co.jp/


> 
> -Stafford
> 
> > ---
> >  arch/openrisc/lib/memcpy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
> > index fe2177628..e2af9b510 100644
> > --- a/arch/openrisc/lib/memcpy.c
> > +++ b/arch/openrisc/lib/memcpy.c
> > @@ -101,7 +101,7 @@ void *memcpy(void *dest, __const void *src, __kernel_size_t n)
> >   */
> >  void *memcpy(void *dest, __const void *src, __kernel_size_t n)
> >  {
> > -	unsigned char *d = (unsigned char *)dest, *s = (unsigned char *)src;
> > +	unsigned char *d, *s;
> >  	uint32_t *dest_w = (uint32_t *)dest, *src_w = (uint32_t *)src;
> >  
> >  	/* If both source and dest are word aligned copy words */
> > -- 
> > 2.30.2
