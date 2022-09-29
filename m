Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBDEC433F5
	for <openrisc@archiver.kernel.org>; Thu, 29 Sep 2022 14:57:52 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 40CBE248F9;
	Thu, 29 Sep 2022 16:57:52 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mail.librecores.org (Postfix) with ESMTPS id 78D692491F
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 16:57:50 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id l8so1151689wmi.2
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=CxwRaQHOB8ZooIZRNzRIOeM6ParMlsGJlleuDAO0MnM=;
 b=OiF65MQuGtTT+cKtl8Gqt1lInM5OP8LryHOEKODGHl2aYzq5FjG50LcANmPGGaFzTU
 HcyuUlkL8Cs0uMyrX8zlA8kghgbanK+qebXUWHQoazCElRnSQDWHWDeZwtYW2CG+Pnl6
 JTuZ8TyRR+M0bOtnsfibloUb7vVvSXIPzTezNTh4tCPdZ1Im58uImVvlNxYMS2O/DarW
 HzWTTA2/x1IoQm/hKJ9TEi3Dzluf8LHpPBY1ceg2jO6ETx70I+hA0zRLYoKWpk6/tIrt
 wzPGNF90kJRzsxJVm6plVIn794ncjjAO8+NmKnczgodrmhpFp+roKFUAaUh81L7M0Mdl
 FHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=CxwRaQHOB8ZooIZRNzRIOeM6ParMlsGJlleuDAO0MnM=;
 b=cHYPEXxn/GfGtcTm8v7JuxKx7nkrniUAlzhhn3VnVLat1okGOeeBG/Dmyl/S7GgtN1
 t4zxBTBx+4mXM7O+D2Q6T3AXdYaRs3N0cSRgOR6wpuoKgPREKtqJTxtMRzJatduu5xzJ
 D20umTTcCnPTYu+2ZzI81cZQgAp4QiOMQtQZVvj1DOKhAgjegUT0S6EJjk9u/Y8h2Vo9
 KBA5SSA2QNLXKoB3ILNcwOmxbfli+8hnvFxKDlbifK81ypRuI/3+bEGguxMOahACg+2t
 RKvvwQfThdxyedrQvqZPk/nonFR4RS678U0CYH+DEBfN9qshpBEBPR0f3MavEzP6X4xa
 wDKA==
X-Gm-Message-State: ACrzQf3y2F+vjbL6JoJlr2GNawveQlknYYvr7Qra6wEAnNcc7maZJd7u
 //zaGuYWiDA8WpHIhkzMa5w=
X-Google-Smtp-Source: AMsMyM7UjRlZ00+1jIFU9SksyA/aJAw4TRuyjvpKlgMQiaCfuf3TlFE+PQHjR3HWeS9VCWWMSyZFgw==
X-Received: by 2002:a7b:cb91:0:b0:3b4:75b9:5a4b with SMTP id
 m17-20020a7bcb91000000b003b475b95a4bmr2640642wmi.33.1664463470043; 
 Thu, 29 Sep 2022 07:57:50 -0700 (PDT)
Received: from localhost ([88.83.123.243]) by smtp.gmail.com with ESMTPSA id
 l2-20020a1c7902000000b003b33943ce5esm5151496wme.32.2022.09.29.07.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 07:57:48 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: gcc-patches@gcc.gnu.org
Subject: [PATCH] or1k: Only define TARGET_HAVE_TLS when HAVE_AS_TLS
Date: Thu, 29 Sep 2022 15:57:40 +0100
Message-Id: <20220929145740.4846-1-shorne@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: openrisc@lists.librecores.org, Yann Morin <yann.morin@orange.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This was found when testing buildroot with linuxthreads enabled.  In
this case, the build passes --disable-tls to the toolchain during
configuration.  After building the OpenRISC toolchain it was still
generating TLS code sequences and causing linker failures such as:

 ..../or1k-buildroot-linux-uclibc-gcc -o gpsd-3.24/gpsctl .... -lusb-1.0 -lm -lrt -lnsl
 ..../ld: ..../sysroot/usr/lib/libusb-1.0.so: undefined reference to `__tls_get_addr'

This patch fixes this by disabling tls for the OpenRISC target when requested
via --disable-tls.

Tested-by: Yann E. MORIN <yann.morin@orange.com>

gcc/ChangeLog:

	* config/or1k/or1k.cc (TARGET_HAVE_TLS): Only define if
	HAVE_AS_TLS is defined.
---
 gcc/config/or1k/or1k.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gcc/config/or1k/or1k.cc b/gcc/config/or1k/or1k.cc
index da2f59062ba..0ce7b234417 100644
--- a/gcc/config/or1k/or1k.cc
+++ b/gcc/config/or1k/or1k.cc
@@ -2206,8 +2206,10 @@ or1k_output_mi_thunk (FILE *file, tree thunk_fndecl,
 #undef  TARGET_LEGITIMATE_ADDRESS_P
 #define TARGET_LEGITIMATE_ADDRESS_P or1k_legitimate_address_p
 
+#ifdef HAVE_AS_TLS
 #undef  TARGET_HAVE_TLS
 #define TARGET_HAVE_TLS true
+#endif
 
 #undef  TARGET_HAVE_SPECULATION_SAFE_VALUE
 #define TARGET_HAVE_SPECULATION_SAFE_VALUE speculation_safe_value_not_needed
-- 
2.37.2

