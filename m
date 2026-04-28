Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8960194AE6
	for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402857; cv=pass; b=l6EAVYuTPIqltImfMiENAI19XRz/zRGwx9/4l2tkKBhuVkWoS3SzHoywIFjthg/ngrClHm5hAbftN2vYkx/tZcU2ekvGhKZueFZEfgiSRHXKbEeSR5NqY/MVFR+Rie56qsH+AWnRprfqZYPHuHiM7V8PN6g+DMmcr/H9eKAO0O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402857; c=relaxed/simple;
	bh=75EESmo6HYH07lnZeV/3Mp3g8PIXBh+iSPBuZsveFU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIGZaLSED+uAapFVVQvotwqQQFfTddqMHSmbf5BNyRYar8ab3qeJOL56pdKG8uDZsvV0Gg0XQZib1fNFJ3OqB1ynMlPaNZwTVg9e7Jwm7WgkVmJSwvDcEoVm/vrHLRpXn5oxzS8ltDFlfRhRS8wZvjpd5ctL2sXtdp76uvSBUqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFaSGUyG; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFaSGUyG"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651b4d09141so279189d50.1
        for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 12:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777402855; cv=none;
        d=google.com; s=arc-20240605;
        b=d6MA0UHnBasyXRbb6yNyw2CPe3qNtjJTRpQhPpNwduUIThJv2pUF66BM1OKdcAhU6b
         YdAH6lgztLBIHdFXb3iBK8etXA29znSEWLpDPGx8IuEdyX1ZYqPiaPPooA8wOxLafz6S
         SkOqRri3F8p/GYLB36FV0QBSFDZ3XaNM8ltBR0T2bqcVAWmrFQZ+lxoYfrBlWRkA8otH
         8yTHWUKEdlywZBYwj8QfB6FUH2U9CJ+onIaOILVpRt8xTCrkhuGxTtKcoM6H+jjN5ZEK
         nuGuVMiqLg6YM8Q57F+O6JSube73oyV1NZ0V6XE6VCykk/eInI0/aMz0tYxWEmCv6hfo
         8abw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E/f4+2wPB9K7NzxILsl4n9ZiimULVZSocryuyEJbKsw=;
        fh=t/DllM5WyXLXGtsRDYNCIj0qrqyFTxxYiV8ybFcoVqM=;
        b=BLDxwj+xN3jIJluT3pLHUg6Q3g+Lm/dE7IXxb6UNjsPDEKsfxSqcwqilzTJNjCZ16b
         nEJBP9Y/V4Hkuu8Xq1CQSfsmlqj38rpfVa6sByTfrSRyMxrEcIu2I4gt3wRUbdI9YtwT
         fNz5twttkoLF4EK0ewzPPUFzQvy1u9IGkZFgnlnKcr/ahgdUwIBWwY6kXoqxtlHdz/xW
         Xi1mcl+9YZpbDYVN/oHviervAnx6fWspdWhajVXkdpN42yH38eKKO2/+3jvaUjEt9PKi
         oJkMcQJ0EFqNFr4KpQT7K9X8YmC8EyU+Sim4ud1TtaTcD3g2DgGcefnnJZQG1TOe1N58
         s3QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777402855; x=1778007655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E/f4+2wPB9K7NzxILsl4n9ZiimULVZSocryuyEJbKsw=;
        b=RFaSGUyG3c95e2WyvTaJREZs2KtQGTqE1jZJ5XXYCzNxW9Dvnyf/IsYXAgarTB2Yl4
         2of33nM+oL6g5bxNtf/LC+uLFOa9SlW1uCu0n7bJs36VaEeY+EZUsEd4zqAhuBe/fyiN
         JlhN2MHe+M0CM33Ac6EKwes8hRFQWQK6iZK8RKxCAb95upojbObSkERgyGZFmtWCU1he
         pkJcBLEgEKJmngsqtikOZNvP9hzQKB5WyFt4I7/wrNENzg6zb1f36RqYRhv2U043mGSG
         JSoocnXi30N3A1JUz4dPdM/iGSiXeU1wdfc1AIkkHSbh7QwuO87I1+RGsoo+j/QRi1ZO
         rngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777402855; x=1778007655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/f4+2wPB9K7NzxILsl4n9ZiimULVZSocryuyEJbKsw=;
        b=n1s4OMhIBiPtJyYrGwmZI96dNzeWL2+/Dl0XimrhLKf6u2m6RgXxPvdZfjjzS2Qjs7
         Ci6VQx6P70SSd55bytU3h1cFycYl5lrAqELvnzSxbBGoTrnZ4aNHcQKzmFeUasMXUMkI
         I0BrJLKKWRVupTFsY/kJrii+6UZhK7xj/2ohVc8MNSEwEP7qbc7E+/RKJnZ4HyY5qbU6
         M5E5tYITJO86ViPYjnAVIJqXfFqKl4CCIbIqjMfXG6wzhQlqCIfgViLYNKXt4Tf2iUkx
         zCe2ed6180LqcAUecgg5qd6hfHFGidsvvlfr3glULWabG9ivgqjjCiXriZu/dhwxX/0J
         7VHw==
