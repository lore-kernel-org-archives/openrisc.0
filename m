From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Thu, 31 Aug 2017 23:10:47 +0200
Subject: [OpenRISC] [PATCH v4 1/5] sim: cgen: add remainder functions
 (needed for OR1K lf.rem.[sd])
In-Reply-To: <643da7dcb7d9913a1b239f3aae0ebaebb85a00d7.1496066478.git.shorne@gmail.com>
References: <cover.1496066478.git.shorne@gmail.com>
 <643da7dcb7d9913a1b239f3aae0ebaebb85a00d7.1496066478.git.shorne@gmail.com>
Message-ID: <fefc0514a4141b314871eb50efc9abf8@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-05-29 16:47, Stafford Horne wrote:
> diff --git a/sim/common/sim-fpu.c b/sim/common/sim-fpu.c
> index 0d4d08a..1a79e71 100644
> --- a/sim/common/sim-fpu.c
> +++ b/sim/common/sim-fpu.c
> @@ -41,6 +41,7 @@ along with this program.  If not, see
> <http://www.gnu.org/licenses/>.  */
>  #include "sim-io.h"
>  #include "sim-assert.h"
> 
> +#include <math.h> /* for drem, remove when soft-float version is 
> implemented */
> 
>  /* Debugging support.
>     If digits is -1, then print all digits.  */
> @@ -1551,6 +1552,68 @@ sim_fpu_div (sim_fpu *f,
> 
> 
>  INLINE_SIM_FPU (int)
> +sim_fpu_rem (sim_fpu *f,
> +	     const sim_fpu *l,
> +	     const sim_fpu *r)
> +{
> +  if (sim_fpu_is_snan (l))
> +    {
> +      *f = *l;
> +      f->class = sim_fpu_class_qnan;
> +      return sim_fpu_status_invalid_snan;
> +    }
> +  if (sim_fpu_is_snan (r))
> +    {
> +      *f = *r;
> +      f->class = sim_fpu_class_qnan;
> +      return sim_fpu_status_invalid_snan;
> +    }
> +  if (sim_fpu_is_qnan (l))
> +    {
> +      *f = *l;
> +      f->class = sim_fpu_class_qnan;
> +      return 0;
> +    }
> +  if (sim_fpu_is_qnan (r))
> +    {
> +      *f = *r;
> +      f->class = sim_fpu_class_qnan;
> +      return 0;
> +    }
> +  if (sim_fpu_is_infinity (l))
> +    {
> +      *f = sim_fpu_qnan;
> +      return sim_fpu_status_invalid_irx;
> +    }
> +  if (sim_fpu_is_zero (r))
> +    {
> +      *f = sim_fpu_qnan;
> +      return sim_fpu_status_invalid_div0;
> +    }
> +  if (sim_fpu_is_zero (l))
> +    {
> +      *f = *l;
> +      return 0;
> +    }
> +  if (sim_fpu_is_infinity (r))
> +    {
> +      *f = *l;
> +      return 0;
> +    }
> +  {
> +    /* TODO: Implement remainder here.  */
> +
> +    sim_fpu_map lval, rval, fval;
> +    lval.i = pack_fpu(l, 1);
> +    rval.i = pack_fpu(r, 1);
> +    fval.d = remainder(lval.d, rval.d);
> +    unpack_fpu(f, fval.i, 1);
> +    return 0;
> +  }

I can't tell for sure because I'm not maintainer of sim/, but I suppose 
that we would need a proper implementation that doesn't use the host fpu 
here.

> +}
> +
> +
> +INLINE_SIM_FPU (int)
>  sim_fpu_max (sim_fpu *f,
>  	     const sim_fpu *l,
>  	     const sim_fpu *r)
> diff --git a/sim/common/sim-fpu.h b/sim/common/sim-fpu.h
> index d27d80a..c108f1f 100644
> --- a/sim/common/sim-fpu.h
> +++ b/sim/common/sim-fpu.h
> @@ -151,6 +151,7 @@ typedef enum
>    sim_fpu_status_overflow = 4096,
>    sim_fpu_status_underflow = 8192,
>    sim_fpu_status_denorm = 16384,
> +  sim_fpu_status_invalid_irx = 32768, /* (inf % X) */
>  } sim_fpu_status;

I think it would make sense to put the new entry with the other 
"invalid" ones and shift the others.

Simon
