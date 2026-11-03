Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720477;
	b=uc1fGbj/wkKHxuPSiRNrFAKn9NZz1Yiinep4MX/rspcVPWby8zqOoTEfY+jMa37o5lwu
	 lAXwQqZvT5PLBoA1JsbKCtgVXS1fnQzRnHSs72/H2c2TgEk16dsBggJrsZAOVjUA7D8Ch
	 V4QZKmqSUSIjmAKkGIPRu+gvab3dDhCrcK7j7QCg+Hz+IJGI+0qJiBoW9M9Ljhe9Ira2U
	 kw8nA81tvxU+V/f3ddxigkDe5Z1nZqr8PS5g2+iS9Cl3XzvTbl40vplFWK+/Pk3pfjMhA
	 L7JV1hmUh5maNc1n3SaPDbsijTrsaHBi8X0UykJcj1XwVzUfalqN30uKU7UC/ZZw1AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720477;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=vsQFofspZRzk40ipdlLM8KlWm4fLJHpUFJdLUjZvn1Q=;
	b=iaBXXMONNDoqUwuwiSMQJjH+d1OnnITsQMVEifPIce4vDqzRayTm6vlxWROBd+Kwkog5
	 WZNgAfTZgTU24c2enhWcac16dOc3ngI0mQ/5/NEr1jNbTv28AV8JtEr6UCwTkYcNDLJI7
	 yF0n/3eZmHsK4eNY+sUsHlWb560V+4AHpJLaXIaqxMPhZ+1sBSO+8bjSLRv+12d8IMDvW
	 Z86puWKt5zLEtr5zn7+revRLJW3RzR65ehTbbyyySheHwdxyJUt86/wtTlyKbblOSjGdC
	 SsR/tZf0tJMKIe3TEzT8Z1eE3iIJkYbEwZxYHYKTrVKZtuFqvGdwjlNTGxDsyitrDTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b="fCCgMgu/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FCdgSzAo;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC4606D805
	for <linux-openrisc@vger.kernel.org>; Tue,  3 Nov 2026 15:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74CC4606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=fCCgMgu/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FCdgSzAo
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CBCE1400120
	for <linux-openrisc@vger.kernel.org>; Tue,  3 Nov 2026 10:41:15 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 03 Nov 2026 10:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793720470;
	 x=1793806870; bh=vsQFofspZRzk40ipdlLM8KlWm4fLJHpUFJdLUjZvn1Q=; b=
	fCCgMgu/PFV6EUWonGEwC8831RIZO+MkSOuuFJwhZZGKnMLzKKNZkM6sAqLUTMGM
	J6BKsyGFWP9OWmHGZS7GlpBvQWPJC9AzX6wUuhZBMUBv+gqUiHSWwt+VRhjdpJ8k
	aDmiKd58ugHAlGMUIq/UOIGAMLyuk3Pg8dCyjczNU3sy5+7/oThiBdP+i5Lp2o71
	Dcb0zHTTachtr1wi9HbZrCe6jCXzJVobUFausJ4YfWYybZDD30qlS/2u4eAogJFE
	RMvA/YZEpXsWV8Wgt9H1vI2jR5qgT+n7vVqcP3wDjue/zSh70pqkz/I+ZlwszPgr
	THdSq1As2ZTmKRrxZLQiXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793720470; x=
	1793806870; bh=vsQFofspZRzk40ipdlLM8KlWm4fLJHpUFJdLUjZvn1Q=; b=F
	CdgSzAoVszCc1dh6O6k1MmMQbXRVX492YrEN3ZpU4fquRT4KXNnBkAXOtGFE5tvv
	K26BXyHme85djG0Z6qWIvCgIbPJtdBtWVz4FHyk7yFeQI6nZihPcOfmln/UPsafa
	uQbyR355n42kGlhp0s/x78VoKQ9OMZLFPuq7NklB4MgvTBDoSxW55m/9LYW9tFTg
	LrqGTRvRye/mt1rpqhNlR2gVl4P/XVrCLYq9Vj6aO75nXj8+t4teaRt/egniZX5f
	2gWEW6etXVunv/kHGfzpJhw0Hn3cGU3wuxalVUeiSQwG8moGAqFcXFdgvdUvdT7d
	Z1S+ZjzegDFecaq5XftMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793720470; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LW9wZW5yaXNjQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:XHno0zPtfKhMdh4d0ll8NCEJMc2eoX2m0s+j2dpkikPPgid
	QO2o47Yrn2AHFsBU7bFAEPz8wq/PFgukentpQ1mGYM5exPsHfUXyn6iNO2vmlZtw
	rSWp37OhGkvRfYF+3vNBvBTKgUYMl1cc5XswVnH2QFkmbu1KGh2w5R6Db1OnQbZO
	2Mbf4B68dAmZLuEeLfWUS0UfGBBn1JoqppeCNBIL4vvWsCcR5PmlrXZGQURYArV/
	fpD+UnUby0LYaaSCqwZc/DO4im9gE3QfxmjKqdK4KbTcD9WYSNKYONTmhZKgZWq8
	Rqu8OCjRdkDf4qK+wPz/mLzqz5pTJlegTdbdYbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+NWiOqGKKccQwgcSM0d0rA2lmFRuMIUa7TCXm4/1/uQ=:buy5zeLPnDvnLZdgeU/A0CcqsYuQQHjKPVAaJbKx3TY=;
