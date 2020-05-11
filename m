From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 11 May 2020 17:15:36 +0300
Subject: [OpenRISC] [PATCH v4 02/14] arm: add support for folded p4d
 page tables
In-Reply-To: <665dade8-727a-3318-6779-3998080da18f@samsung.com>
References: <20200414153455.21744-1-rppt@kernel.org>
 <20200414153455.21744-3-rppt@kernel.org>
 <CGME20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f@eucas1p2.samsung.com>
 <39ba8a04-d6b5-649d-c289-0c8b27cb66c5@samsung.com>
 <20200507161155.GE683243@linux.ibm.com>
 <98229ab1-fbf8-0a89-c5d6-270c828799e7@samsung.com>
 <20200508174232.GA759899@linux.ibm.com>
 <665dade8-727a-3318-6779-3998080da18f@samsung.com>
Message-ID: <20200511141536.GB983798@linux.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Marek,

On Mon, May 11, 2020 at 08:36:41AM +0200, Marek Szyprowski wrote:
> Hi Mike,
> 
> On 08.05.2020 19:42, Mike Rapoport wrote:
> > On Fri, May 08, 2020 at 08:53:27AM +0200, Marek Szyprowski wrote:
> >> On 07.05.2020 18:11, Mike Rapoport wrote:
> >>> On Thu, May 07, 2020 at 02:16:56PM +0200, Marek Szyprowski wrote:
> >>>> On 14.04.2020 17:34, Mike Rapoport wrote:
> >>>>> From: Mike Rapoport <rppt@linux.ibm.com>
> >>>>>
> >>>>> Implement primitives necessary for the 4th level folding, add walks of p4d
> >>>>> level where appropriate, and remove __ARCH_USE_5LEVEL_HACK.
> >>>>>
> >>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Can you please try the patch below:
> >
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index 963b5284d284..f86b3d17928e 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -571,7 +571,7 @@ static inline void section_update(unsigned long addr, pmdval_t mask,
> >   {
> >   	pmd_t *pmd;
> >   
> > -	pmd = pmd_off_k(addr);
> > +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, addr), addr), addr), addr);
> >   
> >   #ifdef CONFIG_ARM_LPAE
> >   	pmd[0] = __pmd((pmd_val(pmd[0]) & mask) | prot);
> This fixes kexec issue! Thanks!
> 
> 
> Feel free to add:
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 218f1c390557 ("arm: add support for folded p4d page tables")
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for testing!

The patch is still in mmotm tree, so I don't think "Fixes" apply.

Andrew, would you like me to send the fix as a formal patch or will pick
it up as a fixup?

> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

-- 
Sincerely yours,
Mike.
