From: Stafford Horne <shorne@gmail.com>
Date: Thu, 21 Dec 2017 21:55:52 +0900
Subject: [OpenRISC] [PATCH v3 4/4] tdesc: handle arbitrary strings in
 tdesc_register_in_reggroup_p
In-Reply-To: <842bc3de1ad8cd8a568127aedeb58275@polymtl.ca>
References: <20171219142257.13402-1-shorne@gmail.com>
 <20171219142257.13402-5-shorne@gmail.com>
 <842bc3de1ad8cd8a568127aedeb58275@polymtl.ca>
Message-ID: <20171221125552.GE32243@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Dec 20, 2017 at 10:29:31PM -0500, Simon Marchi wrote:
> On 2017-12-19 09:22, Stafford Horne wrote:
> > @@ -1299,26 +1294,9 @@ tdesc_register_in_reggroup_p (struct gdbarch
> > *gdbarch, int regno,
> >  {
> >    struct tdesc_reg *reg = tdesc_find_register (gdbarch, regno);
> > 
> > -  if (reg != NULL && !reg->group.empty ())
> > -    {
> > -      int general_p = 0, float_p = 0, vector_p = 0;
> > -
> > -      if (reg->group == "general")
> > -	general_p = 1;
> > -      else if (reg->group == "float")
> > -	float_p = 1;
> > -      else if (reg->group == "vector")
> > -	vector_p = 1;
> > -
> > -      if (reggroup == float_reggroup)
> > -	return float_p;
> > -
> > -      if (reggroup == vector_reggroup)
> > -	return vector_p;
> > -
> > -      if (reggroup == general_reggroup)
> > -	return general_p;
> > -    }
> > +  if (reg != NULL && !reg->group.empty ()
> > +      && (strcmp (reg->group.c_str (), reggroup_name (reggroup)) == 0))
> 
> I suggest
> 
>   reg->group == reggroup_name (reggroup)

OK. Strange, I thought I tried that first but was having issues with std::string
vs (char *), but I just tried again and it works fine.

> > +	return 1;
> > 
> >    if (reg != NULL
> >        && (reggroup == save_reggroup || reggroup == restore_reggroup))
> > @@ -1421,6 +1399,28 @@ tdesc_use_registers (struct gdbarch *gdbarch,
> >  	void **slot = htab_find_slot (reg_hash, reg.get (), INSERT);
> > 
> >  	*slot = reg.get ();
> > +	/* Add reggroup if its new.  */
> > +	if (!reg->group.empty ())
> > +	  {
> > +	    struct reggroup *group;
> > +	    bool group_exists = false;
> > +
> > +	    for (group = reggroup_next (gdbarch, NULL);
> > +		 group != NULL;
> > +		 group = reggroup_next (gdbarch, group))
> > +	      {
> > +		if (strcmp (reg->group.c_str (), reggroup_name (group)) == 0)
> 
> Here too.

OK.

> > +		  {
> > +		    group_exists = true;
> > +		    break;
> > +		  }
> > +	      }
> > +
> > +	    if (!group_exists)
> > +	      reggroup_add (gdbarch, reggroup_gdbarch_new (gdbarch,
> > +							   reg->group.c_str (),
> > +							   USER_REGGROUP));
> > +	  }
> 
> Could you factor this out in a separate function?  It would probably be
> useful to have a general-purpose function
> 
>   reggroup *reggroup_find (struct gdbarch *gdbarch, const char *name);
> 
> Which you could then use here
> 
>   if (reggroup_find (...) == NULL)
>     {
>       // Create group
>     }

Sure good point, if I find any places I can use it I will.

Thank You,

-Stafford
