Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04A231858
	for <linux-openrisc@vger.kernel.org>; Thu, 19 Jun 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347637; cv=none; b=dYpRAZdyhnnBpU9xLapNqffaSRufEY7VvpOJ+tOD/XL7r7E6jRmCkTr7mMUZwWEfpXzLmTyEHVFbdKc3bL/SsleHaqDQ5dQMJSgSs1j+G0qY+M92ALLDOjmWkUSfmN/Ab0kj+q14J7HErgXT48SWOXcLc9vhgIYbo5vFXQnhcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347637; c=relaxed/simple;
	bh=uncMZthE7/Y1mkam3i4tuXNFmGQ3PFccIIbLf59gZVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV03C/65PwZZ34JVeSjwVFFI5s0JgvE89H7gHwaOoXe6pT+tB68qyECX8E4EVfl+xf0ux6om62rwuGhsNeMwrqGolKwL3daKf2a0904GuLhbPqCxOMW3dV88XuvIs5rxF+JC1sZr1GGWmG5HxMbdPDJh7yAHJ6y1qsmvYxmibmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxzti/bW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxzti/bW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so6797865e9.0
        for <linux-openrisc@vger.kernel.org>; Thu, 19 Jun 2025 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750347633; x=1750952433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMd9cwCrBZT1hAebuQD0KN2bw8pJ/j+iSXqIr3keu5A=;
        b=gxzti/bWns8uUadp/86l5rVMdc8XJkPf2GfZSOx5cRpsohUphteZw72OA3f5UXvKGI
         mX42DJGawkuxDShbRKxHPmRixGfwn6akSI64rfGx94SsvuDJN+W8Jua+GUNv/wEafZsC
         fwxr5mQ6jOZpBpJC+hCmPLOHzbL+QVNmxsQ38rbmmudFYP37q2mUF2IN5Le1rc0MzsoQ
         7N4ommkmXctbemtwfmicnRPsbAKDtHJc4ytwdgCU8OimhIk9XMH9uifnhKV0g2BsfJkw
         MTYoEsyfYAqkAF/4gq4dUy3wsy47AGRDlrw0O727XC6q9B13OOC8gfSJoon20FQZ+QjJ
         9Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750347633; x=1750952433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMd9cwCrBZT1hAebuQD0KN2bw8pJ/j+iSXqIr3keu5A=;
        b=gWv1lS0qb4cRsHUuMwJ0HIloJ4a4YpPYcOCbJd0d/2E6gQsfL1PCOeVTgVtc5F9R3T
         vIkQitK9O1VHZM7n4mqNeKRe8qypVnIjh+Q6xgScs9WdRELguXxzcZXcjS8G3FhdBmQO
         DFyl/YQFomV7GV3pPF3+8zJjnF4m6ueTZBRFLxCOtX8aMAGUOhS/FgELNTM2G3TS6Vmz
         wd1UlGGm3G8eiA9DfWFvDxR32YsIL+m3ryAs6ZDqjAu7ImKWu4cycySnfRa9Ay0EQtIE
         TRk4t2yMHxyBiZoIP/bCsIi+fjMVS+EkGJrMl7XbkHLnGvmkOKr/rnHEsVy2r/rZsPge
         qUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEbI8hivTLaGzLX5ncKLsbvn4xoiid0DDevoX8kEYbxVsfsLHcCzlPBgrVLwqguUWRTbEAWCaVRZVU4dUJ+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YybH2dfc1lKT0mb5zfJh6v3S0MKOwwKmzIKpWVpgZ0aIynlofLA
	qIYVgE9PPvMr3HBEk95nWUCyT769O6WAviLif+wzCXc3sFLMBkEmShPw
