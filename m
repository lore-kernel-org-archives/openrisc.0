Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99330A94A;
	Sat, 26 Apr 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745675921; cv=none; b=SxCmyuiFc6zgQWt9Ykv+zkR0nENSGlnOj2ps0c2F1lHIim5rVGkSIDBHS2tW/lEJw5Phkre8hI4q/H6o1kpf5BCT4VEulCVHrLMfBCp1huLgEz1u09ojeZlF6h8I5+RJ8zTEg75Pnzo89AWrZu/9eYjd2VHtbM4a3y5V6OMu17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745675921; c=relaxed/simple;
	bh=jcJH2uY7xwisDKTpoXiSdFpRmVUr1IsGNewM+lcU89g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgfxCl9z8X+23lWJxM3eAKbAUnDF/krdv1/Y474nxUX3TWqIlrV8ZAdQP7+d9Nen+ctXsgwfX2XDeCorwPaj+ZqAV9wJAuKKtM4Nf/nZ5nMekUoKeAxMgWfc6gQIAMiRxgCHKlEyMm6VBLQ1wK1eetNnYOZGW101s54GAIDfK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcDOe0D9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcDOe0D9"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af5085f7861so2420290a12.3;
        Sat, 26 Apr 2025 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745675919; x=1746280719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiGdo2FHJd8De8ADEidT5DPemaaP0nnmMXhnvOOqxuo=;
        b=WcDOe0D9pcNnF5RHMh8yMK/5JYaPsUYCYcIaAqjh4xabQsN54pkhBs8fBtqo+SPixp
         mynrk7ZPS3JjOCo4yjX27mpqpANQxKluI4ygrJFOtFzbx8qFhGOrRAayqVK9pLareuMn
         YS706urO764gTyz2JmGtXxcNEi9dREnqANCD0061PQHgOG8Lszs5JuVvV0q78vc5OR5N
         MafxtGJSClxuhm/7vFmj3s76tAZnuZegi7WCvT5rvU6+5xwt3acHar6Tw1SzLJ3d50hj
         qvR7Ifs+Yc7NH148cutMq9EjMexVIKjgs9F8VWLkcZmWKac5uFSqLECsyAcbSzhf9jTP
         UmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745675919; x=1746280719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiGdo2FHJd8De8ADEidT5DPemaaP0nnmMXhnvOOqxuo=;
        b=WSJ+K/DNkSu1OEZaPU/Cq/bOz3+N4VGk7/MAJ/JSo+37L+r3iq7gT+EHd/kmx+xQuB
         6X+gY2V99ascUVkyc2LTrVbQe8coK51d//3u7Rtl6LXf2CNSabiqqzSCwBjB8PA4YiEX
         1D/jjBcL4L2qxj7Fx/hfLPVnqNSN9zXYy3F549+N8d1znygbTaXqs+AT0iKfleWGJRVP
         imrNQFp0ZOrcvPuDFHhKPOy7KpimY5OcDYnoau7nAPhZ2tTk6rzsWn8eOzNjsGVQ7dbe
         qZk8duhUVxxcn/kA/9Ppfu7SkNFuNpQjrf2Absurozw7PYjnWVI6pN9YZnRh2feJnWyw
         Uutw==
X-Forwarded-Encrypted: i=1; AJvYcCUmUcek5onOZVZ6LPzihZNOYUdgd6v4rJjwWXw0tcRqtXxhttKiARbMtkAjgBDtkFgA/t04Hdm8/3TtM8T/518=@vger.kernel.org, AJvYcCV6kr448q/aqkJ6dFWG7GE8Rt3Mw/rwumBuPNvv2/ygDBkEwiifNFoPr82oicHVaImiu/kg3TVvgBDe9VPJ@vger.kernel.org, AJvYcCXf8s2LxdswYW1CYXajtWG8UQeAvLW/5vvhGJWglTfSx0raVHzQgqWlH8p3Gjq2FTUuqSP8UMwwU3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMICi+Z5ZFYY9zzzDv7wUDgFYyY4bpXtq6N4lintm5GFV4rBIT
	u/o1o6UbDyVBsX0Uyfnr3wtH51Zit2rkMW7OFaj8o+dMiB6cgKa6VddeWpChdF8MTVm73EJzfYl
	SN9yBleljOMkWHneUXyGVML3KfKUxEXpttqE=
X-Gm-Gg: ASbGncuRo9vSg/C7X4In5+at2Q/FhnFBWe/DE/gPHJ2v7ayqb7z4B9Vfm1sUq7+jISJ
	aoHMHuuGtNCwqERFc6xXlgIpINW9NowfvRff8+/cCXMQlk0FRgj9JUfo+8yy875Unz4gzcpxdXz
	MkWvKWqbFN1H1NDZsRRw+ciA==
X-Google-Smtp-Source: AGHT+IHQRfyQdCrnuIRknDKukO/4PUTw6x1XqIRIJ3y1/jSIKnziD8NYCuXTLTCYgrjJm9l1uKOVnAOp5Cj+UcTxHZM=
X-Received: by 2002:a17:90b:47:b0:2ff:58a4:9db3 with SMTP id
 98e67ed59e1d1-30a013c3fdfmr4966449a91.35.1745675918898; Sat, 26 Apr 2025
 06:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425201018.12756-1-by.ann.yun@gmail.com> <aAyeY-cFSDuLYnJZ@antec>
In-Reply-To: <aAyeY-cFSDuLYnJZ@antec>
From: Ann Yun <by.ann.yun@gmail.com>
Date: Sat, 26 Apr 2025 09:58:28 -0400
X-Gm-Features: ATxdqUEsSIOWUKOM40YB5o8sO36FbTC11EnJNuwZDiW3l41_jTXfMS9YN9U9EaY
Message-ID: <CAB60mtNRLstmV7c97=tUnW9GhMkn809eKHcGnA4x1iGcpGjYLQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation:openrisc: Add build instructions with initramfs
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, corbet@lwn.net, 
	linux-openrisc@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stafford,

I am sending my same reply to the whole group again, because I
previously did not do "Reply All".

On Sat, Apr 26, 2025 at 4:50=E2=80=AFAM Stafford Horne <shorne@gmail.com> w=
rote:
>
> I think this is good, but maybe we can mention to refer to Documentation/=
filesystems/ramfs-rootfs-initramfs.rst
> for more details on this?

Thanks for pointing that out. That is an excellent idea, I will add that.

> Also, it may be helpful to mention we can get pre-built busybox rootfs im=
ages
> here:
>
>   https://github.com/stffrdhrn/or1k-rootfs-build/releases
>
> But if we do that then it would be better to show how to use thos rootfs =
images,
> which maybe something better we have in our openrisc/tutorials[0].
>
> -Stafford
>
> [0] https://github.com/openrisc/tutorials

Exactly! I was working on a QEMU tutorial inside openrisc/tutorials
and that prompted me to add that one line here.

Ann