X-Forwarded-Encrypted: i=1; AFNElJ8VDie6XM07NnWXGEce+U+FegbG9hE5IqjtaprgjEUM94qwWxDnfNl0L+4wAyvlDTligMInM9SqCkD2Fjf8mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvfVq9wGfwMPfuFUpWE1p5f4i0IEuRpqnnLgS4+7dINJODdpU
	3+I0Kji/4HCQxc7JjOyePzurocNaBk+DCtrsOVJuRsAlaqKM+0TKeBDV1qPrdc0LzcvqfcAiyiY
	z09fwTZ6RvPi55jPNAMUo5Zi8Lh2oXjht5IemPskDj1M29in8I4sd
X-Gm-Gg: AeBDievRAdJdRCcWK5OyVied/njAZjBSNYv0ad2DdzHWGFwp8HqeT04vgTbcoQE8MXM
	V1WUowjy4C7fvdfZ2RzqyPjycLQBnEjpA4RlekpQ7PrpPZZhztvmD0RCHPo2C43RK3CJDKCJCdM
	4v8FafXxXGtYOg64sZJPFJvRdRi2GVNPZQ3w8UBp5aLCZUIKKtrJgPlirpQ52syEYN4RmeB/kr4
	kG28asdSfNHrnQ1NPknx5cdY6T56m0l8gKHeA2W2JdHsobGLaNFMUkRRackNZEU9Jx+3drHu09I
	FIkfFBDZjmmT3KpMFyY0QUWQMSAxuBBoTWRLJAyf5UaeN307bUupSvC7MQFNNx1ukHBjfB8KFGe
	7V0zf0izfky2i
X-Received: by 2002:a05:690e:d57:b0:652:c12f:18cc with SMTP id
 956f58d0204a3-65bfe5ea1c8mr82657d50.29.1777402854634; Tue, 28 Apr 2026
 12:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428172055.1525176-1-shorne@gmail.com>
In-Reply-To: <20260428172055.1525176-1-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 20:00:42 +0100
X-Gm-Features: AVHnY4K7yosPI9oTK0FHqewJQ44HWMfciyKrWQml0bf1WAwTD1BP7bJeysXlUvA
Message-ID: <CAFEAcA83wOaVDdw99Vh1qq6WL52=Kn1Pce+U0t9Ku6UkUX1Q7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as OpenRISC board maintainer
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 18:21, Stafford Horne <shorne@gmail.com> wrote:
>
> In the recent changes from Peter I realized the OpenRISC board maintainers were
> not properly documented.  Add myself and ensure virt is properly listed.
>
> Stafford Horne (2):
>   MAINTAINERS: Add myself as maintainer for or1k-sim
>   MAINTAINERS: Add myself as the OpenRISC virt maintainer
>
>  MAINTAINERS | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
