Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FA1FA3743
	for <openrisc@archiver.kernel.org>; Fri, 28 Oct 2022 07:40:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1D3E624B8C;
	Fri, 28 Oct 2022 09:40:41 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mail.librecores.org (Postfix) with ESMTPS id C394F24B58
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 09:40:39 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 bh7-20020a05600c3d0700b003c6fb3b2052so2932424wmb.2
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i2N6u0rpi5MSxrtESZE6Q60hmeXl2yrT4Q/yzn9seGQ=;
 b=AoCvpD2g8hOJXZ2R+h0TvZDHfaokVkjBrIgJhsnS+RetduEnMeG2bCCW5x/1wmwm7y
 tpBT95DdI7WubCuwdur/JGKGBJMJTmP2C+cDmuRV2EIc6vAsZ3DUgxOdepf3Ri0V5o/g
 s61UXLKKrJMPwJgSYbyvTnZ2kLiEieceMzgGWlWdWLree/oXrw+5/Cgog666CiUnyi5H
 iiuCQyE6pPGPEBhy4h9c2slAcvDIj2QVcAFikE7NBHa9TvAFyRkoKz9Xmr0z/0PG8Ue7
 mIV0FWee9ddQzPpFwF4bakArR7lyrUpkkh9KC8i6sE/VKS8eJ/p/NH5MjHPo/bG55EaI
 zcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2N6u0rpi5MSxrtESZE6Q60hmeXl2yrT4Q/yzn9seGQ=;
 b=55VnOlvGcIw6yx+uUW3gf8aPeMHX+g8uo+UBOzHOfgjPmkLrBISR7TrssSvjJlFf5p
 SbRwvRwjXttb9hSEP7BJWvWie1KClJllNTEzcTAtk3eGc6aZWdEmkaJvKW6bOoGjMKL+
 4tIeA7+Ih5mh69wKapoE2n7b5Ae+D9yg+8eNtO13wf/PtVqUayKBxLDPw9ErrtPTrq6u
 IFZM/fhLkLn1SXwEyPhOA6ccmUUFVPmFsMWzgO/Cr6J4fEIRVkIHQQ3nv4Tf4p2nFNBM
 b3eywlSxx6OUhVbR9Q+ICKkla/C3GFQ+EsvLTu35P8YzGKGxRrQ7iXFGIVnFZYBqhr/m
 JMSQ==
X-Gm-Message-State: ACrzQf0d9tiMkz0b/o9zywf5n2qKJ6T2jwR1cOCbbObSUyjUHTP7vbRJ
 Re2KU6no/5K3Sjw587AXm6mLtg==
X-Google-Smtp-Source: AMsMyM6b9ooO2YT2Bk853NHb7QqLyKbP8a68ufEkfEtecmJkMMeYnDPuL+24oxMQM0KqoQzia6z3ug==
X-Received: by 2002:a05:600c:3b88:b0:3c6:cef8:8465 with SMTP id
 n8-20020a05600c3b8800b003c6cef88465mr8354486wms.64.1666942839337; 
 Fri, 28 Oct 2022 00:40:39 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a05600c1c0300b003b4ff30e566sm12687932wms.3.2022.10.28.00.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Oct 2022 00:40:38 -0700 (PDT)
Date: Fri, 28 Oct 2022 09:40:37 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v3 0/2] Fix /proc/cpuinfo cpumask warning
Message-ID: <20221028074037.ksvtvzajyulm3oy2@kamzik>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <mhng-b3bcbdea-1572-44ba-9d9a-e35e55b8880f@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-b3bcbdea-1572-44ba-9d9a-e35e55b8880f@palmer-ri-x1c9a>
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: jonas@southpole.se, linux-s390@vger.kernel.org, agordeev@linux.ibm.com,
 dave.hansen@linux.intel.com, gor@linux.ibm.com, yury.norov@gmail.com,
 mpe@ellerman.id.au, hca@linux.ibm.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, openrisc@lists.librecores.org, mingo@redhat.com,
 bp@alien8.de, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 tglx@linutronix.de, aou@eecs.berkeley.edu
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Oct 27, 2022 at 04:07:18PM -0700, Palmer Dabbelt wrote:
> On Fri, 14 Oct 2022 08:58:43 PDT (-0700), ajones@ventanamicro.com wrote:
> > Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> > started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> > are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> > start and next seq operations implement a pattern like
> > 
> >   n = cpumask_next(n - 1, mask);
> >   show(n);
> >   while (1) {
> >       ++n;
> >       n = cpumask_next(n - 1, mask);
> >       if (n >= nr_cpu_ids)
> >           break;
> >       show(n);
> >   }
> > 
> > which will issue the warning when reading /proc/cpuinfo.
> > 
> > [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> > 
> > This series address the issue for x86 and riscv, but from a quick
> > grep of cpuinfo seq operations, I think at least openrisc, powerpc,
> > and s390 also need an equivalent patch. While the test is simple (see
> > next paragraph) I'm not equipped to test on each architecture.
> > 
> > To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to
> > a shell, do 'cat /proc/cpuinfo', and look for a kernel warning.
> > 
> > While the patches are being posted together in a series since they're
> > for two different architectures they don't necessarily need to go
> > through the same tree.
> > 
> > v3:
> >   - Change condition from >= to == in order to still get a warning
> >     for > as that's unexpected. [Yury]
> >   - Picked up tags on the riscv patch
> > 
> > v2:
> >   - Added all the information I should have in the first place
> >     to the commit message [Boris]
> >   - Changed style of fix [Boris]
> > 
> > Andrew Jones (2):
> >   RISC-V: Fix /proc/cpuinfo cpumask warning
> 
> I just took the RISC-V fix, might be worth re-sending the x86 one alone as
> nobody's replied over there so it may be lost.

Thanks Palmer. I still believe this fix is a good idea, or at least
not wrong, but as the cpumask change which started the warnings was
reverted (commit 80493877d7d0 ("Revert "cpumask: fix checking valid
cpu range".")) it seems the urgency for fixes like this one was
reduced. I'll ping the x86 patch to see if it's still of interest
or not.

Thanks,
drew
