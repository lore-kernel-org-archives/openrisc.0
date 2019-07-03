From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 3 Jul 2019 10:43:01 -0500
Subject: [OpenRISC] [PATCH v2 4/5] or1k: Initial support for FPU
In-Reply-To: <20190703033351.11924-5-shorne@gmail.com>
References: <20190703033351.11924-1-shorne@gmail.com>
 <20190703033351.11924-5-shorne@gmail.com>
Message-ID: <20190703154301.GY18316@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Wed, Jul 03, 2019 at 12:33:50PM +0900, Stafford Horne wrote:
> +    case 'd':
> +      if (REG_P (x))
> +	  if (GET_MODE (x) == DFmode || GET_MODE (x) == DImode)
> +	    fprintf (file, "%s,%s", reg_names[REGNO (operand)],
> +				    reg_names[REGNO (operand) + 1]);
> +	  else
> +	    fprintf (file, "%s", reg_names[REGNO (operand)]);
> +      else

The coding conventions says to use braces around nested conditionals.

> @@ -212,6 +214,7 @@ enum reg_class
>  #define REG_CLASS_CONTENTS      \
>  { { 0x00000000, 0x00000000 },	\
>    { SIBCALL_REGS_MASK,   0 },	\
> +  { 0x7ffffefe, 0x00000000 },	\

Above you said r0, r30, r31 are excluded, but this is r0, r8, r30, or
in GCC register numbers, 0, 8, and 31?  You probably should mention r8
somewhere (it's because it is the last arg, this avoid problems, I guess?),
and the 30/31 thing is confused some way.  Maybe it is all just that one
documentation line :-)

> +;  d - double pair base registers (excludes r0, r30 and r31 which overflow)


Segher
