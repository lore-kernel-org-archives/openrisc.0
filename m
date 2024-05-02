Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9180173333
	for <linux-openrisc@vger.kernel.org>; Thu,  2 May 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714682765; cv=none; b=iqY6yexDg6j+wubRVR+Z3qjvvKGFZPUxo2AA0oigZpGgZMq0TT4IDbULAscsoPC9NPPRrw1WCbBm9tQ4L4y3AKz1l0XJjdy1fhsbXHB2iOods28CQ4zk85aAkea65OWlo3K5ZVQW3yZzpVtxPR0Yg2uwrJp/WbvxUBhF+0KYcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714682765; c=relaxed/simple;
	bh=61h6+8emMhw2ATqqhNMjfvlF6pDc23oqrGHW2ju4eHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRZdSZ0bLuG6Hd0+LKodoI7AVfTAj7k+TIi0BL+KjMCHQsTHI/p5NhDa9zK6GRzqceGLlGmqVqTEyzEWE2o1nfz4eycL5ZJlav+A59zC1F6G02utf5VaCKpzihDu7NtXczfg75CW0eKEClC6eyjeYxKLY8lu2rK4HYLCtUKeU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgZQAhvg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgZQAhvg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34da84cb755so1879891f8f.2
        for <linux-openrisc@vger.kernel.org>; Thu, 02 May 2024 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714682762; x=1715287562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90MKNnh5YoS8yEdd7Tnafp2o1xJ5ih7o2EFmuodEN7c=;
        b=JgZQAhvgiORDiVMtdXhHZ4/RZERRqnv/hN/t2qXCHYBtYSU9d2XnpX9tFktBSWP62l
         LY4sXRTjXa8xxfwPAP4hBXebM1zb1aZuEwuekPyGYTnwDjKnpVfJh2uSKJ0uFnFHN/Mw
         +ewgFAPuthhVwpF5aTtzKfSuEzIVLkdHZDIHMsPmtpmtyMVGOaUP+RhNVDHJBy+yUf1E
         j0k/OG4UrGliLAm8wM6OD2bvvjZmNJvwtwHd4WOR93cJ0+sLBdY3/1ewTZP4CQoy6TWk
         27uwDEas0hN6Nsenbjdv7yuZJCUt/D8+nfXVm8GbeYQF1ZGB1sXx22cRTBJSMA+jmyid
         Zovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714682762; x=1715287562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90MKNnh5YoS8yEdd7Tnafp2o1xJ5ih7o2EFmuodEN7c=;
        b=R0KpRGC3O4k0oaZ8zTQKVXXjyTfABATtkGyQLjcpsX5RlrdaX6xGumxYz/EDLmey8A
         V3YmmX9q4MNSMKSwilCr6GlE40LxPaO5sMskqa7+oHz400vzz1Kh3levMUrJ7IJ2V2Kl
         CJAqtSTU1Uqg8tU+6kMNMHubhDY0DOcmQP30bEPPr1WSgeiFABVKxWxOriaNMbigxVyj
         dZveZ89e+oC7HNY2Fxv/JNI2Cofnl46GCbAq3PFAlMLWsXGB6TJmQthizP5JI7nVePM4
         6/NBweBzY2fr1HTMOiE2vFKttbNXvz0yv+r/K/2vyEMfQK/aNxgCIrCb2I2KeF73JO0X
         sPwA==
X-Forwarded-Encrypted: i=1; AJvYcCU53aa/MSVOQlyOoWC6zsNNOX02LLzFBm6KaY4196gvPrCfMDNA7f1NU4UT9v4v/2xPRlldUojfWlcjC2eOj//AE77nK8CqnWrQf+AQqmY=
X-Gm-Message-State: AOJu0Yw9WPveP+tWgGTTHeiHACjV58y2MmJRYTAWh0JFBuT+HzVH8RuX
	kcXg5IYarkgFwSSAmuXu3EFAbZO6+zu0mWo0aUXb0BsFz+rjDamT
