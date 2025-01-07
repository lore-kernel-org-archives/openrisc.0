Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0AC1E47C8
	for <linux-openrisc@vger.kernel.org>; Tue,  7 Jan 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271079; cv=none; b=N0bCr0AWUI++MHiLTker9yjstm3MR0md8PzwDZeqMYshav0PygWF/XTI3bi/1dW4ewZNLqDXRCW6Ea2NmOKrsTvKck9qeeZTis+h8vfApYttWwVEtW7XAXlBfuJE1kRKLQk3PKKbVrJMnQFYxMHL5mU614Sac5EN2bCBUqo10bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271079; c=relaxed/simple;
	bh=6PRnKHqGBAO3OrgJ6XQfwvTBWwnR4q9mRNEFqbFqq5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKXb30fkfCuodXFXwcjJwDq6EcaoxaS70dqblt2jorZbyykBzeHc2g5S0+nfSvEd8WHsHgiLy7UgLBRjeZ+Z4ud4trr69A8pYXCxI6+5lHHMGqV16t3cg2onPeEzm1DP5Y6B6Tj9tK0KgUWzjJB6jBdtVxAHr23fHiAbBNXyvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxrfxErE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxrfxErE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4363ae65100so163314455e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 07 Jan 2025 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736271074; x=1736875874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ESrXcS4CyR34nc2MA3Yc3tYjqpuUJbG5oTiHQj66O1w=;
        b=LxrfxErEojCnm6kYnSmrpGGUo2gSZMxbFaNQ6INF18BXZqk1sPcQmXSOBU/uuV5jHO
         5P3k9rMV8g0/wIvqhlZV9LFnY/0+52N8Hy4BYHWEGE5n8LriIObps1Jmtu5dJgVBb2iF
         29HMF0DETj6dyYAwDTzOnAWU11rX+t6OTKkfslpMhuSnKQ4kn8Au3l2Qyd+Fr5F7CDnd
         zOlTuOHc80qneEIM4w5mE+cqidpDFa6WB2xNM9F+lAIUc6+pMw3WAhW51XvcAlTCpEMm
         hW6jvnDleOMBckRueRlcbypc/un6CbsJA5AERiwj4rvxER3obrav/Yevd636xT2ICUnt
         oavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736271074; x=1736875874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESrXcS4CyR34nc2MA3Yc3tYjqpuUJbG5oTiHQj66O1w=;
        b=YlOXB7BbxgAP4/G+Fbl+SO6Oy6+RhdO8atwTsaTlnug0QkvSwBF7/Z03RDwoRJ9rqE
         WjbADdJ7AfLeQkuDIsreXiKn6SUuFe+VBgVfprrqIvk5b6AOKN6Nl1kVGhEeUTleclv8
         YNFDWlGsAoo0QX44lYWl5086ID1FBOrR+eRC6yRZ8QQeWO8BXeRoLQbVpXVpHCy0oztr
         pt8cUVK5+IT9sO7N8WyGB9pgsUIlDzlT0uOuR8TDre0CkvX5pFdOXW1sQfBrT9M2ToTc
         l4wG1YklDZt2HyyIWr1kQV/TvAfV7OhxthC/L2sTO7qYQEhUfux3FjNkpQ97QrAHGkLG
         agGA==
X-Forwarded-Encrypted: i=1; AJvYcCXmtdZIZaPAu8v9RcmcnKktVnA4SwE2wp/Wb2IkHhswm4Tw/jc3ValmluIvCN2zNsMzukwwI5BXmt+N0xetVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YylYUqgfo3vS87TGbNdWPG2lNQGwzSiSw/22fYF2nRP+4qO5HyR
	HzbLlCM95CFgKsMdkR2nQc17pJSpS8i2UoCkuTF9jFK/D8wwxWty
