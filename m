From: Stafford Horne <shorne@gmail.com>
Date: Sun, 8 Oct 2017 21:23:57 +0900
Subject: [OpenRISC] [PATCH v5 1/6] sim: cgen: add remainder functions
 (needed for OR1K lf.rem.[sd])
In-Reply-To: <22127605-6ea8-05c4-03a6-cc37478bd459@polymtl.ca>
References: <20171005134912.26799-1-shorne@gmail.com>
 <20171005134912.26799-2-shorne@gmail.com>
 <22127605-6ea8-05c4-03a6-cc37478bd459@polymtl.ca>
Message-ID: <20171008122357.GA2958@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Oct 07, 2017 at 11:52:30AM -0400, Simon Marchi wrote:
> As far as I can tell, this patch looks good, but I'm more or less clueless about floating point stuff...
> 
> I just pointed out nits:
> 
> On 2017-10-05 09:49 AM, Stafford Horne wrote:
> > From: Peter Gavin <pgavin@gmail.com>
> >
> > * sim/common/ChangeLog:
> >
> > 2016-05-21  Peter Gavin  <pgavin@gmail.com>
> > 	    Stafford Horne <shorne@gmail.com>
> >
> > 	* cgen-accfp.c (remsf, remdf): New function.
> > 	(cgen_init_accurate_fpu): Add remsf and remdf.
> > 	* cgen-fpu.h (cgen_fp_ops): Add remsf, remdf, remxf and remtf.
> > 	* sim-fpu.c (sim_fpu_rem): New function.
> 
> Mention the change to sim_fpu_print_status.

Right, Thank you.

> sim-fpu.c contains other changes (comments added, lines removed).  If you think the changes belong with this patch, mention them here, otherwise submit them as a separate patch.

I just removed them, they are noise.  I saw them when I reviewed the patch
but was not sure if it would be an issue to keep them.

> > @@ -1551,6 +1551,89 @@ sim_fpu_div (sim_fpu *f,
> >
> >
> >  INLINE_SIM_FPU (int)
> > +sim_fpu_rem (sim_fpu *f,
> > +	     const sim_fpu *l,
> > +	     const sim_fpu *r)
> > +{
> > +  if (sim_fpu_is_snan (l))
> > +    {
> > +      *f = *l;
> > +      f->class = sim_fpu_class_qnan;
> > +      return sim_fpu_status_invalid_snan;
> > +    }
> > +  if (sim_fpu_is_snan (r))
> > +    {
> > +      *f = *r;
> > +      f->class = sim_fpu_class_qnan;
> > +      return sim_fpu_status_invalid_snan;
> > +    }
> > +  if (sim_fpu_is_qnan (l))
> > +    {
> > +      *f = *l;
> > +      f->class = sim_fpu_class_qnan;
> > +      return 0;
> > +    }
> > +  if (sim_fpu_is_qnan (r))
> > +    {
> > +      *f = *r;
> > +      f->class = sim_fpu_class_qnan;
> > +      return 0;
> > +    }
> > +  if (sim_fpu_is_infinity (l))
> > +    {
> > +      *f = sim_fpu_qnan;
> > +      return sim_fpu_status_invalid_irx;
> > +    }
> > +  if (sim_fpu_is_zero (r))
> > +    {
> > +      *f = sim_fpu_qnan;
> > +      return sim_fpu_status_invalid_div0;
> > +    }
> > +  if (sim_fpu_is_zero (l))
> > +    {
> > +      *f = *l;
> > +      return 0;
> > +    }
> > +  if (sim_fpu_is_infinity (r))
> > +    {
> > +      *f = *l;
> > +      return 0;
> > +    }
> > +  {
> > +    sim_fpu n, tmp;
> > +
> > +    /* Remainder is calculated as l-n*r, where n is l/r rounded to the
> > +       nearest integer.  The variable n is rounded half even.  */
> > +
> > +    sim_fpu_div (&n, l, r);
> > +    sim_fpu_round_64 (&n, 0, 0);
> > +
> > +    if (n.normal_exp < -1) /* If n looks like zero just return l.  */
> > +      {
> > +	*f = *l;
> > +	return 0;
> > +      }
> > +    else if (n.class == sim_fpu_class_number
> > +	&& n.normal_exp <= (NR_FRAC_GUARD)) /* If not too large round.  */
> 
> This line should be aligned with the opening parenthesis (well, one char to the right).

Right, that does move the comment out of the 80 char range, but just the
ending '*/'.  I hope thats ok.

> > +      do_normal_round (&n, (NR_FRAC_GUARD) - n.normal_exp, sim_fpu_round_near);
> > +
> > +    /* Mark 0's as zero so multiply can detect zero.  */
> > +    if (n.fraction == 0)
> > +      n.class = sim_fpu_class_zero;
> > +
> > +    /* Calculate n*r.  */
> > +    sim_fpu_mul (&tmp, &n, r);
> > +    sim_fpu_round_64 (&tmp, 0, 0);
> > +
> > +    /* Finally calculate l-n*r.  */
> > +    sim_fpu_sub (f, l, &tmp);
> > +
> > +    return 0;
> > +  }
> > +}
> 
> Thanks,
>
> Simon

Thank you,
-Stafford
