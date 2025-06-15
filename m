Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71428F4A
	for <linux-openrisc@vger.kernel.org>; Sun, 15 Jun 2025 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749961964; cv=none; b=ovnCrq/Vkj67N3ed8Yb1U37/CFBSQc0ERLQDfgfFRQdjx0VknzQPmUv1jtPoL9qXNr1xqyY+5/zbOPKxztm6mAlPH/EqRKJ31lvkToT+1o0B+xCaPka0CKn3AhaSAf6UeZjGlP67kJhZB38xCp/d88SmdLyKIkBbNKFa3W0zyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749961964; c=relaxed/simple;
	bh=kNrs6Z6n5dYg3hEgYy0RugzjTApu9ewEFTM/c6RzAkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5jWPw7glECPsuDncYhXqMDLVkEzR6Hx1bHr/y9GUhQeVrzT4AT55ZITiNO+HlzTg6wf1EqxATj1VT6A4mtfeAYtOIgXRO9/5sfx2KoUwtRBT9LBlXppRFsl7zNlXpkAab9YHWXM9pSXq+Tior9TzygB6YPIB6QOamEsQ1kbg5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVcMViTO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVcMViTO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a51481a598so1978951f8f.3
        for <linux-openrisc@vger.kernel.org>; Sat, 14 Jun 2025 21:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749961961; x=1750566761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UPadYhcSPwi1f7rD8AQJPh4g+k7RfoM7UUYmWSSOYaY=;
        b=CVcMViTO07dco/Jrgf09TZ4fYTWf+ZbbpIgcfFRuFNcLYbn5/t4o9EhbmHhS8DDb+S
         7+lFZPFDUG5eSvRe8444xVqzRF6tfJpnhkS7wDOQwLIRb/MiJaBvXkdMYO2rQBMlm7nl
         JNMoLnhzr+5R78h5grmMUCRw1U7NrGTVBC9iuKoby8ottuv3gHpD449l4tO1qkSfDdm1
         TdXZda2AC4b1Qj5nb+dBUPcKPhIE1KXeNB4rdCZ0O8/AfgXfbVO8RscNAaa7KCRM+9Fl
         lPQX8SYuDtrEs+fQvxluyrv/PcLW1WeXr+UDRaqQ4P4JfjV0mdTzuHzrk+1nklAK/sp2
         SHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749961961; x=1750566761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPadYhcSPwi1f7rD8AQJPh4g+k7RfoM7UUYmWSSOYaY=;
        b=vA6A0r68HxuTv+z2WdNwFf2aS3woE/wvD3ENdfEDU+D+pYbExZ+YLK0xweRr9J2fq4
         8CbzbNYSVVcFNfMjgA6ZArGiELVThqc4yGJAmtazpxrKu3NVXtQUlGX+NKlOq6pupU/n
         J0IbR8QY1Qbcvd534qZgktScvPecu3IIqd9e8pkg2nIAmZKsHKqRbEfZdVMFAJESOA7O
         5yoNNhcn7mu8C3o4Um18jEfuKWo2TwJO6UEADhoNNwbJrNA0Nbz9BDCq+b9f0QKiGLCl
         k/99dgV9TZ2HgUDxw9Y4xzTSyNpA6qJD3E51KMOR+MZapyz/cO7uqvVMe4kL6xq1JYKp
         anLg==
X-Gm-Message-State: AOJu0YyLk/473amUW72HW+DOUB1gC7Dk/lhl8motj1MP2QKmUKt6jiC+
	niVqpy58hyYER7jBs+5M/z5Tu/JfYVUVtYYpIH6baEGHwfn3d2ErRjkl
