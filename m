From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Sat, 7 Oct 2017 12:00:55 -0400
Subject: [OpenRISC] [PATCH v5 2/6] sim: cgen: add MUL2OFSI and MUL1OFSI
 macros (needed for OR1K l.mul[u])
In-Reply-To: <20171005134912.26799-3-shorne@gmail.com>
References: <20171005134912.26799-1-shorne@gmail.com>
 <20171005134912.26799-3-shorne@gmail.com>
Message-ID: <f0353e98-f249-0f7d-ad21-954671958d84@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-10-05 09:49 AM, Stafford Horne wrote:
> From: Peter Gavin <pgavin@gmail.com>
> 
> sim/common/ChangeLog:
> 
> 2012-03-14  Peter Gavin  <pgavin@gmail.com>
> 
> 	* cgen-ops.h (MUL2OFSI): New macro, 1's complement overflow.
> 	(MUL1OFSI): New macro, 2's complement overflow.

Macro?  Aren't they functions?

> ---
>  sim/common/cgen-ops.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/sim/common/cgen-ops.h b/sim/common/cgen-ops.h
> index 97585d7943..ffbdf3fd6e 100644
> --- a/sim/common/cgen-ops.h
> +++ b/sim/common/cgen-ops.h
> @@ -631,6 +631,22 @@ SUBOFQI (QI a, QI b, BI c)
>    return res;
>  }
>  
> +SEMOPS_INLINE BI
> +MUL2OFSI (SI a, SI b)
> +{
> +  DI tmp = MULDI (EXTSIDI(a), EXTSIDI(b));

Add spaces before the parentheses.

> +  BI res = tmp < -0x80000000LL || tmp > 0x7fffffffLL;
> +  return res;
> +}
> +
> +SEMOPS_INLINE BI
> +MUL1OFSI (USI a, USI b)
> +{
> +  UDI tmp = MULDI (ZEXTSIDI(a), ZEXTSIDI(b));

Here too.

Otherwise, this patch makes sense to me.

Simon
