From: Andrew Burgess <andrew.burgess@embecosm.com>
Date: Sat, 13 Apr 2019 22:59:37 +0100
Subject: [OpenRISC] [PATCH v2 4/6] sim/common: Wire in df/di conversion
In-Reply-To: <20190409213925.32699-5-shorne@gmail.com>
References: <20190409213925.32699-1-shorne@gmail.com>
 <20190409213925.32699-5-shorne@gmail.com>
Message-ID: <20190413215937.GK2737@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

* Stafford Horne <shorne@gmail.com> [2019-04-10 06:39:23 +0900]:

> Up until now these have not been used in any CGEN targets, add them as
> they are now used by OpenRISC.
> 
> sim/common/ChangeLog:
> 
> 	* cgen-accfp.c (floatdidf, fixdfdi): New functions.
> 	(cgen_init_accurate_fpu): Add floatdidf and fixdfdi.

This is fine.

thanks,
Andrew



> ---
>  sim/common/cgen-accfp.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/sim/common/cgen-accfp.c b/sim/common/cgen-accfp.c
> index 5d600c6e41..51f5a29fe2 100644
> --- a/sim/common/cgen-accfp.c
> +++ b/sim/common/cgen-accfp.c
> @@ -349,6 +349,17 @@ floatsidf (CGEN_FPU* fpu, int how UNUSED, SI x)
>    return res;
>  }
>  
> +static DF
> +floatdidf (CGEN_FPU* fpu, int how UNUSED, DI x)
> +{
> +  sim_fpu ans;
> +  unsigned64 res;
> +
> +  sim_fpu_i64to (&ans, x, sim_fpu_round_near);
> +  sim_fpu_to64 (&res, &ans);
> +  return res;
> +}
> +
>  static SF
>  ufloatsisf (CGEN_FPU* fpu, int how UNUSED, USI x)
>  {
> @@ -382,6 +393,17 @@ fixdfsi (CGEN_FPU* fpu, int how UNUSED, DF x)
>    return res;
>  }
>  
> +static DI
> +fixdfdi (CGEN_FPU* fpu, int how UNUSED, DF x)
> +{
> +  sim_fpu op1;
> +  unsigned64 res;
> +
> +  sim_fpu_64to (&op1, x);
> +  sim_fpu_to64i (&res, &op1, sim_fpu_round_near);
> +  return res;
> +}
> +
>  static USI
>  ufixsfsi (CGEN_FPU* fpu, int how UNUSED, SF x)
>  {
> @@ -739,8 +761,10 @@ cgen_init_accurate_fpu (SIM_CPU* cpu, CGEN_FPU* fpu, CGEN_FPU_ERROR_FN* error)
>    o->ftruncdfsf = ftruncdfsf;
>    o->floatsisf = floatsisf;
>    o->floatsidf = floatsidf;
> +  o->floatdidf = floatdidf;
>    o->ufloatsisf = ufloatsisf;
>    o->fixsfsi = fixsfsi;
>    o->fixdfsi = fixdfsi;
> +  o->fixdfdi = fixdfdi;
>    o->ufixsfsi = ufixsfsi;
>  }
> -- 
> 2.19.1
> 