X-Gm-Gg: ASbGncseGCNU4wdMrzzwcN5fwCUOmUp84qVBoTwE/yoFHremdl8FwhcAYtDacsNIDZl
	Y3s5sEQ5pzl/PPhwrKOZXn5t6hVKIxwaYBsh/zl9AghOCoDUG1PMvklpfZSRzpWBEg8qpCvs/jV
	H9+5kAxVIssuxp/8aHRSyILIURBiwPbK9EjjG4qSTfCiaI0VC7va3+5NFZHaydzt0VrwQNEwp1c
	AsuQ0M4i8pa3lsSpGXFkma0ALSyDCHU08SxYcdYXkPea7zlmbCAjDanGyvAY67+QEA+6+1Qh2xB
	BUUfRbR5q3J5h8yT4b8ePyvtmLoYQq8W9DynLwFyoeL69Wzjr0aD44sHP1muAFDY9lH/gjHsv0N
	pbFtOr/YnoQmN2mlyhLecxbPwiQ==
X-Google-Smtp-Source: AGHT+IGrxt7Ejgl+qlb6/2bT1nTmYi+bMCJSJdVNYP1OgxKLGZK0xyBHLleNg6DCB8l42hqrXPYTZA==
X-Received: by 2002:a05:600c:37c4:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-4533d5a03a9mr243174685e9.15.1750347633067;
        Thu, 19 Jun 2025 08:40:33 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e99cb61sm32342285e9.33.2025.06.19.08.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:40:28 -0700 (PDT)
Date: Thu, 19 Jun 2025 16:40:28 +0100
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Dimitar Dimitrov <dimitar@dinux.eu>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 2/2] or1k: Improve If-Conversion by delaying cbranch
 splits
Message-ID: <aFQvbEkfUzsJnKq6@antec>
References: <20250619131426.1292212-1-shorne@gmail.com>
 <20250619131426.1292212-3-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619131426.1292212-3-shorne@gmail.com>

