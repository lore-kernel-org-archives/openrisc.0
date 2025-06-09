Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1B21CFF6
	for <linux-openrisc@vger.kernel.org>; Mon,  9 Jun 2025 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495705; cv=none; b=b5fOn+5sisIMYdQhF3g3Y8sAUy1yBQq704/L+ZOCk5ySKnyfXpngeMgxHQHeXq3YVSKt+u6BmIllmZIHOcJMB5oIhfXkHrWsNs1ODNpmUy46PRwdVzDsnEdVWV/GVEVQ4ev9D8B7EiT+THm4whM4M3taPE+WuNYczaGlkQA6KR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495705; c=relaxed/simple;
	bh=zaxotfBbqfaFMAiFXgKgY8m/IMBaarq2XIbDBTj5mu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlvNvwLdfWUn9BggxH0dQPUp0qb2TVnJ/bTQfgZiS6pvGS8W54N3yRgiYPWcS0wjisHaqHVTp5vHczIq7+NsK0k2rmgVj/ogzpw/qnmFH6SI9juRXNQhh/384R+8OFRLSsnza3FD0uZbq38kOMvjhverrWp76u8Fq19K791wYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSRsDHmC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSRsDHmC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso29356665e9.1
        for <linux-openrisc@vger.kernel.org>; Mon, 09 Jun 2025 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749495702; x=1750100502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kal0tqtJoTHL6TMTnaxvgVpZbXWBlKgStEWUvOYPQ2o=;
        b=FSRsDHmCQqNFbD4DJGizhfRYrFEcSu76XRLOCeg5m2kLa035dbU+ZImiE++BhiIEjD
         57nCFIyPzmNd5uarowPXhK5lPBezZ+uQKYdF6inWh2qFYLTXMthhKbPaU26fgu82rwhW
         Z6DnUnvb+n1M5Ui6bfNX9/K2y7rTWAX7v6tzHdfNPQPozDE0l+8UwGLrfMgk9SoTCqdb
         x5Omy+TbVbtHqFUBEG8SsKFJpmVGp8yRYWlmxYqGB+zJqyMyuXbaiQBBKcXMJqBHu+FY
         c6sR5yu1WYdohAk7UJUrgRvwzf7/lqhtw+ds23sOf6metyxMetcUpXjBELACXIjARArp
         31hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749495702; x=1750100502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kal0tqtJoTHL6TMTnaxvgVpZbXWBlKgStEWUvOYPQ2o=;
        b=VXed7lILKjdlh7iK6xKdzo5nbeMkXgISVONK5F2+SP7V548+SQRUGe0bG3Eg+f9qW5
         vcrrY6z0b4m58kdXjfkIQwnxrvLwYa/7N6qd+pUId76NMrLxaOa8VQJo3exTqzR76g9Q
         OnSYnzH8k9W5hJ4I7FbjaTkk8O6xSW9LGUA7OpL+oxQBwlrOqsMf7ESIuc/Sg4fvMKD1
         idgvR+OGoJKc6VsMA77Axj3EAJiGZldee6qQtjYFQuDh6wvYACi5ktClHkXzcLf7+z7c
         8zGf2sTgG1szTCmwzfW8AfEyWYZZJmmHIVu1Zk6VMGu+GBlafEmGbufgPU612up4HM+K
         zCXA==
X-Forwarded-Encrypted: i=1; AJvYcCUTx75bN3UsBmNEHInBXgFFhSEBHtZpdChgiVWLs5X2UYpkF6uyM+u8UfqY5X8JRUAYuC+MOK94Wi8n9x5O+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyY/6J4PvdRQLTQs/mPaJgJxZUC2kgKvpvWH4V7dt2/BwsmGHF
	CqQfBtGtoTbEBdcYTMRek3i3okhp1g/iAehOcLNzMq7QcYLVsoSwdmTpMZCLcA==
X-Gm-Gg: ASbGncsigb0+EGr9h5XO1xVDaocyCOmMUiEwGxv3NVx2NNtC5LYTkqCHtIiNnmkSjgU
	wkv+euFy7RB4/Gil5P/OyJqBgmCjTFsRDs1PH8VuPKltIdbCAcaqV5bjniixVyMqzZzWZZbRe69
	DuYJbA9blPn7NXisIEm3f+bpaqsaFs1E/plwt/4VVEFBNhE4U3fB0tg3LJQG6DHjahGVpdKCx8o
	DMkJAzEm4R7ZynudDFnZTO8A8BOCeGIliC+pE9/fXm1O58/q0IFIUF/MOOCO/PhxBsvkaEvyfRD
	UDDwcl6qmt7VHyNDnETc46YFfJtxecMTV2QjgfdD1dNzoMMY7ZchqXMF2cz8lCWmWHqOA4JCTZD
	i45QUU/RtTedMvnxdiXEcsDYERQ==
X-Google-Smtp-Source: AGHT+IGLf/Z21oZs1kp3KrGMkYgdjxCQ+g3y0BzeIs0vb9Ox4pYdnBeu0cwNMezGTqf3UehyQcwXNQ==
X-Received: by 2002:a05:600c:8b70:b0:442:d9f2:c6ef with SMTP id 5b1f17b1804b1-452013fd8ddmr142139265e9.2.1749495701659;
        Mon, 09 Jun 2025 12:01:41 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213709611sm120899305e9.24.2025.06.09.12.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 12:01:40 -0700 (PDT)
Date: Mon, 9 Jun 2025 20:01:38 +0100
From: Stafford Horne <shorne@gmail.com>
To: Simon Marchi <simark@simark.ca>
Cc: GDB patches <gdb-patches@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] or1k: Fix ICE in libgcc caused by recent validate_subreg
 changes
Message-ID: <aEcvktufxzjdr95I@antec>
References: <20250609185222.1538148-1-shorne@gmail.com>
 <ed2035f9-d5ea-4090-9d43-d6be9d40f901@simark.ca>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed2035f9-d5ea-4090-9d43-d6be9d40f901@simark.ca>

On Mon, Jun 09, 2025 at 02:57:46PM -0400, Simon Marchi wrote:
> On 6/9/25 2:52 PM, Stafford Horne wrote:
> > After commit eb2ea476db2 ("emit-rtl: Allow extra checks for
> > paradoxical subregs [PR119966]") paradoxical subregs or the OpenRISC
> > condition flag register (reg:BI sr_f) are no longer allowed.
> > 
> > This causes and ICE in the ce1 pass which tries to get the or1k flag
> > register into an SI register, which is no longer possible.
> > 
> > Adjust or1k_can_change_mode_class to allow changing the or1k flag reg to
> > SI mode which in turn allows paradoxical subregs to bre generated again.
> > 
> > gcc/ChangeLog:
> > 
> > 	PR or1k/120587
> > 	* config/or1k/or1k.cc (or1k_can_change_mode_class): Allow
> > 	changing flags mode from BI to SI to allow for paradoxical
> > 	subregs.
> 
> Wrong mailing list I think (gcc, not gdb).

Yes sorry, I have tab completion and gdb-patches looked like gcc-patches to me.

I have resent to the correct list.

-Stafford
