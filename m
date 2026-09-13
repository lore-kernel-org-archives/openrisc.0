Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C93A782B
	for <linux-openrisc@vger.kernel.org>; Sun, 13 Sep 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789283012; cv=none; b=muYAyxkF/hesp3F59o0d+AqwFbNKuFPnlSI1V4TQAGT4B4YHke+ocR6xzQ5z+hcHih4mXFDXdPgZtL8fmijj/udVZ237PcWd15DBBRwJtI4/PFj+MDjhWXWFfVK28V5FiLIRpf6zb3mHaZFRlElvghRrNPmq7cqVrsjMUjLx0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789283012; c=relaxed/simple;
	bh=Bry40ijOWx0NwGvhaRAkAP0QfsiNEAPPR3etJv/AbL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szf/CeL2IerufxT/aWRmXMR2QK/RdDZOKxEI9jRUNrzW/94aKsdZT+JRFm9BAxdPUK8sQfKng0E90GxjRovCUqMpXUmKNFnK+Y3LWR6rp24t/KYDcqYBHot6iNlMCrQ//5VYBwEMnFW3o2hU1l+FBwK0htnYX/VWe0KJCKyrfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGOGdyde; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGOGdyde"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso10035945e9.3
        for <linux-openrisc@vger.kernel.org>; Sun, 13 Sep 2026 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789283009; x=1789887809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G8Yi8RLvK+tUbuDO9IzdFTX3o4OGXx9ityAEIiXj6y0=;
        b=rGOGdyde1YelbepNMO36pu2Dh9gluONDi7PD5QwEfE9uAme3pdaWsLxoyyPy5pJPg5
         /Z0+xzo4V7dB8mW84+5++jZ3ZUYJ3hsQVZ2ydqwZqKuiPfF7oc/H3/FNzqGmw31CAC5n
         0rO6WC0f9UJEIlz+NAlwXmjUtfsd5ftdQWRHXVjK6XBGTi6EbSsMvYLwinus5a+WEPBL
         XYrjs27K22dGcg9lEvpRVqLyPVd5KBjEA+tM+3h5pjPmggT7va2poqL8uSlzJBAK8gdF
         711h9sKDe6yFc14JP292EErkSpNssQWhrSFfS/nhVOyEyZu1VBrX2UPv2uBM5y6HZLMg
         tIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789283009; x=1789887809;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8Yi8RLvK+tUbuDO9IzdFTX3o4OGXx9ityAEIiXj6y0=;
        b=fDbggKPTqm7sOb4GSiH8+v9N9t3ejzPweGe+A8HKl97beq76xTAADgcqRxGlsDh3c4
         mys9zR/5KQFS0um4S5iM2HWByVcUKyio0t9hCS6rZ4XddseqcPB4sv/M9BYxw1cHFskf
         goj1ucu3XynCINhYW8vtHJEAWv4TV+uPGyuGKMLAK/3BRuHCqy8/9RwKVXxaMxm1QhwL
         pBLXWRxWcmy5xQnyo16UQS5CwJ53U5IV16VBz/vv3uA7pa7kzKzQDgIQidyBgXCLLYXO
         m5X0LdBJZVphHFl+c6/0NNe94QbZNtdkVB7TOv3IYijaV53/R1ISUulz77Iry3+Nj4XD
         6Ckw==
X-Gm-Message-State: AFuF++m+OW2RKUWvAQyOv1EXzSAvW5LYQ3rT2Kt/Hls73mbSrAcj+jFv
	WHgM1veFrr0kFEHWTf5WvgeKkKWtUMZrAN7+wHf4qsjTRJf4Klbc/9G2
