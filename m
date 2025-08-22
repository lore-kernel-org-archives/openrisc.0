Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055E2F066B
	for <linux-openrisc@vger.kernel.org>; Fri, 22 Aug 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871180; cv=none; b=ZIZCW1LThRjI2xn7q3mPr/hN12ZogxoUtos/mj1o+7MAj7kJAT622+iPveYynHYn51X+O0nOOZRH1B9sYexyb4h4IvgkxapTflfBJQ39X+9TG5KssPCSo0l4bJzmCzU2pnP06F6m1ASq0zM8XRf2iwg0lSI0y2uA8zO/cRbPsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871180; c=relaxed/simple;
	bh=Hr/iu65GFENGLZy92IKRCfatxrU5Nb412i7sxtWQcD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a/PbTMX59T4P/ewxCnpQY0wrme4VcXQkfIfB5OvlYY2ICIilzwfQ+2mfbNKfScKtRytDESXLhvL9mr7sMzVAgAC4VrLYX90v1kV0Q+FSvPa9Rak8TPPo9hpBmUYAHq8NVyV50vx3MZRHPqkniNIl20r6uXLR/uZJO9stPWpmZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=C/8MVUkc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="C/8MVUkc"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c6df24f128so72221f8f.3
        for <linux-openrisc@vger.kernel.org>; Fri, 22 Aug 2025 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1755871175; x=1756475975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XxgOKL4V7HaNjiomYQoDvLRsCs9DjqgsvWTf9O5MmYk=;
        b=C/8MVUkcydpg80yZAMXYfbWjH5RF19mzuMmOP8FIXxPLTtQ0lXBLQbZldX0I3HVAtn
         cQjYXriwuBt7T7SxFS4TLKod0TYHbiTXLiZ92izrG4E+nWjpeqGGjNMRX1dHgf7hMUZl
         Ec+y/u4HmzhQXXUEY3aWRyUCfLs6smbOGD41pwu1vA9D6z9LGSH2m6hKzrucEFwXb3Qu
         ayW8V0IGuZefGwNHaUo10pIIVNNjZuWVPKL/KuO/7nwacN8MyDK5+ds+znDxkOPlpBvR
         pB/IJuhguSoZ+VKU30TjQwydKPomQ0u2gRmJo+7dkreQtCXNFyAA3O+jzRjGlp0GVcR3
         U+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871175; x=1756475975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxgOKL4V7HaNjiomYQoDvLRsCs9DjqgsvWTf9O5MmYk=;
        b=sP4xE8mhAY5PAVhRbhLQ26JU8Dzpsj7tJo7srhs5HzIk9K5BAThZEAgAlbhw4mslc/
         gdlYLl0iVje8FMxtYqCv2GWf6s8ia/rZTntqI4jdwo7ZftEH2Q57jOrUJF2/9yRucVYH
         5FKYce1ANN32xUZT6eGNfHekAHZRupwDUTdw5SeWmJvfFSH3BaWRBHE+c4IPkHmuw72a
         X+XeM83WHrBnKWbpyeS60/oR3EeLNxR8MjZFgSG44x/8v3m0OB6eOLFPKxZ/1UQYcBRA
         Qghah+ufa32wsmvVa8Dv0JPEMXf78wUOZr++9xjmpxtDtmWubUEDjlLSdCfPZheCP/C9
         g5AA==
X-Forwarded-Encrypted: i=1; AJvYcCWN28Q9gLHQ8xgWSGrqIClCiDomiEQRT9sZ663V89ImKAeoZbOt4XPq13TevN0VbhBDh3g5GnmVDQjYj8VuAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqwsWK1VHIOXdHWxFG6qoG6Qrd9N1ijsS/CtJxaxCdnQ+3JwY
	jTNg+XeeAvH/uyreEpLVUeOLsu3LOYJgDkeA2j7m5MYiEVJaej1EVs66enil0dv2e3E=
