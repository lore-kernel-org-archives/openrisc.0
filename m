Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0529AAEA;
	Thu,  4 Sep 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980451; cv=none; b=ACpHmtRRjABimU/vB2cGx5Oy1NjMP13jEEcJVzCcYtxyvrcyscghf8DJtr5owgFCGEKrK6MbLWq8kPBBQBfaPbLGgzpR6c+qKaitdk2WYjeXPNIYf+CgJTUP9swkKwjTJ9//uJq9aqDteJgbvpOVrbHd0/HLubRn+XCDHRocIJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980451; c=relaxed/simple;
	bh=S2QJA2AOVeoUizABYeyfp6Twp176A8/YUn6FmsB1EvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CdxdJfAXcfAMA+HxpZhKOmHf2Fejq/NRHdVGnkYg5ngl1jNGvgSW//KX2mF7T5TTnmM5VIiRhUHrFSsA8bUwdvFcNkvKg6oOQ0EHCUmmNibDdP/m4HsrRNtxfcSBmKVxNn8YoDW3TBI6g3oimvJEqthu8pVpDJQ/+H9vybuwoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nOl1yB9O; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nOl1yB9O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XA7weSSUHOq64zac9iqpCNVbJO8t7SshxgtzKYssu+U=;
	t=1756980450; x=1758190050; b=nOl1yB9OkA/+3/1WQ5cxit+4ajJQu4yIXykGM8gkQ6j/1Zu
	AQsJUP+u6/dF9iaUGiuB6AyPlrK77g7e+d2rwMjlWv4+ursabJTnm28GgLhMFCvYQD6Ixe9ffeVw3
	2AW4wT82AdqYnL6ZiDlJopaiY1pe+Go3XpLVlZuiXRa/EYLogce2cbGs34msCZsz4++NhPXjyMb6V
	b1dFP1wU1K1r1QKaeaS4HAt/8Cx57oYvvpbkqb0S1RBfWYclC6Crh0ct0PyEsHkIbij6O7iKKb5Oq
	zwfCN4ccb1f4VyC4ccbOSv/RF0hvKNwovEeG9G4gi7KDcApwWhSXU93hv0vrbIqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu6s7-0000000DzTb-2JBt;
	Thu, 04 Sep 2025 12:07:15 +0200
Message-ID: <c0a6f1960a39ca6cc84764614cfd8ccb0afc24f9.camel@sipsolutions.net>
Subject: Re: [PATCH v4 4/4] openrisc: Add jump label support
From: Johannes Berg <johannes@sipsolutions.net>
To: ChenMiao <chenmiao.ku@gmail.com>, Linux Kernel	
 <linux-kernel@vger.kernel.org>, Linux OpenRISC
 <linux-openrisc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne
 <shorne@gmail.com>, Peter Zijlstra	 <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron	 <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel	 <ardb@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Nicolas Schier	 <nicolas.schier@linux.dev>, Sahil
 Siddiq <sahilcdq0@gmail.com>, 	linux-doc@vger.kernel.org
Date: Thu, 04 Sep 2025 12:07:14 +0200
In-Reply-To: <20250904100109.688033-5-chenmiao.ku@gmail.com> (sfid-20250904_120203_780907_7229F626)
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
	 <20250904100109.688033-5-chenmiao.ku@gmail.com>
	 (sfid-20250904_120203_780907_7229F626)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So I'm not quite sure why I'm CC'ed, nor do I really care much, but
since I was idly reading through it anyway ...

> +		if (unlikely(offset < -134217728 || offset > 134217724)) {
> +			WARN_ON_ONCE(true);
> +		}

Seems like that should just be

	WARN_ON_ONCE(offset < -134217728 || offset > 134217724);

since the unlikely is in there already.

> +	if (early_boot_irqs_disabled) {
> +		copy_to_kernel_nofault(addr, &insn, sizeof(insn));
> +	} else {
> +		patch_insn_write(addr, insn);
> +	}

(and maybe that doesn't need braces)

johannes