X-Gm-Gg: AYBFou27eUk1lQqArEamiezEyAmK+77Y/eboEh9md7mpXYwcaIH1Ld9sTuXzXwT4wYh
	3GbQoII3FSfpRurizXFiU1SUdrjDbkw9JJuxm7lzBP/55ri35NTwYYrdCyOOTSsXnvipUDNJOpo
	eR6yH3y2ecjVEkWC5OvTrZnz1FDUEYzKQyNJi6D81dlR0Hb5a8sIlbTgT4nk26nh6bmF6IRW1hN
	7Re8eG+XtUHYyZU2f3feH/Gbo1w7XNHs1UIKKLdiIfAJz218r7Hda69SG6nu2okwjihF0jsBQ83
	si8CFIppqO7pqBQ86QnarRFHECJNt6cZa0G9vo7lhcehmLQhz4JcVe3q2KDKtFJrLcCUO0kd5cw
	6VIT08EvvDMoGsSfM8KP40mJPxn+Ugt9b+J/mtalYX6Oi4jOeGPBaMao8gSnWd/BPu1QSDAWgyu
	ZHIMZ6vai3IEkczWTBN4UDUyJ8s2KrXEL+Iir6yebv8sy9Zl0zuRGDi0d5v0Fb4BbWIFOlOGYll
	KsS+svJLZZpqH2TR0SjGrfuI1mowhmbteZnQTPcit7IqZ5L8hak5w==
X-Received: by 2002:a05:600c:b96:b0:49d:1916:59c7 with SMTP id 5b1f17b1804b1-49e619831a9mr124044645e9.7.1789283008310;
        Sun, 13 Sep 2026 00:03:28 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm328384495e9.15.2026.09.13.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 00:03:26 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <ali@iusegentoo.com>,
	Stafford Horne <shorne@gmail.com>
Subject: [PULL 1/1] target/or1k: Implement l.extws and l.extwz
Date: Sun, 13 Sep 2026 08:03:03 +0100
Message-ID: <20260913070303.1010504-2-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913070303.1010504-1-shorne@gmail.com>
References: <20260913070303.1010504-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ali Ahmet Memiş <ali@iusegentoo.com>

l.extws and l.extwz belong to the ORBIS32 instruction set, but the
decoder has no entries for them, so they raise an illegal instruction
exception on every CPU model.

On a 32-bit implementation both are register moves: there is nothing
above bit 31 to extend into. Implement them as such.

Found while writing an OpenRISC port of Valgrind.

Signed-off-by: Ali Ahmet Memiş <ali@iusegentoo.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/or1k/disas.c      |  2 ++
 target/or1k/insns.decode |  2 ++
 target/or1k/translate.c  | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/target/or1k/disas.c b/target/or1k/disas.c
index dc025bd64d..0a46d68d30 100644
--- a/target/or1k/disas.c
+++ b/target/or1k/disas.c
@@ -71,6 +71,8 @@ INSN(exths,  "r%d, r%d", a->d, a->a)
 INSN(extbs,  "r%d, r%d", a->d, a->a)
 INSN(exthz,  "r%d, r%d", a->d, a->a)
 INSN(extbz,  "r%d, r%d", a->d, a->a)
+INSN(extws,  "r%d, r%d", a->d, a->a)
+INSN(extwz,  "r%d, r%d", a->d, a->a)
 INSN(cmov,   "r%d, r%d, r%d", a->d, a->a, a->b)
 INSN(ff1,    "r%d, r%d", a->d, a->a)
 INSN(fl1,    "r%d, r%d", a->d, a->a)
diff --git a/target/or1k/insns.decode b/target/or1k/insns.decode
index 0d6f7c29f8..cbf8af7f8b 100644
--- a/target/or1k/insns.decode
+++ b/target/or1k/insns.decode
@@ -112,6 +112,8 @@ l_exths         111000 d:5 a:5 ----- - 0000 -- 1100
 l_extbs         111000 d:5 a:5 ----- - 0001 -- 1100
 l_exthz         111000 d:5 a:5 ----- - 0010 -- 1100
 l_extbz         111000 d:5 a:5 ----- - 0011 -- 1100
+l_extws         111000 d:5 a:5 ----- - 0000 -- 1101
+l_extwz         111000 d:5 a:5 ----- - 0001 -- 1101
 
 l_add           111000 d:5 a:5 b:5   - 00 ---- 0000
 l_addc          111000 d:5 a:5 b:5   - 00 ---- 0001
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index eb4485312f..e00ef45b9b 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -502,6 +502,20 @@ static bool trans_l_extbz(DisasContext *dc, arg_da *a)
     return true;
 }
 
+static bool trans_l_extws(DisasContext *dc, arg_da *a)
+{
+    check_r0_write(dc, a->d);
+    tcg_gen_mov_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    return true;
+}
+
+static bool trans_l_extwz(DisasContext *dc, arg_da *a)
+{
+    check_r0_write(dc, a->d);
+    tcg_gen_mov_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    return true;
+}
+
 static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-- 
2.53.0