X-Google-Smtp-Source: AGHT+IFs9Yu/CCr1LOTdmdGnKE5KW/KwIUO1otWZpKxgg+f4Iq6saQXtvUSa9uMbm+Anf0BkRDAgyA==
X-Received: by 2002:adf:e750:0:b0:34d:8e21:556b with SMTP id c16-20020adfe750000000b0034d8e21556bmr613301wrn.46.1714682761523;
        Thu, 02 May 2024 13:46:01 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d53ca000000b0034a710b6360sm2090038wrw.6.2024.05.02.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 13:45:59 -0700 (PDT)
Date: Thu, 2 May 2024 21:45:59 +0100
From: Stafford Horne <shorne@gmail.com>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: GLIBC patches <libc-alpha@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] or1k: Add hard float support
Message-ID: <ZjP7h7f2YXTPg5Vo@antec>
References: <20240429054735.2467433-1-shorne@gmail.com>
 <20240429054735.2467433-3-shorne@gmail.com>
 <625b3922-f627-4d8c-8ff9-40a21425989a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625b3922-f627-4d8c-8ff9-40a21425989a@linaro.org>

On Thu, May 02, 2024 at 03:44:21PM -0300, Adhemerval Zanella Netto wrote:
> 
> 
> On 29/04/24 02:47, Stafford Horne wrote:
> > This patch adds hardware floating point support to OpenRISC.  Hardware
> > floating point toolchain builds are enabled by passing the machine
> > specific argument -mhard-float to gcc via CFLAGS.  With this enabled GCC
> > generates floating point instructions for single-precision operations
> > and exports __or1k_hard_float__.
> > 
> > There are 2 main parts to this patch.
> > 
> >  - Implement fenv functions to update the FPCSR flags keeping it in sync
> >    with sfp (software floating point).
> >  - Update machine context functions to store and restore the FPCSR
> >    state.
> > 
> > *On mcontext_t ABI*
> > 
> > This patch adds __fpcsr to mcontext_t.  This is an ABI change, but also
> > an ABI fix.  The Linux kernel has always defined padding in mcontext_t
> > that space was missing from the glibc ABI.  In Linux this unused space
> > has now been re-purposed for storing the FPCSR.  This patch brings
> > OpenRISC glibc in line with the Linux kernel and other libc
> > implementation (musl).
> > 
> > Compatibility getcontext, setcontext, etc symbols have been added to
> > allow for binaries expecting the old ABI to continue to work.
> > 
> > *Hard float ABI*
> > 
> > The calling conventions and types do not change with OpenRISC hard-float
> > so glibc hard-float builds continue to use dynamic linker
> > /lib/ld-linux-or1k.so.1.
> > 
> > *Testing*
> > 
> > I have tested this patch both with hard-float and soft-float builds and
> > the test results look fine to me.  Results are as follows:
> > 
> > Hard Float
> > 
> >     # failures
> >     FAIL: elf/tst-sprof-basic		(Haven't figured out yet, not related to hard-float)
> >     FAIL: gmon/tst-gmon-pie		(PIE bug in or1k toolchain)
> >     FAIL: gmon/tst-gmon-pie-gprof	(PIE bug in or1k toolchain)
> >     FAIL: iconvdata/iconv-test		(timeout, passed when run manually)
> >     FAIL: nptl/tst-cond24		(Timeout)
> >     FAIL: nptl/tst-mutex10		(Timeout)
> > 
> >     # summary
> > 	  6 FAIL
> >        4289 PASS
> > 	 86 UNSUPPORTED
> > 	 16 XFAIL
> > 	  2 XPASS
> > 
> >     # versions
> >     Toolchain: or1k-smhfpu-linux-gnu
> >     Compiler:  gcc version 14.0.1 20240324 (experimental) [master r14-9649-gbb04a11418f] (GCC)
> >     Binutils:  GNU assembler version 2.42.0 (or1k-smhfpu-linux-gnu) using BFD version (GNU Binutils) 2.42.0.20240324
> >     Linux:     Linux buildroot 6.9.0-rc1-00008-g4dc70e1aadfa #112 SMP Sat Apr 27 06:43:11 BST 2024 openrisc GNU/Linux
> >     Tester:    shorne
> >     Glibc:     2024-04-25 b62928f907 Florian Weimer   x86: In ld.so, diagnose missing APX support in APX-only builds  (origin/master, origin/HEAD)
> > 
> > Soft Float
> > 
> >     # failures
> >     FAIL: elf/tst-sprof-basic
> >     FAIL: gmon/tst-gmon-pie
> >     FAIL: gmon/tst-gmon-pie-gprof
> >     FAIL: nptl/tst-cond24
> >     FAIL: nptl/tst-mutex10
> > 
> >     # summary
> > 	  5 FAIL
> >        4295 PASS
> > 	 81 UNSUPPORTED
> > 	 16 XFAIL
> > 	  2 XPASS
> > 
> >     # versions
> >     Toolchain: or1k-smh-linux-gnu
> >     Compiler:  gcc version 14.0.1 20240324 (experimental) [master r14-9649-gbb04a11418f] (GCC)
> >     Binutils:  GNU assembler version 2.42.0 (or1k-smh-linux-gnu) using BFD version (GNU Binutils) 2.42.0.20240324
> >     Linux:     Linux buildroot 6.9.0-rc1-00008-g4dc70e1aadfa #112 SMP Sat Apr 27 06:43:11 BST 2024 openrisc GNU/Linux
> >     Tester:    shorne
> >     Glibc:     2024-04-25 b62928f907 Florian Weimer   x86: In ld.so, diagnose missing APX support in APX-only builds  (origin/master, origin/HEAD)
> > 
> > Documentation: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
> 
> The patch looks ok regarding the mcontext_t changes, the new compat
> symbol will always be provided (even for non-fp build), but it should
> be ok.  Also, ff I understand correctly, the ISA and ABI was designed 
> is a way it should not matter whether the shared library is built 
> with/without -mhard-float, so there is no need to add extra ldconfig 
> to handle possible mismatches.

Yes.

> LGTM, thanks.  Some minor nits below.

Thanks very much for the review.

...

> > +#define _FPU_CONTROL_H
> > +
> > +#ifndef __or1k_hard_float__
> > +
> > +# define _FPU_RESERVED 0xffffffff
> > +# define _FPU_DEFAULT  0x00000000
> > +# define _FPU_GETCW(cw) (cw) = 0
> > +# define _FPU_SETCW(cw) (void) (cw)
> > +
> > +#else /* __or1k_hard_float__ */
> > +
> > +/* Layout of FPCSR:
> > +
> > + +-----------+----------------------------+-----+----+
> > + |  32 - 12  | 11 10  9  8  7  6  5  4  3 | 2-1 |  0 |
> > + +-----------+----------------------------+-----+----+
> > + |  Reserved | DZ IN IV IX  Z QN SN UN OV | RM  | EE |
> > + +-----------+----------------------------+-----+----+
> > +
> 
> Not sure who useful is this diagram without much detail of what each
> bitfield means.

Let me add some more docs here, the idea is to help explain what the below masks
mean.

> > + */
> > +
> > +# define _FPU_RESERVED 0xfffff000
> > +/* Default: rounding to nearest with exceptions disabled.  */
> > +# define _FPU_DEFAULT  0
> > +/* IEEE: Same as above with exceptions enabled.  */
> > +# define _FPU_IEEE     (_FPU_DEFAULT | 1)
> > +
> > +# define _FPU_FPCSR_RM_MASK (0x3 << 1)
> > +
> > +/* Macros for accessing the hardware control word.  */
> > +# define _FPU_GETCW(cw) __asm__ volatile ("l.mfspr %0,r0,20" : "=r" (cw))
> > +# define _FPU_SETCW(cw) __asm__ volatile ("l.mtspr r0,%0,20" : : "r" (cw))
> > +
> > +#endif /* __or1k_hard_float__ */
> > +

...

> > diff --git a/sysdeps/or1k/sfp-machine.h b/sysdeps/or1k/sfp-machine.h
> > index d17fd37730..e58e683969 100644
> > --- a/sysdeps/or1k/sfp-machine.h
> > +++ b/sysdeps/or1k/sfp-machine.h
> > @@ -36,7 +36,6 @@
> >  #define _FP_MUL_MEAT_DW_Q(R,X,Y)				\
> >    _FP_MUL_MEAT_DW_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
> >  
> > -
> 
> Spurious new line.

Ok.

Thanks, I will fix these up and post a v3 to the list before pushing the
patches.

-Stafford
