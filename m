Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A15C43334
	for <openrisc@archiver.kernel.org>; Thu,  9 Jun 2022 11:21:26 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CDD4620E4E;
	Thu,  9 Jun 2022 13:21:25 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mail.librecores.org (Postfix) with ESMTPS id 3033A24761
 for <openrisc@lists.librecores.org>; Thu,  9 Jun 2022 13:21:24 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id p8so20816271pfh.8
 for <openrisc@lists.librecores.org>; Thu, 09 Jun 2022 04:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EcsA5Xk9qdF4JRhDkCDDD5AUfavauyZNCQMYPZiGgkU=;
 b=mlUq1rFElmA/IefTTITNX+a02y1a01Hza2TkFJHaKwspRNip8VJZ2oJ9kWSCF0IFlf
 nyF2P49c1A61kulmTGXKfHPl1UJZeHFcR28dNdVFQJy7IpL76+rAFfwRzSu4jNQPnFlm
 8Z0+XuwpRY6f6hck9MrI9ikt3LHNpeuU38Y2GLYBSBVkNK3ZF+4ZmeU51g3BcnQoUqCJ
 oZlInJLj4BZ+dSeQiJ17jY81yOtpEVjxnXBIujwJv76pK4+0ZJN1GXQn5Fow49Tyfp+x
 1PI4JqS9aGo4L50fPDJVb1NFD97LKX9Ww2bjWCRq8Mjiz9irGti466UFIoBVuBlKHy1y
 Fw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EcsA5Xk9qdF4JRhDkCDDD5AUfavauyZNCQMYPZiGgkU=;
 b=alJHf34PgsyRc2J7xm83ttAmSfPKB9dPgSMfHdy0bK7Tt7iWDDxUCEHSm9ef8VAP7N
 JoBoWAkifzsg3KN6xocEDKDMUJgRHrG8KAbVDVcc9/v0Z8RRYGTTwNPM66Z8y4nJ+W3v
 zoxsBKLp8nLQS5uMHyNY5yG3azq2Oc+cLda1CzviF56YF+RGo77iKagwBMGyYglAxGhN
 PQe0eUWJv488TJp6CfkCN2xys6Q9oCzVw9d63GDLJNwzWuPrbZq6o+O8cu7I6EwDCPBb
 K4V4GN7i02e/glla7Zn/97dK+sw3HUljgHjJ80l2LhP2QzxPXtdSJC5zvAM3jA09x/HP
 R3EQ==
X-Gm-Message-State: AOAM531AqE2Bs/JN4PGXc7VhQRZjbpNuHD1PaT7tuJ4wyuUslRT/tO4K
 k67HaGGkyOGPlDPoGKCRtr7tN/tLuNxZ4w==
X-Google-Smtp-Source: ABdhPJx3dQx5otB2AfQD2Pnuu4z68uVCX9EHTkr8iDUIIxx6Pt+ix2PoWZysO6R0bgEqotUEbaTxVw==
X-Received: by 2002:a63:3184:0:b0:3fc:5893:c866 with SMTP id
 x126-20020a633184000000b003fc5893c866mr34776237pgx.56.1654773682531; 
 Thu, 09 Jun 2022 04:21:22 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 5-20020a630105000000b003f27f91135asm17294068pgb.76.2022.06.09.04.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jun 2022 04:21:21 -0700 (PDT)
Date: Thu, 9 Jun 2022 20:21:19 +0900
From: Stafford Horne <shorne@gmail.com>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] or1k: Add support for a little-endian target variant
Message-ID: <YqHXrxh5BRTk48o7@antec>
References: <20220609060133.26409-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609060133.26409-1-samuel@sholland.org>
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: openrisc@lists.librecores.org, binutils@sourceware.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 09, 2022 at 01:01:33AM -0500, Samuel Holland wrote:
> While not officially sanctioned by the architecture spec, little-endian
> or1k processors do exist in the wild, for example the Allwinner AR100.
> Let's add native support for this, instead of hacks like using objcopy
> to byteswap ELF file contents.

Hello,

In general I have no objections to this.  If there are processors that
hare little endian it makes sense to support it.  Do you have any details
of how people built for these before? I am curious.

> diff --git a/gas/config/tc-or1k.c b/gas/config/tc-or1k.c
> index ae4e3452f48..9dc5a46f2e2 100644
> --- a/gas/config/tc-or1k.c
> +++ b/gas/config/tc-or1k.c
> @@ -58,8 +58,16 @@ const char FLT_CHARS[]            = "dD";
>  #define OR1K_SHORTOPTS "m:"
>  const char * md_shortopts = OR1K_SHORTOPTS;
>  
> +enum
> +{
> +  OPTION_LITTLE_ENDIAN = OPTION_MD_BASE,
> +  OPTION_BIG_ENDIAN
> +};
> +
>  struct option md_longopts[] =
>  {
> +  {"EB", no_argument, NULL, OPTION_BIG_ENDIAN},
> +  {"EL", no_argument, NULL, OPTION_LITTLE_ENDIAN},
>    {NULL, no_argument, NULL, 0}
>  };
>  size_t md_longopts_size = sizeof (md_longopts);
> @@ -67,14 +75,30 @@ size_t md_longopts_size = sizeof (md_longopts);
>  unsigned long or1k_machine = 0; /* default */
>  
>  int
> -md_parse_option (int c ATTRIBUTE_UNUSED, const char * arg ATTRIBUTE_UNUSED)
> +md_parse_option (int c, const char * arg ATTRIBUTE_UNUSED)
>  {
> -  return 0;
> +  switch (c)
> +    {
> +    case OPTION_BIG_ENDIAN:
> +      target_big_endian = 1;
> +      break;
> +    case OPTION_LITTLE_ENDIAN:
> +      target_big_endian = 0;
> +      break;
> +    default:
> +      return 0;
> +    }
> +
> +  return 1;
>  }
>  
>  void
> -md_show_usage (FILE * stream ATTRIBUTE_UNUSED)
> +md_show_usage (FILE * stream)
>  {
> +  fprintf (stream, _(" OR1K-specific assembler options:\n"));
> +  fprintf (stream, _("\
> +  --EB			generate code for a big endian machine\n\
> +  --EL			generate code for a little endian machine\n"));
>  }

Aboce you mention -EB, -EL, here is is --EB, --EL.

Does this setup big endian as the default?  We should specify that in the
options.  i.e. "generate code for a big endian machine, this is the default."

But I am not sure how that defaulting works now.  I will try to build this
and understand better.

-Stafford
