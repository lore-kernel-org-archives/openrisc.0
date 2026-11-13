Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528920;
	b=zTS6ldQVsSFk0kmXJ+KoLHHJq01wo3Q1rch93DKHIEf/hH1aFwP8soOOHGWVD4u4WhDw
	 wAfN6DC2URNKNoPBHy4JOU5oImAuHLgs2hFF2sFmMwanHIiJdYOX5I6EbDrrzddo2e3lj
	 nX3qUJ9uRsBpV8wf14+/fFfm7u1GJ4475Qe0JYyEX7nJY2WKIspBiJpXytz3J+7Es9LCn
	 xD/CZcI0GMtYzJjGK6QmqQjWvsQgBY+pUFylJb/sec/5kaY8bBiYe9YipkBcLUsdJFY4x
	 LdBzsNK4kg07YLvnEFQltEwBWFRtOYif2u1RB0oq5pJwjsw7gYzbDcDT1d2xnxUVjbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JxOcaVWI6i/3vDXJ/McBySoTqVwECLMhKYWlZ9iPDsA=;
	b=k2j8YQJLzJrQUpjjkd0LTlJytx80mL/aJgyv+f0TWle1NB/N+paT9JeNBXbSOJ0OWxYu
	 EqIsR7kVR/C/xOxibNO3EZp5sONP3pwk0cv5yBjqWEnV+IBI75IwK7Zn3GY3kGsxYgrjI
	 N3819r00iwSPcrQ/gW/4YyAcFiq3h1PQYOOLQRciko3lJuYsu0wwdSsk875c8K4kwP/yi
	 yTIgz7rVy1vc3ydmnXPlYE/GQugW3cEQig0qKOvm6kLOmEzY2zGuBqbMRp7FR4DzgCUCT
	 Ic0072Ek4aynx+Kwq1B1LklzCeXEx+AaYKPJlu+ECpquU5kBHBoMhRiwwG9W3BI4WNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OdQTwI1e;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE86606A8AC
	for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 00:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BE86606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OdQTwI1e
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c158c4c15fso567215e87.1
        for <linux-openrisc@vger.kernel.org>; Thu, 12 Nov 2026 16:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794528918; x=1795133718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JxOcaVWI6i/3vDXJ/McBySoTqVwECLMhKYWlZ9iPDsA=;
        b=OdQTwI1efea5j1xn0K4k+TOBlQiWRJUfVPgOUhEXGLwqn+mmEYon+bPWcfpoJGPkMG
         dD6yqrmVbDR8KtlQY2Bm5yv+hBwLuWv4i+0zzI4+WL45RmlS1SDswX1mie9ZpVu+47dJ
         SKFaNblFXHn+HoSmbl5R53rDrcNHRbF5hmxCWufP4vZ7V5kIholUiImEXrCtOXKlG55d
         xANIeOAaxtSvlKysoroBBqzdrzP6h5XPGfkRM+I9Oj7ByorqNGZOaBXHSOWYcEuMy0zW
         zLwWNb/rp3w9Z31O1mPvM0Uc4BbgnipcVd+hR6SfHgqf+wZCpMzj3kuXnx170TzcSKDS
         09vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794528918; x=1795133718;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxOcaVWI6i/3vDXJ/McBySoTqVwECLMhKYWlZ9iPDsA=;
        b=rqH8M4Vgv4klX464W+sNrR6gyFvMMM1gPtXtrfvoHjcof1nmCsuX171gfbv485iNmX
         mJ7vftyX5s3Ki9AlAlaD+fmSC5MRUcqXig15qq4sJQSm0nJSH8/DT8/5gSlUMMmz0x/w
         4S1Pjyfj78Va25I3O1sgCCnnwQHoPXfzfAIB332PDZ/o8waI+jL/o0rDoU607aKkBxFW
         nKlgoUc+W5p5Z2E0gxDvYv2nwqkn1RFPBtDWlpzQTDIGkXPLSREzNLk3Vjq7bC+vFa4k
         e2OCKs9Bki9+YBgWpn9jv2/kpMd/BheA9IqKfEl5tFCK9q9wACTZfTR0C5bUgGI/5cKc
         zOUA==
X-Forwarded-Encrypted: i=1; AL+hErF5/l8q6pkshli+SZnSPb7kzko+dBA632WiCV0AXm+/qlr0kQ2njPmxlwWpDPMZdDNC0eHGctwGzBPf0ZohmA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/k019KrwqNWFfkMeGLJ0ehYG6SQj/jlCuBhGDUl6MFb7EIaW5g
	8r2Qcn9VYlmigene6BRWZkSP55j1qcMjPCQFe8Hj/gfQVcqDpEcRfESA
X-Gm-Gg: AYBFou2ZE1HdwD7dAokGOEP3e+KfSIhNUPmzGUPapJSYYyp5+jJZAV/VOMvZfcYNeCy
	/XeOCATb/u5+sfwi12OGFos6QMJqK3RZm2KGirynO+0bw4BjZYeyerv9fHaUvP40PIgvw4GnRPR
	4ZvjDckTSHMoG/RWVMesawH5aydJyS9fENiYdMgSAwduc2tCTJrKb+c7/DDDNKU/faS88qnGal8
	SRmS+ybN0ECrU2MZjsFgVnMragl/ZJ7s62R9OE7rHRA13/3OyRcET0bvD17K6wwQMZlbgigFihu
	dz7M1LIoAIDrfvsmh5JJqgunxzLz0zeieRnUxw5dkooJT8NGfEA5Ko9IeZzGw1rybKrP9jmu2Se
	sBCQDU6XtHb/vEqHuhnlHcBmz6ZrL4yPHgh1zUA0jefX7hNM3X6Q78Bbb3YH8mzf5O78Te3ImLp
	g+jld7I7ZrvcWy7s0E3JR92YmMY3NmWbdSdiIa5XWu4pHchprQVET+GHHFnAbPcLiFQWESmd5hU
	jD/SgDdK2/NGTBMTtGBsQxPBEl8RJpS8j+Higxbeft+hhghaClXKxiKpVuzt/OEQsNkinFzgNUR
	kckuFLb9LZAGQsXI2bc6oUC8iNtyTslKDwVqT5BPt3EeRf+Iy1eaG0WElaJkj9cObLmBKKCXIva
	UCBz0HpSGVw==
X-Received: by 2002:a05:6512:3d8b:b0:5c1:52b1:ef8f with SMTP id 2adb3069b0e04-5c164eb3172mr1490770e87.31.1794528917830;
        Thu, 12 Nov 2026 16:15:17 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133ca01sm200968e87.36.2026.11.12.16.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:15:17 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org
Subject: [PATCH 05/10] openrisc: fix duplicate extern declarations
Date: Fri, 13 Nov 2026 04:14:11 +0400
Message-ID: <20261113001432.128201-6-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113001432.128201-1-safocl88@gmail.com>
References: <20261113001432.128201-1-safocl88@gmail.com>
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiling a kernel module with a C++ compiler results in a duplicate
echo ‘extern’ specifier error.
This occurs because the code contains , and
expands to  when processed by a C++ compiler.
The  specifier must be removed.
https://bugzilla.kernel.org/show_bug.cgi?id=222257

Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
---
 arch/openrisc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 73ffb9fa3..c46899806 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -129,7 +129,7 @@ void show_regs(struct pt_regs *regs)
  * Copy the thread-specific (arch specific) info from the current
  * process to the new one p
  */
-extern asmlinkage void ret_from_fork(void);
+asmlinkage void ret_from_fork(void);
 
 /*
  * copy_thread
-- 
2.56.1

