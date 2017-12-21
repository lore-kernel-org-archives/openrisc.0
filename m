From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Wed, 20 Dec 2017 22:15:31 -0500
Subject: [OpenRISC] [PATCH v3 3/4] reggroups: Create
 reggroup_gdbarch_new for dynamic reggroups
In-Reply-To: <20171219142257.13402-4-shorne@gmail.com>
References: <20171219142257.13402-1-shorne@gmail.com>
 <20171219142257.13402-4-shorne@gmail.com>
Message-ID: <31e43543479eecd36327738c8682ce37@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-12-19 09:22, Stafford Horne wrote:
> Traditionally reggroups have been created via reggroup_new() during
> initialization code and never freed.  Now, if we want to initialize
> reggroups dynamically (i.e. in target description) we should be able to
> free them.  Create this function reggroup_gdbarch_new() which will
> allocate the reggroup memory onto the passed gdbarch obstack.
> 
> gdb/ChangeLog:
> 
> 2017-06-10  Stafford Horne  <shorne@gmail.com>
> 
> 	* reggroups.c (reggroup_gdbarch_new): New function.
> 	* reggroups.h (reggroup_gdbarch_new): New function.
> ---
>  gdb/reggroups.c | 12 ++++++++++++
>  gdb/reggroups.h |  4 ++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/gdb/reggroups.c b/gdb/reggroups.c
> index 5d5e33f2a3..acad91a0ab 100644
> --- a/gdb/reggroups.c
> +++ b/gdb/reggroups.c
> @@ -46,6 +46,18 @@ reggroup_new (const char *name, enum reggroup_type 
> type)
>    return group;
>  }
> 
> +struct reggroup *
> +reggroup_gdbarch_new (struct gdbarch *gdbarch, const char *name,
> +		      enum reggroup_type type)
> +{
> +  struct reggroup *group = GDBARCH_OBSTACK_ZALLOC (gdbarch,
> +						   struct reggroup);
> +
> +  group->name = gdbarch_obstack_strdup (gdbarch, name);
> +  group->type = type;
> +  return group;
> +}
> +
>  /* Register group attributes.  */
> 
>  const char *
> diff --git a/gdb/reggroups.h b/gdb/reggroups.h
> index 18fc1bf294..c1653cd39d 100644
> --- a/gdb/reggroups.h
> +++ b/gdb/reggroups.h
> @@ -41,6 +41,10 @@ extern struct reggroup *const restore_reggroup;
>  /* Create a new local register group.  */
>  extern struct reggroup *reggroup_new (const char *name,
>  				      enum reggroup_type type);
> +/* Create a new register group allocated onto the gdbarch obstack.  */
> +extern struct reggroup *reggroup_gdbarch_new (struct gdbarch *gdbarch,
> +					      const char *name,
> +					      enum reggroup_type type);
> 
>  /* Add a register group (with attribute values) to the pre-defined 
> list.  */
>  extern void reggroup_add (struct gdbarch *gdbarch, struct reggroup 
> *group);

LGTM.
