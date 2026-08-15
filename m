Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFDF3630BA
	for <linux-openrisc@vger.kernel.org>; Sat, 15 Aug 2026 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786774589; cv=none; b=t0Ey58LNJwtMgwETM0qNldSZrHG1BZ2cDRdZDgUW/Jqz0bas+XZTJ6O5xBsWO92EYEi4IoNTF93ebEYEGVAJ89Y/SENPAPtQNbDo/O73dk9Y6GdmjEOUnDXfBiHwjD5naYWQi98k9OkkrD+ecusODaCJ/ha0PsGu3xsVntadg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786774589; c=relaxed/simple;
	bh=BGHkJWTyQmv0GnaSQsR6y+wwA2JB5brkk5DYlmBy+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1UWP7tz3VcsOj6QMu9zfQq1uI7ATpcmQ/DAP9ZYmwZJZQeWRyyu0bwt0h1PhGPhg+KWsCFG/xErkAmXr1n0uZ2eesoYItWaHRUWsZb2a0MP68fkJ24uzSm9MolSaMM0ShP6jAnDtKoTGQv3XK+0F+vck0XcpGbzTlvbVK+blr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPyjVRwd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPyjVRwd"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fd66a094eso664654f8f.3
        for <linux-openrisc@vger.kernel.org>; Fri, 14 Aug 2026 23:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786774584; x=1787379384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HMbsrn4gJN/XmhuApQca7zXrmJcqKKIj95PmT0TacoM=;
        b=aPyjVRwdWlH1Cv/VQMAr7RZMp6ZXwruI+C2WHMbfWf7rQ9WBNexeD5YbetbWNWSFiU
         pKISB8LmRB9Y8UyuHBloYmmBg5Y6Ho1CJ/noFZf4kWctjH24UqQAiOz+rs1nScolyDDS
         zo0OPXw1gAWYZ3ZznpcGN5UQASumIJgZFfP6hmg0GtulztbiBZJtYij0NbyKop5b2N0l
         Z3M66zOj/B8VZhbgF7xOYkchcceS0d8SzKVgB9T6v35nUZ/JnYO8EnfPftm/vsSKgRhP
         9LTEpC0qH04xQxWpl87TExNqskGbHq0QX3ccH1m0VqwLUyC22Eu3arvZ2gnmmPd+X7k9
         SvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786774584; x=1787379384;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMbsrn4gJN/XmhuApQca7zXrmJcqKKIj95PmT0TacoM=;
        b=UR8JX/GdtHq3d8N1QaIz8dXQAnQy0Ut5Bo3NKCG/dGzbXbZbazlAiVCoHR79HxZNrA
         I4sWf8X+yPqnSdBFcedQJyO/VnqbUcDRHxCu7B8K2RXxOZZ0awg0DJjHvQ6ra1Lvvtu3
         OexD/RbcH9aLTfJCDQdmd9No36loN98PjVnjPQXxl/l776KviT6j6iiODLV4ENA/VHkn
         MphVvagTy3kINzt9GJloIxzVnfy7xa8aeQB2J+Aqvb5WXZVjkCLsQB5Ma7BnyQFCaeXV
         VafwXPj2J1rWKvpoY2rnEF9qpY55+BcvMHQqkNH29TZjyrWKi9wYAc+2um2w7ZY1Z/A3
         A+ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RponuxaMneSmarN3QUU3ZUuy8sQxNDdXJ8jY6lTdW9q/iV2ycFnI6YSJXNIHVXuaz88cm03GHVd1fCnL6TiWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7+lzXUtKEF+i9saQFyriYE/mcDqHOzjhsW9uAYIVOLOX4D4Z
	CSO7PfWhP60EVy8UsonNFafS57YIWttP/5XomJYyxip+F3bbuYidUs9m
X-Gm-Gg: AR+sD13PefP0sWH/90N/oFGi/0Ksqql7qRhEplvyvn5qCLi7yTnfHvgxub+0orJfh67
	fGhdTiJYhlQLjqgLeCPNiOuk8UxtbLy/cyl4r6KsEReB1Bs6oatOnYgk7wDOUdvp910zCeDvJFF
	/WJQDG/6d0jYmDgjxGnjWg1cPBz2uKTTtVj9pjJ9QfVvvhHICn0rgg69iDDUo1fj+y522xEOc4T
	2ZGJnfte+9BZOgMifJGAyv55KYxiHb5KF3RFPZrxZM3BgmFbmLTOda+PxCNDk6TidoWjaKU3Ohc
	f0OArHw/ykIdz40bJyyO6wbUT9fKWx/MrHz3H5u/YvTvS5aPxqWQn3Uf6T3WYcyk5lEbaLTaIyO
	S1r/IobMnbW4VI32wHy37HbCbKjVR2jixK3NCbkpJ6F/TbfZqaITKpiuXKmVD1v9vLJ6S6t2JyN
	XV4YnpsTbB108E4LxRUrB1AtWS73SPgGRIaUAlSIc5Xf+32/xZvh1sSM9cU6xOC8WLEdz3Cz2Nr
	qDT/qpm1mQxxGhdRgKK9vN4uBAZwkhpkY9n1BJdu4Y=
X-Received: by 2002:a05:6000:491e:b0:47f:9404:5185 with SMTP id ffacd0b85a97d-4816078827emr16850466f8f.24.1786774583939;
        Fri, 14 Aug 2026 23:16:23 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2ccc00sm13646333f8f.35.2026.08.14.23.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:16:22 -0700 (PDT)
Date: Sat, 15 Aug 2026 07:16:21 +0100
From: Stafford Horne <shorne@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Jonas Bonn <jonas@southpole.se>, kernel-janitors@vger.kernel.org,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: drop unneeded semicolon
Message-ID: <aoAENVPTu7xW8LL5@antec>
References: <20260801191002.1383835-4-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801191002.1383835-4-Julia.Lawall@inria.fr>

On Sat, Aug 01, 2026 at 09:09:50PM +0200, Julia Lawall wrote:
> When a function-like macro expands to an expression, that expression
> doesn't need a semicolon after it.  All uses have been verified to
> have their own semicolons.
> 
> This was found using the following Coccinelle semantic patch:
> 
> @r@
> identifier i : script:ocaml() { String.lowercase_ascii i = i };
> expression e;
> @@
> 
> *#define i(...) e;
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Thank you, this looks fine to me.  I have queued it, sorry for delay I have been
away.

> ---
>  arch/openrisc/mm/tlb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
> index 3115f2e4f..2ee00bf30 100644
> --- a/arch/openrisc/mm/tlb.c
> +++ b/arch/openrisc/mm/tlb.c
> @@ -74,11 +74,11 @@ void local_flush_tlb_all(void)
>  
>  #define flush_dtlb_page_eir(addr) mtspr(SPR_DTLBEIR, addr)
>  #define flush_dtlb_page_no_eir(addr) \
> -	mtspr_off(SPR_DTLBMR_BASE(0), DTLB_OFFSET(addr), 0);
> +	mtspr_off(SPR_DTLBMR_BASE(0), DTLB_OFFSET(addr), 0)
>  
>  #define flush_itlb_page_eir(addr) mtspr(SPR_ITLBEIR, addr)
>  #define flush_itlb_page_no_eir(addr) \
> -	mtspr_off(SPR_ITLBMR_BASE(0), ITLB_OFFSET(addr), 0);
> +	mtspr_off(SPR_ITLBMR_BASE(0), ITLB_OFFSET(addr), 0)
>  
>  void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> 
