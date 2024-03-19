Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C4F3C488
	for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884574; cv=none; b=ddlbF7uDamrZcfsjkfevW19herb+jKnRykyzY4iS0hJhvFr4Fqh0VrOL64TOMGwQ7/vk60+MFc00+uQqIX49dHX2tvl9U/vgfTbIROMztzJRHmgthq+9aMi3jyJ56FLoizxfKdLyHEeHWgaxs+2ihkS3/aTJvhCkhMHN2fH29rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884574; c=relaxed/simple;
	bh=/7bRT4p9VWRJEKD88y2Oxd8JLzdyBGn07wYEeE9lQKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6BYk5WPhygTlVCYz2yidM22qVYNP5Qnr9+RgA65c5LeJp6Z5WM+6pXCpFtf8SRHckpG93hwwC7+q+ncYCHNAfDcAPfFIXcVPOdEgFpk/bL2tZGgpphlVdv+KBIg/SVARC2fyQ7jlL2/ABhsgC+J/AZR6DmfFpW+BEbVnwb3D34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR8m8L+L; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR8m8L+L"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41467d697a2so6128455e9.1
        for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710884571; x=1711489371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqWDFOie7mX3TwU3LgIVX+4d9y6x5nENIVyjPNwgDWE=;
        b=PR8m8L+LbC0KSvc5w5GEv7Ixvqncq0NUVBWS15BXmthLguJPB7SS6koQ+fcYgXDldZ
         lOQynDbARLDC0zKFERDf9AMsmPJApFuDDl3sLJvVXIEGU9fiQ+qeJ94IRF0FRx1zYw3U
         RXc23pIjilu9M0xn0SDHJ3SmBcbMzvhiiBEfAl0/pWSVhN+zPf9YGrKbz031xm2bvbnz
         TSZwJeWcydOsytfI68CKmVJdavkoBUYbzZcYFssV+n4ZRV3vHc0v7jnBWuix0z0czY7z
         W5OeBlNq7b8AS5cWzUC9Jy8jvKQvFyhXeb2BK80eMyaKjux4D6F9wNHl/2M0AJE5N6iz
         EPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710884571; x=1711489371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqWDFOie7mX3TwU3LgIVX+4d9y6x5nENIVyjPNwgDWE=;
        b=Pmz3tkZP+XLzGkturqy/1OMSguxqKjzgMN0H1KALkO/+PEs9VyMSVBdJVXgWzSlJKu
         xPMtNHoAzwiNPXatpIyIjuDfvBB7p+DEVico7c7cyZJ8Bcrj0CnBqNxfz6NftfFXD+0+
         7zyl2dyKiR8ga4S3O8tgOuIwU9wJn0B7XTwvBRxpxyiL64sfLBIhXdP4Bv+gPTMeypvR
         dyfwb3TF/AquzZyb3vPUlD1sQ4h1X7sayaF7erSIYqEyjeXI7DciZTJu6szBosWzL5bT
         xVcssl4zdyu9xh9cugggtVotdoWY9WDVKW2l048e+PgEyd88z1/2H+rPRP985yCljocT
         QO2A==
X-Gm-Message-State: AOJu0YyJIg1bTaBlYfy5olvQaMX3vzhbu/QSXmIJLoSfM+4YgOz6Tk//
	Hkn11kLIYIE7vjQf1CzwdUJ8xYPtMhb/7WKeGa4lCADLpm/f1Hp+
X-Google-Smtp-Source: AGHT+IHM/bU0zuvq5hRuUkX7y0CmYCNwQ1HowV1Uk8fNUKD9TUZR34vbmkXMEl/HTZGJrK7cDY9qNw==
X-Received: by 2002:a05:600c:2242:b0:414:a49:131a with SMTP id a2-20020a05600c224200b004140a49131amr7538290wmm.23.1710884571191;
        Tue, 19 Mar 2024 14:42:51 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b0041401eb021asm92763wmo.24.2024.03.19.14.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:42:49 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 1/4] or1k: Fix Linux user space signal ABI
Date: Tue, 19 Mar 2024 21:42:41 +0000
Message-ID: <20240319214244.736981-2-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319214244.736981-1-shorne@gmail.com>
References: <20240319214244.736981-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OpenRISC sigcontext structure has always been defined as:

    struct user_regs_struct {
	    /* GPR R0-R31... */
	    unsigned long gpr[32];
	    unsigned long pc;
	    unsigned long sr;
    };

    struct sigcontext {
	    struct user_regs_struct regs;  /* needs to be first */
	    unsigned long oldmask;	/* unused */
    };

With Linux v6.8 we added FPU support and repurposed the oldmask
to use for the FPCSR (floating point control status register).

    struct sigcontext {
	    struct user_regs_struct regs;  /* needs to be first */
	    union {
		    unsigned long fpcsr;
		    unsigned long oldmask;	/* unused */
	    };
    };

The definition of mcontext_t was always missing the extra space for
oldmask.  This patch adds the field __fpcsr to mcontext_t to fix the ABI
mismatch between glibc and Linux.
---
 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
index b17e919154..1b428592ee 100644
--- a/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
+++ b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
@@ -38,6 +38,7 @@ typedef struct
     unsigned long int __gprs[__NGREG];
     unsigned long int __pc;
     unsigned long int __sr;
+    unsigned long int __fpcsr;
   } mcontext_t;
 
 /* Userlevel context.  */
-- 
2.44.0

