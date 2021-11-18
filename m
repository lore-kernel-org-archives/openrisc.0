From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 18 Nov 2021 22:28:03 +0000
Subject: [OpenRISC] [PATCH v2 07/13] or1k: math soft float support
In-Reply-To: <20211113031639.2402161-8-shorne@gmail.com>
References: <20211113031639.2402161-1-shorne@gmail.com>
 <20211113031639.2402161-8-shorne@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111182225310.1393807@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, 13 Nov 2021, Stafford Horne via Libc-alpha wrote:

> diff --git a/sysdeps/or1k/bits/fenv.h b/sysdeps/or1k/bits/fenv.h
> new file mode 100644
> index 0000000000..49194ad851
> --- /dev/null
> +++ b/sysdeps/or1k/bits/fenv.h
> @@ -0,0 +1,68 @@
> +/* Copyright (C) 2021 Free Software Foundation, Inc.

Missing one-line description at start of file.

The constants you're defining here seem to be specific to hard float, but 
they're defined unconditionally.  Is this because you use the same ABI for 
hard float and soft float (which is generally the case when such hard 
float constants might be defined for soft float as well - a soft float 
compilation could be using a hard float libc that supports those 
constants)?

> +/* Define bits representing exceptions in the FPCSR status word.  */
> +enum
> +  {
> +    FE_OVERFLOW =
> +#define FE_OVERFLOW	1 << 3

Macros need to be properly surrounded by parentheses so they always group 
as a single operand in any expression.

> +#define FP_EX_OVERFLOW		1 << 3
> +#define FP_EX_UNDERFLOW		1 << 4
> +#define FP_EX_INEXACT		1 << 8
> +#define FP_EX_INVALID		1 << 9
> +#define FP_EX_DIVZERO		1 << 11

Likewise in sfp-machine.h.

-- 
Joseph S. Myers
joseph@codesourcery.com
