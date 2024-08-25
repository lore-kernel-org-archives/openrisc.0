Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB313C092
	for <linux-openrisc@vger.kernel.org>; Sun, 25 Aug 2024 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724564979; cv=none; b=npyhHU12jYqQHWImeVoSG2WcX9NaDmsrEgx9PN9+5mqFauEKSjF0dTZrv6XO0hAdi+GDsy86nVyhzCLoaFZtcn9qz7w9rMAhqpiJ9WZo6Pc80C7jGHluztA7uIoTRHjnekiR/hdGJwWN+IBroUuNUsC180ynpnkiJTHGdiyvk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724564979; c=relaxed/simple;
	bh=hc1vOQdA50XtbGVbe+2eS47DwOJzN9qPB8z983L1XFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ9R02oP1q4Ztm+P4zSmRg3fuGyOn6TVvSvhhMD2Y8Yom0zOzh1TjiZ17zgSLcZvYOxhPCaqBzNWE05WKlw8w+8M3Jnb62XqRFPXNx9lSjygmcCaEOWHmOSHi0V35RMH6WLLqqKV6DLYsfSd2N1ilbpPKZgNNCkXmMHdKU9rL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2J41str; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2J41str"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso8946866b.2
        for <linux-openrisc@vger.kernel.org>; Sat, 24 Aug 2024 22:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724564976; x=1725169776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+AXx1NranKnHe5gs6W+YUiWGU8zH6Rw9JCptNatzLE=;
        b=G2J41struuZMqACsZyfIPHkVseTzNE2e01vyDYDhOaR8zygIGi5lZMq6PUhxYMwZU2
         u6Fe4bwrDuTBOXQ6/c1gt5KVfVHIKxRn/of6SmITpH2sQcfIUwR6+xUDptgYQMzUSBRx
         Iq5WsHT3CxrGqIjg/7Eo8S5jBg2j24NRWvbd1cjhXEVVDU0rI46INPegPylBjSPYuudc
         F/3Q963IB7qCWs+4OvTMwI00WBGZeGKEdgBpzIBhyj3pwXVp50KB0ziiSvD55K3aQQvJ
         FdoglzWRMRTOHaZ8zNF4Z4VmwX84DRnMYWf8Ni75PPvVCtFp5K8iTP5nXoGwjejn15Xs
         cKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724564976; x=1725169776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+AXx1NranKnHe5gs6W+YUiWGU8zH6Rw9JCptNatzLE=;
        b=vHtz0EAPLUyUvF8X74BUfWPuAnd/L8gpV9re8O9/vEnGMka1C1ueet2fyFjjXAmL9S
         sPJ7gW4rwosvGlq1wP6JUmLr8gHSsgI5uV76LgKDM/lQh4KXAZIw3sfb54aTflgqml2E
         ZaFK+8HIrsKXPNMtSz5a1teDonhvd5rv1F/Rsln6oaLHc4OEBTS4qywBxJafkgaqQfZk
         PEKL4u5K0NgosgabYGNkJ4BMLNEfMs31NMUDj4kR5QOKkTLjvfi/zFnvQFCUSxxsVokW
         gwU4t3sHVh8Na/DIDICuNjbwssHW+r71JTzjerMnwz07gMi2eDUI+ctOCnpKYAkj7Cm9
         NH/g==
X-Forwarded-Encrypted: i=1; AJvYcCX2+siGzeLJ61SbyFyKM1lbSX0KsUeewBs5GD6Dlq1mxzRV31uijc/8+tG0ULqliRLtveV3LbRS5h1IoOOvQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEwbCXQeMFy3uygtPwiQcqQuv56iuBV9/vN5ecFitghMtbkup
	PkPnC3uAqkTuzpeDAvgb0KxPrkRcQ8NJAGmwpFLesQ+aD7RWg4iZiBf9dMvh
X-Google-Smtp-Source: AGHT+IH+wwLLrvJPg5hCrP6C9l7eo8aRCGwxP8UQ5GUv0uCuOFmudTpmc5Bc+z9dmYn6VfIGzcsqVA==
X-Received: by 2002:a17:907:3dac:b0:a86:a56d:c4eb with SMTP id a640c23a62f3a-a86a56ddd24mr556527266b.61.1724564975602;
        Sat, 24 Aug 2024 22:49:35 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e6102sm493408466b.94.2024.08.24.22.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 22:49:34 -0700 (PDT)
Date: Sun, 25 Aug 2024 06:49:33 +0100
From: Stafford Horne <shorne@gmail.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: qemu-devel@nongnu.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Message-ID: <ZsrF7eDccRE2jPXc@antec>
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec>
 <a90fe9aa-5835-4045-b719-8764cdb037cc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90fe9aa-5835-4045-b719-8764cdb037cc@pengutronix.de>

On Fri, Aug 23, 2024 at 09:23:23AM +0200, Ahmad Fatoum wrote:
> Hello Stafford,
> 
> On 23.08.24 08:28, Stafford Horne wrote:
> > Note the distribution list you use here: openrisc@lists.librecores.org
> > Is old and we should use linux-openrisc@vger.kernel.org.  I will get the qemu
> > maintainer file updated.
> 
> So this list is appropriate for all openrisc-related development and not only
> for the kernel?
> 
> > On Thu, Aug 22, 2024 at 06:38:38PM +0200, Ahmad Fatoum wrote:
> >> We used to only have a single UART on the platform and it was located at
> >> address 0x90000000. When the number of UARTs was increased to 4, the
> >> first UART remained at its location, but instead of being the first one
> >> to be registered, it became the last.
> >>
> >> This caused QEMU to pick 0x90000300 as the default UART, which broke
> >> software that hardcoded the address of 0x90000000 and expected its
> >> output to be visible when the user configured only a single console.
> > 
> > This makes sense but what do you mean here by DEFAULT uart?  I guess you mean
> > the one connected to qemu's stdout by default?
> 
> Yes. I am not keen on the QEMU terminology, but the first registered UART seems
> to have a special place. Besides being connected to QEMU's stdio by default,
> it's also used to populate /chosen/stdout-path as can be seen when dumping the dtb:
> 
>   qemu-system-or1k -kernel /dev/null -machine or1k-sim,dumpdtb=qemu.dtb -nographic
> 
> 
> >> This caused regressions[1] in the barebox test suite when updating to a
> >> newer QEMU. As there seems to be no good reason to register the UARTs in
> >> inverse order, let's register them by ascending address, so existing
> >> software can remain oblivious to the additional UART ports.
> > 
> > This sounds good to me.  I will test this out and queue to qemu after the small
> > clarification above.
> > 
> > Also, I will wait to see if Jason has anything to say.
> 
> Sure.
> 
> By the way, I botched the RESEND and forgot following two lines:
> 
>   Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
>   Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> Let me know if I should resend (provided there's no code changes warranting a v2).
> 

This should be fine thanks.  I will fixup the commit message and repost after a
bit of testing to ensure this does not affect other environments including
Jason's test suite which uses the 4 UARTs.

-Stafford