X-Gm-Gg: ASbGncteBXtrEr3eb0AnOt8dujFiY/jz/ZQBgSNhhShc9ULCqWHwzRuk2zEb/ijrxRz
	oe/euVdS8fNUv60oStWdux0JrHoyy0ni8GB2ZetrblVFdzBSOXerrMe6ivA6etoEoVXxtGKAJOQ
	vKTdX2YAMdYX/Wh5Hs9JMKFx23l2XlfHyZBYLJn5aqoe2K560YN6p6SYaj/s0iljkFXMrSNnepY
	R5HgYRziOiCEQuos1G21n+09BuqM3muhe9L4m4/uLq1VlN6DZ+RtE7LSL8MyfAdrubPS7yKpwVX
	MBrI83k5Huy04vW6bToJZg8/0A8hPQjrQP6wBqUd7rco0LnDlvwUfEMYkQ6pWbjajCvwq7zWwpk
	bW7m4CacsXpOlek/wnsbuaq4wQm4lA5bq/0s6/sCGqutT4nU=
X-Google-Smtp-Source: AGHT+IH14xUXTB2xUpzagKeTUSIAJrf68FsVnzXIgt0Kf2N65wJGH1EcVg2HS0/a0CHpekjnPUnHAQ==
X-Received: by 2002:a5d:5d0b:0:b0:3b7:9dc1:74bf with SMTP id ffacd0b85a97d-3c5dcdfd46emr2336721f8f.35.1755871175098;
        Fri, 22 Aug 2025 06:59:35 -0700 (PDT)
Received: from cephalopod.i.decadent.org.uk ([2a02:578:851f:1502:3474:c4d4:aa9e:144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4ccbf04fasm6086825f8f.7.2025.08.22.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:59:34 -0700 (PDT)
From: Ben Hutchings <ben.hutchings@mind.be>
To: bpf@vger.kernel.org
Cc: Ben Hutchings <ben.hutchings@mind.be>,
	Dinh Nguyen <dinguyen@kernel.org>,
	linux-openrisc@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] nios2, openrisc, xtensa: Fix definitions of bpf_user_pt_regs_t
Date: Fri, 22 Aug 2025 15:58:48 +0200
Message-Id: <20250822135848.1922288-1-ben.hutchings@mind.be>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UAPI <asm/bpf_perf_event.h> header is required to define the type
alias bpf_user_pt_regs_t.  The generic version includes
<linux/ptrace.h> and defines it as an alias for struct pt_regs.

For these 3 architectures, struct pt_regs is not defined in the UAPI.
They need to override the generic version with an architecture-
specific definition of bpf_user_pt_regs_t.

References: https://autobuild.buildroot.org/results/bf2/bf21079facd21d684e8656e7ac44b4218a8fcb9d/build-end.log
Fixes: c895f6f703ad ("bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type")
Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
---
I understand that perf_events is not yet supported on nios2 and
openrisc, so this isn't obviously useful.  However, libbpf has generic
handling for BPF_PROG_TYPE_PERF_EVENT that includes
<linux/bpf_perf_event.h> and it now fails to build on openrisc.

I verified that:
- This fixes building libbpf with Buildroot for openrisc
- This makes "#include <linux/bpf_perf_event.h>" work on xtensa

I wasn't able to test nios2 at all.

Ben.

 arch/nios2/include/uapi/asm/bpf_perf_event.h    | 9 +++++++++
 arch/openrisc/include/uapi/asm/bpf_perf_event.h | 9 +++++++++
 arch/xtensa/include/uapi/asm/bpf_perf_event.h   | 9 +++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 arch/nios2/include/uapi/asm/bpf_perf_event.h
 create mode 100644 arch/openrisc/include/uapi/asm/bpf_perf_event.h
 create mode 100644 arch/xtensa/include/uapi/asm/bpf_perf_event.h

diff --git a/arch/nios2/include/uapi/asm/bpf_perf_event.h b/arch/nios2/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 000000000000..5e1e648aeec4
--- /dev/null
+++ b/arch/nios2/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef struct user_pt_regs bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
diff --git a/arch/openrisc/include/uapi/asm/bpf_perf_event.h b/arch/openrisc/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 000000000000..6cb1c2823288
--- /dev/null
+++ b/arch/openrisc/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef struct user_regs_struct bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
diff --git a/arch/xtensa/include/uapi/asm/bpf_perf_event.h b/arch/xtensa/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 000000000000..5e1e648aeec4
--- /dev/null
+++ b/arch/xtensa/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef struct user_pt_regs bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
-- 
2.39.5