X-ME-Sender: <xms:kQDqakuwaKyhh5kd2Au33N8Kb8D2IkiySk0JcAjkK5gHjlK6mw5L9A>
    <xme:kQDqasRFqeE5Nsv9fPFb202XgstUXQr5dRZ-hy2jcwO9TP8X9uTqzlzEiDTHqOqZi
    LqBbh6M_tFiqQFPbDjyHS0XUhz7q-rjko8OvNqLpaWXsdWZFZ7IDNhb>
X-ME-Proxy-Cause: dmFkZTEuSIdaKfDtmerGFpK61jkKBUQR+2KM+zzEwIoTAEcvMjO2VtaJG1wy2FCgjWNI7U
    OTn/F7k59JqVo4bnbx3oQFc2VLo9nptgQWZZCHY0yPkGYAK2hyimQTLbI03T/5pBKlU9cA
    7oFrzmnGIVKGOJKSSxMZnL5XhKX6aXAvPe8lxuwgFbqbL8rbeHPBY0XgGZbRtLOVX1nCD1
    K9fu4eDd2UFdpxNUWYp7HMpcP/O1C3NbpZr/1niufdHV5cQ173ORQR8U8Oo6lKku3HF2C3
    e6D8jHxOqJLxBAd16nFuHKWku1nb2Nm2QeFVjT5B/+s3D5Egw9f4wBYh5Zk+1Cod8+JpAg
    mNMX9Al5gWbRHXVPwCJ4qwrR+daCZoHPaI+ZHKoipVg6GByHu5sRMYZDSSHUSXWd6r8mGu
    MKG4pabXrNMgSdRPL9YiaaD6zzGlbXarBXz5fGCYbgFaULx5D2qjJzckHb1Fc0VvxL3tMh
    bbeINHka/WF66nhmVmd0zqlRYS2W7sUZpid2+pmUvH5vq6GsamsAGvJYy1RDN+tCEdLDFA
    hifzUsJX3bPvld/8bYaBZBn3UDCV7Zwd9fllFmDs9vATUcpBJw4mKnroEGLw8q91N/IjRW
    l5S+dxgLmaunrwQhYJiQGRf5m0tUTLQaXBgt3pNurvGrQocJK2XL+sYaam3g
X-ME-Proxy: <xmx:kgDqah5vVJgv8UU_1Yrw8c2OG7anA0u6RUCWD07pOCZRdoM51hO1Ng>
    <xmx:kgDqak67cgRPEuzcN2m4GOrx1TG0x91UOSGxmuAtIY5mP59MKtIlMw>
    <xmx:kgDqajQ9ytx6bqBqoWWMRt0Kl50jwmizE5gqriAxEO9cDVWFjYyrEA>
    <xmx:kgDqas_XevsPRLLC2AREMU3eZX9_hXDaeFQj115QMCAYngjsmuknfw>
    <xmx:lgDqakQueb8lUz2NJ2YFbAPXCzHPBhmjpEGnTQuQcX8LmDYMVHQ9rIie>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0971732A0093; Tue,  3 Nov 2026 10:41:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AqdVyRc9R-dg
Date: Tue, 03 Nov 2026 16:40:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Sasha Levin" <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 "Vineet Gupta" <vgupta@kernel.org>, "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>, linux-openrisc@vger.kernel.org
Message-Id: <b289ed06-4d9a-434b-b3db-b7e38dadbb58@app.fastmail.com>
In-Reply-To: 
 <20261103-nios2-remove-usage-of-libgcc-v2-0-5fabbedc49ec@siemens-energy.com>
