Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EC4D599
	for <linux-openrisc@vger.kernel.org>; Sun, 13 Jul 2025 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752386375; cv=none; b=IPpC6ZXwR3qYOChB73lNh/OwOWtw3MSb423bFXumGRDa2qD7yve/ezX2l5+5th4WbRFO9iL3eFCDPb874TGkugogMTb1NeyFsMaG2sEd0oQ8QKEMtjdCKBiWoCRTUjFEvaXTmP2kkd5PTqLnvuc0QCBXB/+hQasR4javkiy7cWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752386375; c=relaxed/simple;
	bh=lHW68xjdlbaJTsvJYT8hh3y4XL3Op2JQAYL23cDT8MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2xbDAbxJYUMNQNfaEv5q3l0O8+KbiYQ1peM1oFKURx1fXk/9tOl9fyiKcW8uQHTJJb3HU2NTXijDfr08iAm/TudwJ0p+0/QVvGO+WC2jRKqYSqc9fLdAWRtKtakIKybJNUe2DzUNC4RQSPZn0l4nC5K5vIYGPmDNgUaxLhWXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTnJYORy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTnJYORy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455fddfa2c3so10688035e9.2
        for <linux-openrisc@vger.kernel.org>; Sat, 12 Jul 2025 22:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752386372; x=1752991172; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I+KxWgH6QfJTIEjf0mSnV+RnkEPGWqP4HB3m1ZMG0jk=;
        b=ZTnJYORyOt+/Fwv1Mgwu1O1+8z6L1frUCc7dlUy547GKjc4i7Syk/YPF7YUG3Kafr3
         6VEOR+S7e8KnECgZtWfFQ6Qxl6etX+M8W/ykID+8yuxb+DgrIsoAT0AUcPkmz5o9wonn
         dO4MX2N58DlTq6cOwnEzmzBYhE2ZIy64KsgDaeSoi9LlmqCn4fA9GGcBcITJGr0sdN6V
         vIXH1F6Im71WxcmknFI6RdjV1uSgPeOUkLHOLoPksapmWWAwl+TaPFUuyf8CSf9EUKVi
         ansNQL/3cPmj1zT9CBSBNU6fOgmzap3h7l523KQ5pmE9tIEidHXmlUCuvQJ0OPD90Pps
         ELuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752386372; x=1752991172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+KxWgH6QfJTIEjf0mSnV+RnkEPGWqP4HB3m1ZMG0jk=;
        b=Zg/Ad1Vn0t12Anj4vl3QTRq+DPVUimNMf+z/3dhrYZVJXqedpqIjCPzdGFf0t5uhbL
         Bnz+qhdYy0DoJN7TiqlO3PJfnBl5sLEAGLp6LGGaFc9xNTV9iBIvRH7EsyPcOZvNiZzg
         +W1mh0QxddRZ5zWWzA0p6R8+gMa8R0djC2f7qW2B1R8JaGRYBDMOfd68RSTZPfexA7Up
         BzmefjFX1X4pSdSPSliOU9ztDTU/Gr8e93CRhQ8iUE4590x3yICebi07zpyuIZGm4PWK
         +8cu2Qe/7rJH+z3r+Y6GnrM9adA2kbvtEcrLXDnUUBhO8HpRPvNICd/VYuGJh+3yS5K7
         OyWw==
X-Gm-Message-State: AOJu0YwkMPU6DbsGmwvON6cJF/hPjPfP2xk5vWb9wflcqxWng8svwNfJ
	hf24z5FCjC1qJ33wKGVJmv1kbeFV/YbTrxYP7NEBm2p9QM4wZKF+faOHsJTMk+jd
X-Gm-Gg: ASbGnctssXwqwMG1JqLUXFsjOqyx8J5zs/TNLZKrLqIwS2NSFjbcdf6lUXChu/HSzc6
	znDatGXUbkxduJKYf9NLRbLvT/K9dWeWNAbjcI7VX4BR8AG+X9SICb2V3sNXf4NHE7ZXDvXKb7M
	4y10RczTe6XvL/sj8tuSkJoIG0QWuT9WLrAfkyvnsLU/owKqw5/5lxl50QkuSROkqjRYgducGAY
	BjAtsx51PZ6uMI4UqVGVEFYNdhpRIuI6Zv+xLqks2+e3hseVnIFQ0SqaeInquvRZ680mS0veI3p
	03sFThhosS1hOD5Zrp8oHSAYplo8X8QfQ9gJ3ZwOFZYfpt+Ld9h5sbOzue1+gu1NK9XV3rssIZz
	hAL9MgQD7YgDDuPNvE7Vx+tN22wucmLnQnJ3HwboEOq4AOgWYfpeXIJbQs/BN1Q==