On Thu, Jun 19, 2025 at 02:14:26PM +0100, Stafford Horne wrote:
> When working on PR120587 I found that the ce1 pass was not able to
> properly optimize branches on OpenRISC.  This is because of the early
> splitting of "compare" and "branch" instructions during the expand pass.
> 
> Convert the cbranch* instructions from define_expand to
> define_insn_and_split.  This dalays the instruction split until after
> the ce1 pass is done giving ce1 the best opportunity to perform the
> optimizations on the original form of cbranch<mode>4 instructions.
> 
> gcc/ChangeLog:
> 
> 	* config/or1k/or1k.cc (or1k_noce_conversion_profitable_p): New
> 	function.
> 	(or1k_is_cmov_insn): New function.
> 	(TARGET_NOCE_CONVERSION_PROFITABLE_P): Define macro.
> 	* config/or1k/or1k.md (cbranchsi4): Convert to insn_and_split.
> 	(cbranch<mode>4): Convert to insn_and_split.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  gcc/config/or1k/or1k.cc | 54 +++++++++++++++++++++++++++++++++++++++++
>  gcc/config/or1k/or1k.md | 32 ++++++++++++++++++++++--
>  2 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/gcc/config/or1k/or1k.cc b/gcc/config/or1k/or1k.cc
> index f1c92c6bf6c..36c16a51d44 100644
> --- a/gcc/config/or1k/or1k.cc
> +++ b/gcc/config/or1k/or1k.cc
> @@ -1654,6 +1654,60 @@ or1k_rtx_costs (rtx x, machine_mode mode, int outer_code, int /* opno */,
>  #undef TARGET_RTX_COSTS
>  #define TARGET_RTX_COSTS or1k_rtx_costs
>  
> +static bool
> +or1k_is_cmov_insn (rtx_insn *seq)
> +{
> +  rtx_insn *curr_insn = seq;
> +  rtx set = NULL_RTX;
> +
> +  /* The pattern may start with a simple set with register operands.  Skip
> +     through any of those.  */
> +  while (curr_insn)
> +    {
> +      set = single_set (curr_insn);
> +      if (!set
> +	  || !REG_P (SET_DEST (set)))
> +	return false;
> +
> +      /* If it's not a simple reg or immediate break.  */
> +      if (REG_P (SET_SRC (set)) || CONST_INT_P (SET_SRC (set)))
> +        curr_insn = NEXT_INSN (curr_insn);
> +      else
> +	break;

Indentation issue.

> +    }
> +
> +  /* The next instruction should be a compare.  OpenRISC has many operators used
> +     for comparison so skip and confirm the next is IF_THEN_ELSE.  */
> +  curr_insn = NEXT_INSN (curr_insn);

Need to check curr_insn before calling NEXT_INSN () to avoid failures.

> +  if (!curr_insn)
> +    return false;
> +
> +  /* And the last instruction should be an IF_THEN_ELSE.  */
> +  set = single_set (curr_insn);
> +  if (!set
> +      || !REG_P (SET_DEST (set))
> +      || GET_CODE (SET_SRC (set)) != IF_THEN_ELSE)
> +    return false;
> +
> +  return !NEXT_INSN (curr_insn);
> +}
> +
> +/* Implement TARGET_NOCE_CONVERSION_PROFITABLE_P.  We detect if the conversion
> +   resulted in a l.cmov instruction and if so we consider it more profitable than
> +   branch instructions.  */
> +
> +static bool
> +or1k_noce_conversion_profitable_p (rtx_insn *seq,
> +				    struct noce_if_info *if_info)
> +{
> +  if (TARGET_CMOV)
> +    return or1k_is_cmov_insn (seq);
> +
> +  return default_noce_conversion_profitable_p (seq, if_info);
> +}
> +
> +#undef TARGET_NOCE_CONVERSION_PROFITABLE_P
> +#define TARGET_NOCE_CONVERSION_PROFITABLE_P or1k_noce_conversion_profitable_p
>  
>  /* A subroutine of the atomic operation splitters.  Jump to LABEL if
>     COND is true.  Mark the jump as unlikely to be taken.  */
> diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
> index a30cc18892d..bf7125375ac 100644
> --- a/gcc/config/or1k/or1k.md
> +++ b/gcc/config/or1k/or1k.md
> @@ -609,7 +609,7 @@
>  ;; Branch instructions
>  ;; -------------------------------------------------------------------------
>  
> -(define_expand "cbranchsi4"
> +(define_insn_and_split "cbranchsi4"
>    [(set (pc)
>  	(if_then_else
>  	  (match_operator 0 "comparison_operator"
> @@ -618,13 +618,27 @@
>  	  (label_ref (match_operand 3 "" ""))
>  	  (pc)))]
>    ""
> +  "#"
> +  "&& 1"
> +  [(const_int 0)]
>  {
> +  rtx label;
> +
> +  /* Generate *scc */
>    or1k_expand_compare (operands);
> +  /* Generate *cbranch */
> +  label = gen_rtx_LABEL_REF (VOIDmode, operands[3]);
> +  emit_jump_insn (gen_rtx_SET (pc_rtx,
> +			       gen_rtx_IF_THEN_ELSE (VOIDmode,
> +						     operands[0],
> +						     label,
> +						     pc_rtx)));
> +  DONE;
>  })
>  
>  ;; Support FP branching
>  
> -(define_expand "cbranch<F:mode>4"
> +(define_insn_and_split "cbranch<F:mode>4"
>    [(set (pc)
>  	(if_then_else
>  	  (match_operator 0 "fp_comparison_operator"
> @@ -633,8 +647,22 @@
>  	  (label_ref (match_operand 3 "" ""))
>  	  (pc)))]
>    "TARGET_HARD_FLOAT"
> +  "#"
> +  "&& 1"
> +  [(const_int 0)]
>  {
> +  rtx label;
> +
> +  /* Generate *scc */
>    or1k_expand_compare (operands);
> +  /* Generate *cbranch */
> +  label = gen_rtx_LABEL_REF (VOIDmode, operands[3]);
> +  emit_jump_insn (gen_rtx_SET (pc_rtx,
> +			       gen_rtx_IF_THEN_ELSE (VOIDmode,
> +						     operands[0],
> +						     label,
> +						     pc_rtx)));
> +  DONE;
>  })
>  
>  (define_insn "*cbranch"
> -- 
> 2.49.0
> 
