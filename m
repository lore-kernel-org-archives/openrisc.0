Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.215.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792514337;
	b=qCROqW/zn/XipaQIM8EpGkullAjKFEAReIOy41iY52naucZs0YGcB4A+CoFwvp6Ac8aM
	 Q9LKJpQu6nR+dUm8X3Ub7Pkbge/BppZOx4hQPwvIEv749//G0eeMGeQ4WVV/ultZEO1yg
	 +dDXAg1FRXDdnbgl4SmdOyPZRSt9fHbIJOMGfp0vS/lY+8mynVV+7Wy8alcaoVhrkLfSv
	 qYAVh5b2UKxiCEb5MfcAEalDSYgBTbYOs0H6X+Ga3qoyiCx7co2mkcgWG0WqB19C2DZw3
	 OrnigWH5sgnJjjOAsWbWGSO7rvB+17qKvcM9VWDYfgcFAt++HpHpEhcEMv/hfkVo3ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
	b=pwzU8WgbTBvZNLz1ydJg3Wv7Gp91RfShI8RCl+mylhC21eZhbrEXgAxgWpTQa0KxduTT
	 Bsnr5xXyPrlUbLbTqG+VcbvXIcR0p15RcMLq6KiAPuiCNj7Uvy2t7FxEoecg6hk8N5S7u
	 y+IzJhbJGJDbxr992rw+33G3fuzoNlNEUrXvBhBmReuZAiUTCD5f414OkfrZNBZWOgwcj
	 yTKWxeWJ9OdFOXMUBXHj0uHkcpVv0wnJMNZyPG0MiugAsImH7719umEyx/6Fa4aRaWxcw
	 do7EBVCBC+1Fpp/ao7qOOZxa7U6mMmoYZtiqzma+psU8rab6+fS+X4PFMaHnnxWeFMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	arc=fail smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465F60A2637
	for <linux-openrisc@vger.kernel.org>; Tue, 20 Oct 2026 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0465F60A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so1265260a12.1
        for <linux-openrisc@vger.kernel.org>; Tue, 20 Oct 2026 09:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792514336; cv=none;
        d=google.com; s=arc-20260327;
        b=s91HrwQ326M8ESr19Q7NVcqZWgNgLHjqVwFkx92CKvmMOYKiQssOBSBjZ05repzeys
         uFvZIo8wjuWtI1Bs3jo3K+B2/Fj4fKOpA2R6z5EGlMCCvYFbgSkqLLgIqbexncL8eEoz
         0nR/DnK3R0xlr9asy4nLEiQRS+kkDLPsEYSHrtbIdulz3LrbFYi1iuiuKJvY2feiQGvZ
         uwHf6pzojUSqunFP6e78JPvdjNn0a9kit5951JeVVFlFGD9ZLR6fM9czz4nMrHtnXaGM
         Zpk64hGSrQILnt/kivx3a5gscpw+pMpLrZBiPgRRU6HxbF1SR41OyT4IzJrpl8BEFDPq
         Itgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        fh=5ZpEi82xTCUccdDm8EmZFy4wGncED0O2RvxNuqozSu0=;
        b=CJCFco4ZYySnhXgxBRpJvvZdt3YUO7JnMR6kPvevz9BvnVuelUHXyh76e9MtMUMeTP
         xOQ3EMQ3udHwFSyEMssf/w0wxTXJiEQnMXEnXXSRq0/lxKrLW03UCo6acyvGbmWDTiok
         BfxE0sPNOijCg0tXMhekLt2ReHqVQhIBow1vb9JkS8EAKdIgdRoOOw/VSHQ/Y9azokoe
         Ctlt52vUvDj1KrurVX80rIk+vy5xda2MTJsBv4y1ITSDpZnVxaRizuThMRCXYhx4ZAt6
         3XLb/4JfqAhy5exhr57xZ65xRWs/mQ+EaFXND9To/I0/GirnM+cozn2F0q3Ofm8JMbas
         3ZBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792514336; x=1793119136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=GwYGVURAL7E3Gqp1mE6IbppA5fK/M6QVj3T4+Mu1VqNJAQWSHTCgIBs7lXAHx7VP4b
         X7Ol6JtjEVwHUVW/UUWijctAKk0S3FIF6sAkL2D0z4+yun1CiPIG05jQakKiuYArY+di
         qKUZ2JssWHS9PY4Rrbam2j+K8HSVipMYAjJhVwlz0qlw5vC30c9m2oPlM5nOac4bwKsb
         0iIOeo41vgbotndmbkqO3IW2nEL8EcaGXBwYuALkuaiWKHExqpmpd78k/kVF659++rVb
         16kcHMvBo17gh+L06xflahlYQXJ+NMSTGDwKIeHcy9Z1IKqewLhKEpxT50Ywi1EBHbtT
         Ya6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514336; x=1793119136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=wFRXDOw6218RxPjnEH/AreeZshJrKNp4CIKynYJXV9ES5jLn0a08E1LNpqimSNEGPp
         NCaaYGfFH0sWS3lbfOHW3xbeT0vQ5cPh9kpLgQS3lXKFoeOViT8sKf28S6cGhE45okzL
         sLdUxhddYZuoXpn3wzyXP30QAx57SK0Spx5TLrhISM2i06aRQfEUXGnhSXELeG239p+X
         EX7QowRof7A+O+tL3d4tJF3GzqRLu2+zMNkTgd4VqO9QPW1BE7TKowz8MOHAmz4FKfS9
         16oLElgN4LCRjMOMX/6SQuxjZh9sLHGOneTWoN/wYz0oQQf/QUqdhypiFoZXadlzctan
         ZDSw==
