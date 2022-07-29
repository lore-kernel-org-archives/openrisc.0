Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6684CC00140
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 03:37:35 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1D2D8211B0;
	Fri, 29 Jul 2022 05:37:34 +0200 (CEST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by mail.librecores.org (Postfix) with ESMTPS id EECA124928
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 05:37:32 +0200 (CEST)
Received: by mail-oi1-f179.google.com with SMTP id s204so4589082oif.5
 for <openrisc@lists.librecores.org>; Thu, 28 Jul 2022 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jVbZ9bmsOHazMdxh0GDBgdwGjsfWr7pMUJNONrNaL9s=;
 b=Aj0rVguqvsuZZ0t8pNqTKyCYkhPLraEXCjqKSqKsCd33Sp63cwyRHrEgurLEQru+A/
 KR2SQWOaz2u/oDoYdltfXGP3Z8KCcFUvI5euVUjBENEVPg8YDEf0116AW1R/VwvzZ8JA
 OyD/KkHdT4re5j9I3JO69aubXGTsC8uKnotHnI6M52pbMAvgzMXILDiLK1jisFXNMEN4
 Vr5zzrWuLbvIVqhh0sxxeGij/zA3zGpYjDMsTFWwuza/iVNQ5G46JBSCUMmanxVL5hX1
 4qLFiTKWeduwuHZz7BuYcIkZ5JvjbJStA07Z2zbnxnAIKBpml/GPl5ljPD8reotV8Hme
 wlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=jVbZ9bmsOHazMdxh0GDBgdwGjsfWr7pMUJNONrNaL9s=;
 b=0IWu+9cBfksJRxwpSh2fCgwsxQoSMih+7c5vGL6/53cf/2cqcCGNkiAGGWG52972ae
 AiEuHIZBPG/ysPqEpEcjFixx+uSUE4urZapxIhBm5bBbjp62INUA3KJ/enc5VO5JaEA9
 ebP8wwlmrEdy5EJHxS7sdoANBjM03g8ZLj6r+7h74l/l8hFYYB9H0dn2NdmXZtSfXR+E
 yMhEE+U0IIWeEqb5EnEmTwaPCaU4GoemGSSJN/py7OIf5E7aoieXyQdYaGAR4bV1FZ6H
 ZDPgP56GyrM6XSbSg0ZJRadrd6KBLuh5ndxIK1WbBg/ZRY0KdCa88PxKLTgNhQn6kk1T
 n7+A==
X-Gm-Message-State: AJIora/aO8vHcEHlbmcC+KwIwmhfXU6aHrS+zPQmdk2wbTW+UG46P7MY
 vjd1cSjw7P3aJ9B41/EYdSw=
X-Google-Smtp-Source: AGRyM1stmIDzT8euWFlVJw0SMcjwdX8Fvl215sWpa689RARkkMlG+uqN0oPR18jPdyDGOk0RgnyNrQ==
X-Received: by 2002:a54:4086:0:b0:33a:6fc9:1f8c with SMTP id
 i6-20020a544086000000b0033a6fc91f8cmr789379oii.71.1659065851695; 
 Thu, 28 Jul 2022 20:37:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 a40-20020a056870d62800b0010e00d6a1c0sm1196320oaq.51.2022.07.28.20.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jul 2022 20:37:30 -0700 (PDT)
Date: Thu, 28 Jul 2022 20:37:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v3 2/3] openrisc: Add pci bus support
Message-ID: <20220729033728.GA2195022@roeck-us.net>
References: <20220725020737.1221739-1-shorne@gmail.com>
 <20220725020737.1221739-3-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725020737.1221739-3-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, openrisc@lists.librecores.org,
 Bjorn Helgaas <helgaas@kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Mon, Jul 25, 2022 at 11:07:36AM +0900, Stafford Horne wrote:
