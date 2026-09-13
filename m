Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C33A782B
	for <linux-openrisc@vger.kernel.org>; Sun, 13 Sep 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789283010; cv=none; b=mAm9GuOLW+jPa5MBcKwzSzs6p2YvqSVDnSZIJvdDe7reGB064MkltX6PIp+/83DEa4Ibg3kR1ngXRp0buxtJEK1s8356BzepIn21S/nExWC7ns9MppblVG8qtM3l31fBownaI3gujd45siQ9ntVKGvJoXcYp8DjBr2NuFJxRTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789283010; c=relaxed/simple;
	bh=x9W96GkN9fs/U/g2VIScH2pv8UJNnhObbP8LUnAnKwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fRrxN9SlUSH+2h8mHE3LtRpVoNxP6l2Ij/wDGFvfJBwhuH1vq5DaKjRpYWYvza9Z/is/zoV7eeyuD3zgWoUYsWC2IqWkJGxywrFysvdHIpUR0YEtDaXxmZo+5RhB3auA3WCyQug4yIMruhSsDDALKmI50Qhfr3UYb+mTELu7ruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPJ3yBQO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPJ3yBQO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49e6e69d528so8772155e9.2
        for <linux-openrisc@vger.kernel.org>; Sun, 13 Sep 2026 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789283007; x=1789887807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H0yMxZFHf+VRPFZLycJMxxNKEcHFQB+B6CO6Ssijaew=;
        b=IPJ3yBQOuxUkEFoac10gQ67ISHwIrt1ZTVUrtbYyp72INFt83WOSCA0yWNiuBvWF0Q
         FN12TIPsjOkHzbLFgYT6Yj4QKn4JS/l3GK1RdaGbrVgUXXmucHpl4vqMF4bYQnNJ9C+d
         4r0moIyNMbIbCnxw2vAwEX/cJbZhtIwLRsjsDC9XjVZ+UQ045L8ThYmp/qnaZGcLAC3r
         OxilXinYoU2+RGhqXF8/YBp5BRv5/QiucH6Rc/qwILBxAWKJVywuMn0NXLVzI171/2Xs
         496SV/hWVf9BR+uxSs9HLZ3PIFl47hzQKDLHrJX3oJTiIGT4kHSY+dCMc5M3dK6wL02j
         yQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789283007; x=1789887807;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H0yMxZFHf+VRPFZLycJMxxNKEcHFQB+B6CO6Ssijaew=;
        b=N7FdZGpr74XdGgrsYRFx3X1XWC7do2Hd7WUDkRH8caMFHJbGfIQHC44SMFFuOzPoe9
         xprmwhjGw4D7iKMBnA6DUL+3xHJFqw3uHXYnr6zPVPKXDpWZNDyIbZdmPISwu70AUQhh
         S/VnTf4x3TD2lW804h9VrAVqDQsI86DNQTlbsiaKsZXQ/UnQ9cidalnqWg81JcxQpz2B
         TRfa1i9BedCTXY28t8r2iCE09kqkzCebr6RifqGU5LxVNhCqs+QrQzDlAUjubzkh65Vm
         1t32ssa7hPcz2iy1PJh0UaHxdMXwgr+vsp7O+FsjugmS8PEHWMY+Krf+yX8mccKY7eLa
         a8Vw==
X-Gm-Message-State: AFuF++kwJZ368fZykdJUe9+58U6ninVl9iTzAZU003geib+Wz3wsnUQg
	qDtj8NMj7Tn6VjE5yu4rD0so6vtnFJtmPaxxFl5x1pg0VUFijThxP54f
X-Gm-Gg: AYBFou1zT2fRUgBi92f7yU9ccXaPHXBPp3QydAOcUZCRMuc4pHnzjSM056iRXy2HyyQ
	JdI4T1cwRrAbRJyU5MvPjIHNI9cjkbIs5hX97FIgU/WviTAlFv68ch/NVe5pG965GrPvREwjZ7M
	kjN8vqUTOh73EUBQa4lAyxSXHP+nC8YD1XUugKdU6QAcwxA4HbWt7eOhBvUslloM2fGCsMGCHZJ
	B2rmQlY5eHh71M/QJc9Zc8g4M3yaRobrYtfoSWeIyFnWQx9QCxAtGrYju/6wkBikO4yAEIzBQq2
	+KQ8tvU8UNFFNeQqO1Z8MdqcpVYctTNI2k3S0R2Qsk713GTZ14t0Fv31rqrjeF7/pRV9SzT38nc
	e4T1lLoh0vUwj5tKSRUOLouV0ezywiopZvOJY368K9v1bq613+leXQkJfMFh6IrexybHZORNlbk
	hxjyEIhf2iAAePJEFrJpvT43fMbLGU4sIH0fDRH08sOUErhyTCgHGUGOrGAEStsVESVQlty9pZz
	cTSscB1MG3jBmgeZqKePn3me8wCVjrHtwDX7hYpYEVzP8vdXgDGew==
X-Received: by 2002:a05:600c:6085:b0:49e:6cc1:14d9 with SMTP id 5b1f17b1804b1-49e6cc11680mr57470885e9.32.1789283006372;
        Sun, 13 Sep 2026 00:03:26 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e64221639sm79202045e9.4.2026.09.13.00.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 00:03:25 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stafford Horne <shorne@gmail.com>
Subject: [PULL 0/1] OpenRISC Updates 2026-09-13
Date: Sun, 13 Sep 2026 08:03:02 +0100
Message-ID: <20260913070303.1010504-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Please consider for pull,

The following changes since commit d43c2d5f89db70359a7b3a7e2ad7098fcc0165ef:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-09-11 12:04:42 -1000)

are available in the Git repository at:

  https://github.com/stffrdhrn/qemu.git tags/or1k-updates-20260913

for you to fetch changes up to cfaf6a1edd8803f0334007dbbff9ca5eb293e98b:

  target/or1k: Implement l.extws and l.extwz (2026-09-12 08:31:14 +0100)

----------------------------------------------------------------
OpenRISC Updates 2026-09-13

One patch:
 - Missing instruction definitions for word sign extension.

----------------------------------------------------------------
Ali Ahmet Memiş (1):
      target/or1k: Implement l.extws and l.extwz

 target/or1k/disas.c      |  2 ++
 target/or1k/insns.decode |  2 ++
 target/or1k/translate.c  | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

Ali Ahmet Memiş (1):
  target/or1k: Implement l.extws and l.extwz

 target/or1k/disas.c      |  2 ++
 target/or1k/insns.decode |  2 ++
 target/or1k/translate.c  | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

-- 
2.53.0

