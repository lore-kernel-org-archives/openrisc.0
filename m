Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD83FE27
	for <linux-openrisc@vger.kernel.org>; Fri, 29 Mar 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698058; cv=none; b=ZgL/2vID+dJQTvKvJz/0duDnFrxhzjAPxRk89W/MDksApk1JsK73Y3UnD+pLoe0eUMod0JLFg2g6/+tmP52+S55IsmDwHpK4OyRGzgArrAtj3kFf8FhmIPqlRmSUncpWVwuMWFDrFKJiuLrig8VooiCd5RYUKVZGXpvhStT1BXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698058; c=relaxed/simple;
	bh=rSaMcId9Kx4meKVLPyQ6cWidUe1U6WrWOSdASO1Uvy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7Po/m4HORCHEWcLfxOHH4SUcExvInSrften39qLmWo58F2Fi++cgqU82SslD1iOlUECVRaf2QZS2crqx0ZUdAELdI43dQRVKPzjNiTlBkr47JCugRqVcKjTesMPHi13f0hdxCGaJZeZcrHDuUBXhK6BfucYFSajzjI06xk4D94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/Ed4Wp4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/Ed4Wp4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4154d24cc77so3155895e9.3
        for <linux-openrisc@vger.kernel.org>; Fri, 29 Mar 2024 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711698055; x=1712302855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SEyGktlNufi3XKbd9DQr+1ESpUuLug902D2yBSDVPs=;
        b=l/Ed4Wp4LkVAp1HuORLcknmkKTsGPyJmkc6RPsTDYH2BYLDmMy95Y5RPP4/jiEp6po
         plQfpbXDOpBn/lFF0V/+LMBYrg4zgs+b64nxKgncS4UgImKaj3c5J5kMoYRg9GbRCp4/
         bGIrR639fhN0WTUZudWQB+RvdvGOZsyJtoK8NNiYWdvz+3WiaPmoZD+9zjxEqp1X6GXP
         r1/5AdiYG7v645zxra+54sPmeeADRh3QLDpFXn3tJvfhNMlJgg4bGBWtxgfW9qDUMrZN
         aK9IrWFv92PhwgaI+EMj+9PTe8sc5PB/diGLJakScAguZEfefcpjEw2XnVdSSR73Ijog
         28bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711698055; x=1712302855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SEyGktlNufi3XKbd9DQr+1ESpUuLug902D2yBSDVPs=;
        b=eeqo8uJIY23gz/xZDnbafnFP/EB48puFzTkHIAwQm4xHG4FGKA1+jyAoZ+ZSYm5kH9
         Nvx6xtLy+1whRbpuKKszYLMKnjvJQZe8GKmNtrMvtw5MxCL6dUKRvBXVS+d72dEZXLWs
         eP/qt4mKhcT/uKLm1LFHMryT3JABZsX43s0/soelHQ1Jl7Y0bEbW03p8eSe/09BKYswV
         oAdRSdGpqQnO8mKwxywcpeP6JCkzM4T/5KIQevOzM7yENhgOezeKBW+xJp2Qnycokbw4
         dpLWvs79k1FL1ZWuOc7hFrNnqj+JrjKDrm38g7rVPbfDF4sPuCPeo1ENLqHnEgoJmEKE
         14pQ==
X-Gm-Message-State: AOJu0Yx/QhpsrVgdmEyS0jb7NTn3iiBUw/AzbX09d6LcFBdhWsJOa4xm
	i3U37N2DZLfnpSci/kHGxV47sCoYChAzpKUiQVr6W9cEkfcthlfzOY2JEe9F
X-Google-Smtp-Source: AGHT+IFaPKA3GFvd+vtFRbJCO+2knZm41cyZt4mnsHASHP1oU9PSXtNeN7WObXWww9dQB4qmnPwYQw==
X-Received: by 2002:a05:600c:3502:b0:414:222:ad5e with SMTP id h2-20020a05600c350200b004140222ad5emr1114700wmq.11.1711698054894;
        Fri, 29 Mar 2024 00:40:54 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b0041486a6f9fcsm7782164wmq.37.2024.03.29.00.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:40:52 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 2/2] build-many-glibcs.py: Add openrisc hard float glibc variant
Date: Fri, 29 Mar 2024 07:40:44 +0000
Message-ID: <20240329074044.1961252-3-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329074044.1961252-1-shorne@gmail.com>
References: <20240329074044.1961252-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the OpenRISC hard float glibc variant to the build many
script.  We update the compiler for glibc to support hard-float
multilibs to allow us to use a single generic compiler for all glibc
variants, this requires updating the compiler name.

Tested and all builds are passing.
---
 scripts/build-many-glibcs.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/build-many-glibcs.py b/scripts/build-many-glibcs.py
index ecc743e672..b3d4617f62 100755
--- a/scripts/build-many-glibcs.py
+++ b/scripts/build-many-glibcs.py
@@ -361,8 +361,9 @@ class Context(object):
                         os_name='linux-gnu')
         self.add_config(arch='or1k',
                         os_name='linux-gnu',
-                        variant='soft',
-                        gcc_cfg=['--with-multilib-list=mcmov'])
+                        gcc_cfg=['--with-multilib-list=mcmov,mhard-float'],
+                        glibcs=[{'variant': 'soft'},
+                                {'variant': 'hard', 'ccopts': '-mhard-float'}])
         self.add_config(arch='powerpc',
                         os_name='linux-gnu',
                         gcc_cfg=['--disable-multilib', '--enable-secureplt'],
-- 
2.44.0