X-Gm-Gg: ASbGncu7TIBIQWm416b+SE5JaXospmpYsw0t5CxPmfc55OkE3eYfs0I682TbI2o2Dig
	DB00sg3GGHnXZepZSpHfLR2rOAb7O0H+S82SHJB1KG5lXaeP8nraMBOnpZSsnBAfenM6r/OiLvc
	9MnEbEwMbiGRy4dKU9tWc0aGzNdcDQrtSvp9npKYpm0xS44PGhOJdFCDNhD9ap4fP/6LZbI13Ku
	HYagt+RP95R1T0fTChZ3AoB/QrC+9WtNCYsKPvRceRUux+VOPdkiOnGVEJPukf2DzAKRmx+pVbD
	W3mVMQXhtWkMQkLkuhl4omo+CPGuXHADxGDB8aZnwGJPo3vuLHtptZoZozLQwoebvi5ACtfQjZq
	8zhrwdXrAr8w2CBRTVR9jVhYbjebxVdd9DJz4
X-Google-Smtp-Source: AGHT+IF33CmxPUkLx24k/vRXN3Ey2pGvNKK83X30Mu8PD3jb0y429oC5G+F7KKy02+guFhVgbxmJrA==
X-Received: by 2002:a05:6000:2010:b0:3a4:f70d:8673 with SMTP id ffacd0b85a97d-3a57237dc6cmr4384436f8f.25.1749961960749;
        Sat, 14 Jun 2025 21:32:40 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a67361sm6812390f8f.30.2025.06.14.21.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 21:32:38 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GNU Binutils <binutils@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Fix disassembly for litte endian binaries
Date: Sun, 15 Jun 2025 05:32:33 +0100
Message-ID: <20250615043233.418239-1-shorne@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some OpenRISC CPU's that have their binaries stored in litte
endian format.  Using objdump to disassemble these is problematic as
shown below, some instructions fail to disassmble.

    objdump -D -b binary -EB -m or1k test_be.bin

       0:	18 60 07 27 	l.movhi r3,0x727
       4:	a8 63 0e 00 	l.ori r3,r3,0xe00
       8:	9c 63 ff ff 	l.addi r3,r3,-1
       c:	bc 43 00 00 	l.sfgtui r3,0
      10:	13 ff ff fe 	l.bf 0x8
      14:	44 00 48 00 	l.jr r9

    objdump -D -b binary -EL -m or1k test_le.bin

       0:	27 07 60 18 	*unknown*
       4:	00 0e 63 a8 	l.ori r3,r3,0xe00
       8:	ff ff 63 9c 	*unknown*
       c:	00 00 43 bc 	l.sfgtui r3,0
      10:	fe ff ff 13 	*unknown*
      14:	00 48 00 44 	l.jr r9

It was found that the hash function was using the still little-endian
buffer to extract the opcode used for the has lookup.  This didn't work
as it was pulling the wrong hashcode causing instruction lookup to fail.

Fix the hash function by using the normalized/byte-swapped value instead
of the buffer.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 cpu/or1k.opc       | 2 +-
 opcodes/or1k-opc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cpu/or1k.opc b/cpu/or1k.opc
index 5d20a1f33a7..748187edcdf 100644
--- a/cpu/or1k.opc
+++ b/cpu/or1k.opc
@@ -38,7 +38,7 @@
 #undef  CGEN_DIS_HASH_SIZE
 #define CGEN_DIS_HASH_SIZE 256
 #undef  CGEN_DIS_HASH
-#define CGEN_DIS_HASH(buffer, value) (((unsigned char *) (buffer))[0] >> 2)
+#define CGEN_DIS_HASH(buffer, value) ((value >> 26) & 0xff)
 
 /* Check applicability of instructions against machines.  */
 #define CGEN_VALIDATE_INSN_SUPPORTED
diff --git a/opcodes/or1k-opc.h b/opcodes/or1k-opc.h
index d3d084b1bec..6eec8006828 100644
--- a/opcodes/or1k-opc.h
+++ b/opcodes/or1k-opc.h
@@ -35,7 +35,7 @@ extern "C" {
 #undef  CGEN_DIS_HASH_SIZE
 #define CGEN_DIS_HASH_SIZE 256
 #undef  CGEN_DIS_HASH
-#define CGEN_DIS_HASH(buffer, value) (((unsigned char *) (buffer))[0] >> 2)
+#define CGEN_DIS_HASH(buffer, value) ((value >> 26) & 0xff)
 
 /* Check applicability of instructions against machines.  */
 #define CGEN_VALIDATE_INSN_SUPPORTED
-- 
2.49.0

