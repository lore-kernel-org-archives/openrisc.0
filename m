From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 19 Feb 2020 14:24:20 +0100
Subject: [OpenRISC] [PATCH v2 07/13] powerpc: add support for folded p4d
 page tables
In-Reply-To: <5b7c3929-5833-8ceb-85c8-a8e92e6a138e@c-s.fr>
References: <20200216081843.28670-1-rppt@kernel.org>
 <20200216081843.28670-8-rppt@kernel.org>
 <5b7c3929-5833-8ceb-85c8-a8e92e6a138e@c-s.fr>
Message-ID: <20200219132420.GA5559@hump>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Wed, Feb 19, 2020 at 01:07:55PM +0100, Christophe Leroy wrote:
> 
> Le 16/02/2020 à 09:18, Mike Rapoport a écrit :
> > diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> > index 206156255247..7bd4b81d5b5d 100644
> > --- a/arch/powerpc/mm/ptdump/ptdump.c
> > +++ b/arch/powerpc/mm/ptdump/ptdump.c
> > @@ -277,9 +277,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
> >   	}
> >   }
> > -static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> > +static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long start)
> >   {
> > -	pud_t *pud = pud_offset(pgd, 0);
> > +	pud_t *pud = pud_offset(p4d, 0);
> >   	unsigned long addr;
> >   	unsigned int i;
> > @@ -293,6 +293,22 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> >   	}
> >   }
> > +static void walk_p4d(struct pg_state *st, pgd_t *pgd, unsigned long start)
> > +{
> > +	p4d_t *p4d = p4d_offset(pgd, 0);
> > +	unsigned long addr;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < PTRS_PER_P4D; i++, p4d++) {
> > +		addr = start + i * P4D_SIZE;
> > +		if (!p4d_none(*p4d) && !p4d_is_leaf(*p4d))
> > +			/* p4d exists */
> > +			walk_pud(st, p4d, addr);
> > +		else
> > +			note_page(st, addr, 2, p4d_val(*p4d));
> 
> Level 2 is already used by walk_pud().
> 
> I think you have to increment the level used in walk_pud() and walk_pmd()
> and walk_pte()

Thanks for catching this!
I'll fix the numbers in the next version.
 
> > +	}
> > +}
> > +
> >   static void walk_pagetables(struct pg_state *st)
> >   {
> >   	unsigned int i;
> > @@ -306,7 +322,7 @@ static void walk_pagetables(struct pg_state *st)
> >   	for (i = pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
> >   		if (!pgd_none(*pgd) && !pgd_is_leaf(*pgd))
> >   			/* pgd exists */
> > -			walk_pud(st, pgd, addr);
> > +			walk_p4d(st, pgd, addr);
> >   		else
> >   			note_page(st, addr, 1, pgd_val(*pgd));
> >   	}
> 
> Christophe

-- 
Sincerely yours,
Mike.
