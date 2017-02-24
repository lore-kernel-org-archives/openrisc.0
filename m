From: Stafford Horne <shorne@gmail.com>
Date: Sat, 25 Feb 2017 04:44:34 +0900
Subject: [OpenRISC] [PATCH v4 22/24] arch/openrisc/lib/memcpy.c: use
 correct OR1200 option
In-Reply-To: <a1ff0eac-c9a9-3019-2bff-fc0bb2bef9d7@southpole.se>
References: <cover.1487910170.git.shorne@gmail.com>
 <7ec3096414795682d3540c4b8020ff52b12b34a6.1487910170.git.shorne@gmail.com>
 <a1ff0eac-c9a9-3019-2bff-fc0bb2bef9d7@southpole.se>
Message-ID: <20170224194434.GR2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 24, 2017 at 10:24:31AM +0100, Jonas Bonn wrote:
> Hi Stafford,
> 
> Squash this patch into the memcpy patch in order to prevent surprises for
> anyone doing a git bisection through here.

Hi Jonas,

Thanks for reviewing. Good spot.

I intentionally didn't squash this one just to give Valentin credit on the
fix.  Also, since it wouldnt really be broken (build or boot issues) in the
initial patch I didnt think it would be a bisect issue.

Also, I noticed a lot of Valintin's patches pushed by people are
separated out not squashed.

-Stafford

> /Jonas
> 
> On 02/24/2017 05:32 AM, Stafford Horne wrote:
> > From: Valentin Rothberg <valentinrothberg@gmail.com>
> > 
> > The Kconfig option for OR12000 is OR1K_1200.
> > 
> > Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   arch/openrisc/lib/memcpy.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
> > index 4706f01..669887a 100644
> > --- a/arch/openrisc/lib/memcpy.c
> > +++ b/arch/openrisc/lib/memcpy.c
> > @@ -17,7 +17,7 @@
> >   #include <linux/string.h>
> > -#ifdef CONFIG_OR1200
> > +#ifdef CONFIG_OR1K_1200
> >   /*
> >    * Do memcpy with word copies and loop unrolling. This gives the
> >    * best performance on the OR1200 and MOR1KX archirectures
> 
> 
