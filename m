Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081216;
	b=MTF1BWImJb2u7P71SEmv522WV+TWqA6Rp+RLKK0RGWUCAf2PkVFhov5pRS4uZjhWtZdy
	 qnl1FmF4rtSbZoIXQhSCuQJ79En4UrPKuWsUySkGkRTQP4eXRJInRgyW7oKjnH2gnF7EN
	 eaoXGFG2vASDXkqQkPge3g/EIJe7gs36wAQIqDku5RZCrB6kVhWIelcJYzMt98mYlEJue
	 9pyANtsYZBRY0dhA5SHF5mHn9b/merCaJJmjc1d62SrSOCuhZsa9cFSLMN/HF3GEd76he
	 peWq1bFAXt+frBMH46z+ra8DnCPZHJxtoGaCHUD+pEBcLOV1EgMHG6OnBJpJSdckd0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KuiadmeaNV79Rj+8DVzBFrgmzZdpeP3C5b3GRz6kOUM=;
	b=q22jwfh6qANRTdB4jNCCTf3OmkwPMcEAB2m8O4gGscFxQqwFP+XWvXYr4Up+eV1gLPLn
	 UZlGSqAlqCgPV18JIhBwiu3AfLSslLB8H9oW+D7YuiOu0oFwqNQQd2wjBw0ZqZqZL8z0J
	 bFKYA0Kcq4WWDiJ3RAvfam+RQtpwA47kY0WYlxyt7r2pONsCXs0wpMbdPUA5u6dlYI3wI
	 s4BbX3m7jDZnTbSJ1gXv+lJG4VnM5BDTmNh5S/hdHlGufXv+EhuEK8pYpzsJ4OT8+WFVU
	 m2rbl6i5X802crAuYUtF3STtr4fRA8RMeuQfpcm9MC294pxXrlYn0vnlAadJL1TDJ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="R1rPImR/";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393C606A32C
	for <linux-openrisc@vger.kernel.org>; Sat,  7 Nov 2026 19:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5393C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R1rPImR/
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so147215e9.1
        for <linux-openrisc@vger.kernel.org>; Sat, 07 Nov 2026 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794081215; x=1794686015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KuiadmeaNV79Rj+8DVzBFrgmzZdpeP3C5b3GRz6kOUM=;
        b=R1rPImR/+hJNamfFnngHdumA3tTY66dSSaQHLBP+lLHTmTRJDgaUI7oTYc298zR9UA
         +alXhOsc5puOG3VKJWdxan66/lCQXD7dHBNKDRmjAVSHvy7HsdSvl5vLdlYrYE1FG/qi
         BZUaAwIJ3awGgbAvvO+Q/Ii1l8fLX3g3Z2I4fbeknsUrjYlgDpSCA+e0BYkQqoCjBoIY
         7QZklZMK1H1yR/+jGU+7qb5PTnbBHl3ifn4PuZwKR9WzDkpBoazNal8llgS96yq55TfP
         +8ZYrsYfoe11uPvkRDpcY2divxh3dnCKE/j6jVvBigx6EjnaIsWJOB94BhhGgluui1nI
         UnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794081215; x=1794686015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KuiadmeaNV79Rj+8DVzBFrgmzZdpeP3C5b3GRz6kOUM=;
        b=XOb9/Noe8oiRTCEHls6ZXT0QK8dI5SHq/PCmw04/JcMdcxW7Zq0sTANsZdpgGnVsTM
         nW167PgoP987Tw1aSK6SrqYxJziOkzdu2i6XeSbJFPKX3fKo1V4BiKbx3aaFDuh/+pUu
         u/IPh49nbrDEYB5Yicu/3hdWW5KlQiuLXVl0BijQ7UF5Qjtlfv9kEFXQa+g9uy4+WtjY
         vkMAPGcejdiyAovEwrv9rdtw9UtQJwabc46ooXd1MxIEb5mpcJg6W4wcAtr3Psy8Suew
         WF4HhiEuYCGEXoo2eCfvtbdBfYeHWoVsX57idmcgm/H75XZJlGXrn/Klh+WcPgV52AH4
         j5nw==
X-Forwarded-Encrypted: i=1; AKwUvBx2dE/OMcm2S8X+seqHAK7pH0OJf3h73fO2irtOClNgrteDeL7ex4jTQuMhRG5Ghw1vuC0J3M8rGqUDnJOpnQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+CLVExlXSEuadVrIvMJQTNb+q1VQaynl++7XngG0mMsjoqyErC
	+6bTqv4X33ltSYlN4fgXl0qT6Dmrwp4tyhiSaiFT9wAe0siBsLiS5ouD