X-Forwarded-Encrypted: i=1; AKwUvBzEaHz1RMA6ueGvATQRafp6NvwEqbUHWc/OzJgpko8sGejQUnm5sWs8HzLz3bDDUJxtRF5pj7Db+Rn6ly6bew==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9ReYFgUvsurwA57TnBOwfZDpnu4owbdBmSqKiUVRg3EBDIBj4
	IO84jlypOHiKSLnfFGo9jEaWaIFh38uSGqNIFTnymbStAgzu4rgDLQNj6bwEgqMDYQe7sPVoucV
	IS4+3i9zTVzw+RZPtjZtHyEpV+mqhE9mgW5yGFPPi
X-Gm-Gg: AYBFou05zD72N1roT8CJC7cRFSrDzLtN8EeeoP5kPy0D0toxeRGWe+1wH03G3msTRuH
	TVQl5vhdVCx3BUNLYXqLH7L5k57oiwEZa1Gy2ezkw9qwSio3L1ZIHwoV7dWs/EJY/N+KdZSrdij
	jRZbhAI0hALUZjmR4nsQkcdOB/XHE6/yOfESMUNcs42aPjnfDisEpJ0s2FiyqrpKY+8qhriherd
	2asjTo4HTEPma1SbR+KHtJCkzm0Wfge30mOaT6f0lW4RTdXnXvIK00ZwmftXh/7ZEMiWCnJeTd4
	2hkPiUH6e524PSs+7OrqIhLtiZ0ndJFKq2fiG0HBOqoThH6ugiRi3TjoQyOGBqKc/1JVsCrrGW7
	QtSnP35BDOmw=
X-Received: by 2002:a17:903:1111:b0:2e6:dcce:8227 with SMTP id
 d9443c01a7336-2e9a6c1a30dmr99034965ad.37.1792514336247; Tue, 20 Oct 2026
 09:38:56 -0700 (PDT)
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
In-Reply-To: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Oct 2026 12:38:41 -0400
X-Gm-Features: AclHuK9ZakV6IFm9eD67kaqUic0iU1MgVPLS7VN6RgjPgTRZmZP6_X_XOYOX9ZU
Message-ID: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redha=
t.com> wrote:

...

> > * As pointed out by Sashiko, when you were converting all of the
> > arches, it looks like you missed alpha.  I took a quick look and it
> > appears that it should be a pretty straightforward conversion like
> > most of the others.
>
> I've actually dropped the alpha patch as per Magnus's request [1].
>
> [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4=
BLWOvDTt92t5Eg@mail.gmail.com/

The problem is that as things stand, this patchset breaks the build on
Alpha.  Perhaps this gets resolved during the current merge window,
but as you know we can't break the kernel build ...

https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

--=20
paul-moore.com