> This patch adds required definitions to allow for PCI buses on OpenRISC.
> This is being tested on the OpenRISC QEMU virt platform which is in
> development.
> 
> OpenRISC does not have IO ports so we keep the definition of
> IO_SPACE_LIMIT and PIO_RESERVED to be 0.
> 
> Note, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
> systems") all platforms that support PCI also need to support parallel
> port.  We add a generic header to support compiling parallel port
> drivers, though they generally will not work as they require IO ports.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

This patch results in

Building openrisc:allmodconfig ... failed
--------------
Error log:
drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
drivers/video/fbdev/riva/fbdev.c:2062:42: error:
	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

... and so on.

Prior to this patch, the code was not enabled because it depends on PCI.

Bisect log attached.

Guenter

---
# bad: [7c5e07b73ff3011c9b82d4a3286a3362b951ad2b] Add linux-next specific files for 20220728
# good: [e0dccc3b76fb35bb257b4118367a883073d7390e] Linux 5.19-rc8
git bisect start 'HEAD' 'v5.19-rc8'
# bad: [96bce6a87ad9690eaa9b1ca9ace7c98444d7869f] Revert "Revert "drm/amdgpu: add drm buddy support to amdgpu""
git bisect bad 96bce6a87ad9690eaa9b1ca9ace7c98444d7869f
# bad: [08765bd733f4662c2ad80e813c933758b3c1dddc] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
git bisect bad 08765bd733f4662c2ad80e813c933758b3c1dddc
# good: [d40269b953fd9abba9aadaa57c6486990ab806d1] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect good d40269b953fd9abba9aadaa57c6486990ab806d1
# bad: [3d810ed5c60843645c6a40cc5ebd66e399c94165] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
git bisect bad 3d810ed5c60843645c6a40cc5ebd66e399c94165
# good: [046537a939b089589a1a6e70df16b10a8f0c8ca8] Merge branch 'clk-next' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
git bisect good 046537a939b089589a1a6e70df16b10a8f0c8ca8
# good: [d6b551b8f90cc92c7d3c09cf38c748efe305ecb4] powerpc/64e: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
git bisect good d6b551b8f90cc92c7d3c09cf38c748efe305ecb4
# bad: [e30727fee2a25176c4558f49a102524eba973d49] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
git bisect bad e30727fee2a25176c4558f49a102524eba973d49
# bad: [36c4dbb3e78602ee750e12c85fadb3da4392eeac] Merge branch 'for-next' of git://github.com/openrisc/linux.git
git bisect bad 36c4dbb3e78602ee750e12c85fadb3da4392eeac
# good: [9db5e69af1f4de043ae962a908fc7ef1a40f7f51] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
git bisect good 9db5e69af1f4de043ae962a908fc7ef1a40f7f51
# good: [62fb295ce7dd9df3e04b48a943f8cafaf1f32980] MIPS: dts: align gpio-key node names with dtschema
git bisect good 62fb295ce7dd9df3e04b48a943f8cafaf1f32980
# bad: [2479c96f5d3db2610a6d463077dd3dad087529fb] openrisc: Add virt defconfig
git bisect bad 2479c96f5d3db2610a6d463077dd3dad087529fb
# good: [a2912b45b0826c6fc0ca9b264d03a2dacb7a72e8] asm-generic: Add new pci.h and use it
git bisect good a2912b45b0826c6fc0ca9b264d03a2dacb7a72e8
# good: [3e2a6fbbbf34d230b9063f1ca885d5d625a0404c] asm-generic: Support NO_IOPORT_MAP in pci_iomap.h
git bisect good 3e2a6fbbbf34d230b9063f1ca885d5d625a0404c
# bad: [48ef4b584af7ba4ecdf2dd58b641fb8d0a9d0c63] openrisc: Add pci bus support
git bisect bad 48ef4b584af7ba4ecdf2dd58b641fb8d0a9d0c63
# first bad commit: [48ef4b584af7ba4ecdf2dd58b641fb8d0a9d0c63] openrisc: Add pci bus support