X-Gm-Gg: AYBFou3eEjizsXJ6x7MxZb+Ku1dBASxRVT6JAtWMVhgv/CNTTELjz61J+3wbFQafKGv
	HbrX+xg8c0Ge3jR8Gn78UqkJZGyr5YE08smJlXFetAh/YJZSvzmnRUK6TtxRcEhyRigZjFfj1YC
	aj+NsycF10HfYSZyzwgJAGMtdXvv7v1G6PfquwjrS0uecYv6KMUFwViNxBR0ISQOK9fA+3nKfJv
	7hq7iIIvm0H25IcKGfXSo6mUMGdZpcBikHS28a6dwiY0TxQ3GiwkcliCO1gYRpccJ4a9X0/LNTY
	QKH+iEsrzo7i0AZpGg25MQ1sDnX3EVGWrCbIMZ90pIzRoQznknDcsnvsZuTPkEc85MwPbbb5g3m
	KfeZYxWEDWY1OjAOUIJVXwWRE+4NCR5vFoc3tCHg6avmMIOOP2ofDIoi7HexoAMeOxf9NHBeJsl
	7jsTYD6PA3nNSkMhe0fDf/d1xKHKmnic/hWDEdG+sYb8lNsPiS1DFNPVo4NjowDxC2lbvzRdEI3
	MV4BUpZlCBUovb2YGgja1NW6LN3wewPm/iRel5HuNGD7RCIM6bTuCqEiWaQXE0e7e/EQvtlbx/a
	uMa9D9lvrut8ukrhBGvnokUdqHiw7Acve+UqNbQus6jf7Hgwl0qQWVjRKVr5mb/LfrYc3dCA/l7
	A8gCc6IMSq0KiT9BQhJullr5QweV5N70nM3RALFQ/9/8LTmgxselVDmCwXwF7otV57AH1MBJRoG
	UNLd+yCzxr7j/OXtpIga2Jan03F1ZUiIw=
X-Received: by 2002:a05:600c:8115:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4b8190f468amr51908545e9.7.1794081214606;
        Sat, 07 Nov 2026 11:53:34 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90619bc91sm3536595e9.2.2026.11.07.11.53.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 11:53:34 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] openrisc: cacheinfo: Index cpuinfo_or1k by target cpu
Date: Sat,  7 Nov 2026 20:53:25 +0100
Message-Id: <20261107195325.70635-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_cache_level() and populate_cache_leaves() take a target cpu
parameter, pass it to get_cpu_cacheinfo(), and then index cpuinfo_or1k
with smp_processor_id(). On UP kernels with PREEMPT and DEBUG_PREEMPT
enabled, cacheinfo_sysfs_init() invokes init_cache_level() from the
preemptible swapper/0 thread via cpuhp_setup_state(), triggering a
debug_smp_processor_id() diagnostic.

Index cpuinfo_or1k with cpu in both functions.

Fixes: 4e6d24a309e6 ("openrisc: Add cacheinfo support")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Assisted by an LLM.

Tested on v7.4-rc1 (d48723711bae) under QEMU or1k (or1k-sim) with
or1ksim_defconfig plus PREEMPT and DEBUG_PREEMPT. Without this patch,
two consecutive boots emit "BUG: using smp_processor_id() in
preemptible [00000000] code: swapper/0/1" at init_cache_level+0x28/0x1f4.
With this patch, two consecutive boots complete without the
debug_smp_processor_id() diagnostic.

 arch/openrisc/kernel/cacheinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/cacheinfo.c b/arch/openrisc/kernel/cacheinfo.c
index 61230545e4ff6..7c2c38beecd99 100644
--- a/arch/openrisc/kernel/cacheinfo.c
+++ b/arch/openrisc/kernel/cacheinfo.c
@@ -28,7 +28,7 @@ static inline void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type typ
 
 int init_cache_level(unsigned int cpu)
 {
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu];
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	int leaves = 0, levels = 0;
 	unsigned long upr = mfspr(SPR_UPR);
@@ -83,7 +83,7 @@ int init_cache_level(unsigned int cpu)
 
 int populate_cache_leaves(unsigned int cpu)
 {
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu];
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
 	int level = 1;
base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee

-- 
2.39.5 (Apple Git-154)