X-Google-Smtp-Source: AGHT+IHPltSTytgxnRophJ5XrAok14Qx1JMSGHN7wCJ0VXTuh4PzT3jll6Z3lw652EEBM0Ffqrd+sA==
X-Received: by 2002:a05:600c:c4a6:b0:455:ed0f:e8d4 with SMTP id 5b1f17b1804b1-455ed0fedc6mr95596125e9.10.1752386371657;
        Sat, 12 Jul 2025 22:59:31 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455f7ddd667sm49379615e9.34.2025.07.12.22.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 22:59:30 -0700 (PDT)
Date: Sun, 13 Jul 2025 06:59:29 +0100
From: Stafford Horne <shorne@gmail.com>
To: Gary Lau <zgliu@foxmail.com>
Cc: linux-openrisc <linux-openrisc@vger.kernel.org>
Subject: Re: [Question]or1k-elf/or1k-linux Windows/Cygwin toolchain
 availability?
Message-ID: <aHNLQdk1W_A7PvDw@antec>
References: <tencent_D7671DAE3F2DCA4F5AAD8A421C72F3568E08@qq.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_D7671DAE3F2DCA4F5AAD8A421C72F3568E08@qq.com>

Hi Gary,

I see you sent 2 emails which are about the same.  I will reply only to this
one.

On Sat, Jul 12, 2025 at 03:11:43PM +0800, Gary Lau wrote:
> Hi openrisc folks,  
> 
> I’m exploring OpenRISC development and would like to build the linux kernel/busybox rootfs on Windows/Cygwin. 
> I wanted to check:  
> 1. Are prebuilt or1k-elf and or1k-linux toolchains available for Windows/Cygwin?  

There are none available at the moment.  We do have docker images however.  It
seems possible to run containers on windows.  But I haven't tried it.

 - Docker images: https://openrisc.io/tutorials/images.html
 - Containers on windows: https://ubuntu.com/tutorials/windows-ubuntu-hyperv-containers#1-overview

In terms of toolchains, you may only need an or1k-elf toolchain. The or1k-linux
toolchain is a special build with no libc library which is only good for
building the kernel, you can use or1k-elf to build the kernel too.

> 2. If not, is cross-compiling from Cygwin feasible, or is a native Linux host strongly recommended?  

I am sure it's possible, I have seen that ARM and Risc-V toolchains are
available on windows via cygwin.  They mention that to build the toolchain you
must ensure the filesystem is case-sensitive.  If you can get cygwin installed
with the GCC toolchain, you can then run our normal toolchain build script, the
one I use is this:

  - newlib.build: From https://github.com/stffrdhrn/or1k-utils/tree/master
  - example usage: From https://github.com/stffrdhrn/or1k-toolchain-build/blob/master/or1k-toolchain-build/build-gcc.sh

      # Setup overrides for newlib.config
      export NOTIFY=n
      export BUILDDIR=$PWD
      export GCC_SRC=$(archive_src gcc ${GCC_VERSION})
      export BINUTILS_SRC=$(archive_src binutils ${BINUTILS_VERSION})
      export GDB_SRC=$(archive_src gdb ${GDB_VERSION})
      export NEWLIB_SRC=$(archive_src newlib ${NEWLIB_VERSION})
      export INSTALLDIR=$PREFIX
      export CROSS=${target}
      ../or1k-utils/toolchains/newlib.build

> I checked the OpenRISC docs and toolchain repos but couldn’t find Windows-specific  
> guidance. Any pointers would be helpful!  

You can mainly look for risc-v and arm guidance and then translate it to
OpenRISC.  If you get anything working please let me know, we can try to add it
as a tutorial to our main documentation.

-Stafford
