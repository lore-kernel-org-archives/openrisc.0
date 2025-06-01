Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405B2AF14;
	Sun,  1 Jun 2025 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748770967; cv=none; b=huuFTsoUqQj+39O2OE6vXg91mLn73t2zUupLG5cQMIGcE9TW6h5vUgtIKM6yQMLrSoOcNgfGTob/X0hSuDUvM7WDCHTrzvV7cJ1gV3VPZhqfS72Em/gDoBrbYsgdtZoeEn/Fi1fhwgl6OzDc9knHzGpT2lP7UzrR4TeTsvZfxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748770967; c=relaxed/simple;
	bh=eDEyj7O0DXxrQ8H0lcHGd7ocPN07l4RbXQMbW2am0+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rU1/e1Ky2fuqAXJkDj8AmI1JeRwSTGSM2MIAmGigDxPeXUuHOPOCufZQihObQ4WjHbwzA9OCvKFH6YCOxHgOD8LEQAidxgQS6GTKJzyuvyc2iOKk+wrSXQOv6/SquJcS+XA5jevHITefYo6LVVmiTgVYGCqLGIhjNJcU7Y5G7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL+3lrQl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL+3lrQl"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450ce671a08so21347645e9.3;
        Sun, 01 Jun 2025 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748770964; x=1749375764; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k07lU4HYaGQ7czfdPqx1uX0xnZzdxn8nnvAUd6IQVT0=;
        b=nL+3lrQloZiEt3n2ldn7d/L33x8fv0MplePHH+/9o8P98+g/LqQWLyyUwKq0JY4EI8
         ThH5j3aAppiCbIWoztf35t+PQTd7gkMglRhm0jZUpeT6ToRlh/UM1Met2dEoMjookvZb
         MG9TX1+mZ37A7EHIVCCz1pX4MC6iSjjO2fP4XslsepCyVTmwwbIH2ag8amtJyK3xbgSd
         mzC1gODJz/d3r1JYSRJk3Ucrh3PEz/qACqbqaRZf5q5LPk7yvx30IZnAaKyqpZu1MYjg
         QXQ4bA8EEWuHdG8LfC5B6q+6Bz3uSj08Uh57t8RURN+eI+2z92Ev+tO3FKsGVZmuQJ12
         s4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748770964; x=1749375764;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k07lU4HYaGQ7czfdPqx1uX0xnZzdxn8nnvAUd6IQVT0=;
        b=EEZIo3hBZr2wyi7Hp3mAH+khPVjhciVIO5CU/priwNz9b++22OJUcd6P0zDEXMJ5VE
         RO2LUhnPYUC3pPuICbrrmIRtcOjog2AHEnwDbKD+ft9KmGeBcZBVE0+HisMinqcqQgdU
         zyLZsXUuDi3hffkIPDYsbTJbPWWdP2Oc+ELZPuKfFALtsyw77F+bhmLopBcmfrt57Qn+
         l9oQkEV4UWxbZ1vvHBRPp69TgHvNGKywklfPPxOKnrdJcwVoGUyCbCgkUA3JS2F9aYKH
         APaThFi5/3KXkOsiclKfnUTQA+1n1MpdOVqZMyloy49Jqrdn/F222xn5Jcd/F+w/pND0
         NATw==
X-Forwarded-Encrypted: i=1; AJvYcCWJYizqADbS79+AVF47aj3VlJmKYnjlJpFjVW50NBuzp5M0s67NB3nkUW3aM8K0pcGlb8DwMUwr17QOSeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX271rDi8inryXRIU6Z/+jGbUiWavmaEhlUpnODsxjCL0e+Z3Q
	ppKCDDgfoFIMv+Gd2aD6a6r8Vep+m80SasGvmrDmJuHEIt0tHakQ7GkbMb9QDA==
X-Gm-Gg: ASbGncvKUot7eNW3cfiNY0Ysm66t22NzdRXqb1z3GfUXkxrNNxZgERpcdoTbv4cl1wA
	X7cRynVC+Pkm3wvUbTkzcDxMsvC8VUivqDq/wLFhQAOMrQZCOvNAVODVpuYmVwcFZzqUl4Ubsn5
	ZSkXlfszG3Wd9bC9up3+/OhzccBVZ2TYQ/tfOmc2MVl1GlEUJX9cTt689SjdbcvqRzbVPxoKxEY
	+Fi/3SlbV+RHkG47wYcdYY+j5YZsukelUE3C/GfBNf/XXE96mi0bWKW1osTrYP2q0SIQr5IvvvL
	ESgEhOQK7Jrlas6LRzJJ2mCWY3I7c1eV9KKA2W6md8hGNStvz08YOtk+08wK67xQrKogRfRJnEw
	5ygfy/mqjS10PFlo=
X-Google-Smtp-Source: AGHT+IEKvrUBq7vAuqxc1b8RpAVLQzGgnBtqTRUmTUOlFAfmKzSgtoNHxVcCjpQ7zUI9oTOYsrMYDw==
X-Received: by 2002:a05:600c:500e:b0:43d:db5:7af8 with SMTP id 5b1f17b1804b1-4511edd5e6fmr35593875e9.21.1748770964291;
        Sun, 01 Jun 2025 02:42:44 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fc24d7sm80284705e9.36.2025.06.01.02.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 02:42:43 -0700 (PDT)
Date: Sun, 1 Jun 2025 10:42:42 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.16
Message-ID: <aDwgkjzeTVNUs1Ee@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

Please consider for pull,

The following changes since commit 92a09c47464d040866cf2b4cd052bc60555185fb:

  Linux 6.15-rc5 (2025-05-04 13:55:04 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to f698ee1f40030118e3ae1af1a02fa76f79452b5c:

  dt-bindings: interrupt-controller: Convert openrisc,ompic to DT schema (2025-05-07 06:14:30 +0100)

----------------------------------------------------------------
OpenRISC updates for 6.16

Just a few documentation updates from the community.

 - Device tree documentation conversion from txt to yaml.
 - Documentation addition to help users getting started with initramfs
   on OpenRISC.

----------------------------------------------------------------
Ann Yun (1):
      Documentation:openrisc: Add build instructions with initramfs

Rob Herring (Arm) (2):
      dt-bindings: interrupt-controller: Convert opencores,or1k-pic to DT schema
      dt-bindings: interrupt-controller: Convert openrisc,ompic to DT schema

 Documentation/arch/openrisc/openrisc_port.rst      |  6 +++
 .../interrupt-controller/opencores,or1k-pic.txt    | 23 -----------
 .../interrupt-controller/opencores,or1k-pic.yaml   | 38 ++++++++++++++++++
 .../interrupt-controller/openrisc,ompic.txt        | 22 -----------
 .../interrupt-controller/openrisc,ompic.yaml       | 45 ++++++++++++++++++++++
 5 files changed, 89 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/opencores,or1k-pic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/opencores,or1k-pic.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.yaml