References: 
 <20261103-nios2-remove-usage-of-libgcc-v2-0-5fabbedc49ec@siemens-energy.com>
Subject: Re: [PATCH v2 0/3] lib: Add software mul/div helpers and use them from nios2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 3, 2026, at 14:30, Simon Schuster wrote:
> Recently, there have been linking failures on nios2 regarding libgcc
> symbols that we reexport to modules (in particular __mulsi3 [0], and
> __divsi3_table [1]).
>
> In the resulting discussion, Arnd suggested [2] dropping the libgcc
> dependency altogether, as -- while specific functions might be fine --
> libgcc does not expect to run in a kernel-like freestanding environment.
>
> To this end, Dinh Nguyen was kind enough to locate and extract
> GPLv2-compliant versions of the software mul/div/mod functions required
> by nios2 gcc and integrate them into the kernel. As Arnd also suggested
> [3] that these might be helpful to other smaller architectures (such as
> arc or openrisc), I've further extracted them to lib/ with corresponding
> CONFIG_GENERIC_LIB_* options that allow selectively enabling and
> exporting these as required.
>

Looks good to me. I'll wait for Vineet to comment, as he wants to
use these on ARC as well, but plan to merge these in the asm-generic
tree for 7.5 then. I also tried the patch below on top of your
series to make openrisc build without libgcc, which worked.
I tried the same on parisc but failed because that one needs
several extra libgcc files.

I would have added the __divsi3_table symbol to lib/ as well for
consistency, but there is no difference in practice as other
architectures don't use this, so I don't mind.

> Furthermore -Wno-attribute-alias -Wno-missing-prototypes
> -Wno-missing-declarations and -Wno-unused-function were required due
> to unrelated Werror-related compilation issues, but as this series
> concerns compiler intrinsics that are never explicitly referenced
> in code and it links fine this  seems acceptable to me

It's certainly worth fixing these properly rather than turning them
off, but I agree that is clearly unrelated. For most of these it
should be sufficient to either mark functions as 'static' where
possible, or include the correct headers, and both of these are
generally good ideas anyway.

      Arnd

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 6aaedc67a5e0..5be29befd86c 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -22,6 +22,16 @@ config OPENRISC
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_LSHRDI3
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_MULDI3
+	select GENERIC_LIB_UCMPDI2
+	select GENERIC_LIB_DIVSI3
+	select GENERIC_LIB_MODSI3
+	select GENERIC_LIB_UDIVSI3
+	select GENERIC_LIB_UMODSI3
+	select GENERIC_LIB_MULSI3
 	select GENERIC_PCI_IOMAP
 	select GENERIC_IOREMAP
 	select GENERIC_CPU_DEVICES
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index 68249521db5a..38dc87bc6a3a 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -18,7 +18,6 @@
 KBUILD_DEFCONFIG := or1ksim_defconfig
 
 OBJCOPYFLAGS    := -O binary -R .note -R .comment -S
-LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 KBUILD_CFLAGS	+= -pipe -ffixed-r10 -D__linux__
 KBUILD_CFLAGS	+= -msfimm -mshftimm
@@ -55,8 +54,6 @@ ifeq ($(CONFIG_OPENRISC_HAVE_INST_SEXT),y)
 	KBUILD_CFLAGS += $(call cc-option,-msext)
 endif
 
-libs-y		+= $(LIBGCC)
-
 PHONY += vmlinux.bin
 
 vmlinux.bin: vmlinux
diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
index 84a937a64e2a..7ae38030a9d4 100644
--- a/arch/openrisc/kernel/or32_ksyms.c
+++ b/arch/openrisc/kernel/or32_ksyms.c
@@ -27,19 +27,6 @@
 #include <asm/hardirq.h>
 #include <asm/delay.h>
 
-#define DECLARE_EXPORT(name) extern void name(void); EXPORT_SYMBOL(name)
-
-/* compiler generated symbols */
-DECLARE_EXPORT(__udivsi3);
-DECLARE_EXPORT(__divsi3);
-DECLARE_EXPORT(__umodsi3);
-DECLARE_EXPORT(__modsi3);
-DECLARE_EXPORT(__muldi3);
-DECLARE_EXPORT(__ashrdi3);
-DECLARE_EXPORT(__ashldi3);
-DECLARE_EXPORT(__lshrdi3);
-DECLARE_EXPORT(__ucmpdi2);
-
 EXPORT_SYMBOL(__copy_tofrom_user);
 EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(memset);