X-Gm-Gg: ASbGncufXv5+3F6TP821jIcgkRFbtB5rxjd9k2+KuPBwI5C2z9nY064QJV/sw2TP5wC
	ouItA7xZYUy67Eba9r3yJObr+hTC7gsGMhht1j/yZy6+XtUxqo5yNgB+ZSVlfjbT9Oc166Gr/Rn
	LQKilRApwLErcYMLSr5WZVKzaDAs3Jf8BYQbyqhUP6e/tgnuN6Nqk+IJUi1ghGiGgtVHK0pmQxz
	LuZRP+m+FonN6V8VGTCfNvWHCLpJz6rvNnwuDjKA5ebx4lOKLrvWSnS1n7MRL/hAMvCFD7celOa
	RLu3hW0MAvm9L1dzeUK5
X-Google-Smtp-Source: AGHT+IFLkrufmByFsBIalSOdTV4+sXe+2QS2kCKfrBBQZdwM5Mihg1mCSw6uXtDG3JUd8UNtdsfnlw==
X-Received: by 2002:a5d:5986:0:b0:385:d143:138b with SMTP id ffacd0b85a97d-38a223ff407mr51287114f8f.51.1736271073656;
        Tue, 07 Jan 2025 09:31:13 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6e19sm50665188f8f.100.2025.01.07.09.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 09:31:12 -0800 (PST)
Date: Tue, 7 Jan 2025 17:31:11 +0000
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
Message-ID: <Z31k3zNN3pOdGWWK@antec>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec>
 <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec>
 <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec>
 <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec>
 <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net>

On Tue, Jan 07, 2025 at 05:56:52AM -0600, Rob Landley wrote:
> On 12/31/24 19:19, Rob Landley wrote:
> > On 12/23/24 07:05, Stafford Horne wrote:
> > > > The kernel config looks like it should have virt block device
> > > > support, but
> ...
> > >    -device virtio-blk-device,drive=d0 -drive
> > > file=${DISK},id=d0,if=none,format=qcow2
> > 
> > -drive file=file.img,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
> > 
> > My -device looks similar but -drive is file=file.img,format=raw,id=hd0
> > 
> > No idea what if= does? I haven't seemed to need it...
> ...
> > Thanks, I think this target is good for release. Now to figure out why
> > sh2eb network isn't working after the restore (it used to!). Nor is
> > microblaze's network...
> 
> My test harness appends -hda filename.img to the qemu command line, which
> works for all the other targets, and is awkward to turn into
> -device lots-of-stuff,file-filename.img,more-stuff inside a shell script.
> (At best it's a special case parsing and rewriting qemu command line
> plumbing to turn "generic" into an architecture-specific workaround.)

Hi Rob,

Sorry, from the laat email I was under the impression that you had everything
working as expected.

> In THEORY I should be able to do something like:
> 
> root/or1k/run-qemu.sh -netdev user,id=net0 -device
> virtio-net-device,netdev=net0 -device virtio-blk-device,drive=sd0 -hda
> README
> 
> And just have extra arch setup that then accepts the generic appended to it.
> But in practice that says:
> 
> qemu-system-or1k: -device virtio-blk-device,drive=sd0: Device needs media,
> but drive is empty
> 
> Putting the -hda before the -device doesn't help. (And even if it did, the
> result would barf if run _without_ -hda, which should also work.)
> 
> Having -hda by itself is accepted by qemu, but I don't know what bus/driver
> gets added as a result (or1k kernel does not find it).

I am having a hard time understanding the use case.

As you know I use the following to wire in the buildroot image which I turned
into a qcow2 disk using my tool:

  https://github.com/stffrdhrn/or1k-utils/blob/master/scripts/qemu-or1k-mkimg

  -device virtio-blk-device,drive=d0 -drive file=${DISK},id=d0,format=qcow2

But I think you want to use:

  -device virtio-blk-device,drive=sd0 -hda XYZ

I have not used -hda before, do you have it working with other targets?

According to the qemu docs in qemu-options.hx. I see:

    Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
    emulated machine (this is for example the IDE bus on most x86 machines,
    but it can also be SCSI, virtio or something else on other target
    architectures). See also the :ref:`disk images` chapter in the System
    Emulation Users Guide.

I think, since we don't have a "default" bus in openrisc this doesn't work so we
need to specify the -drive explictly.

I checked the x86 machine code and confirm it seems to work like this.  There is
code in the system setup to look for hd* drives and wire them into IDE.  There
is no such code in openrisc.

-Stafford
