Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175CE376;
	Sun, 22 Dec 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734827064; cv=none; b=KwRrH+qdGA8DlmaFQnjR/M3NtQlW/T3YSS/OpWDxEOfkr5MmeGMiJ0jxuX7zuIYQeLaGaSsCnIMaf2E6mx2KIuXftduEn3e2Xx3kkGfO3ojRO3Ifegha6xJBFRrs3c5WgmB99lrIJuevFBx7S3jLtbtP+44TT32TIxPwRW2tQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734827064; c=relaxed/simple;
	bh=OKJ8H2kPIn1ZIlkqWdSbM0aLe64mpRSCAmiXgqzWu1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3s74KxPvlQ+EO3xVg7/VKdD7bNXVEMxnr8bvXeHlqXIjGjOfCQ9jaY/83HJiJTeAMuX+QUhtpFWgh2V6ci89AO3l98g3qE+HeGri1DvqKgvy0Fz6607EF0SGFfSgI+MNGis9wWGMpQaFzHi+dHO1HFKUyKDg8fayoOSKTFebE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD1pn2xh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD1pn2xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51657C4CECE;
	Sun, 22 Dec 2024 00:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734827063;
	bh=OKJ8H2kPIn1ZIlkqWdSbM0aLe64mpRSCAmiXgqzWu1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=fD1pn2xhEhvxucVsI4YdH4+RgJH07+Za1rmSajc29KAOtJEC0IqeRRwDBDg3rmzbt
	 +PvpDuvzXNbGrsQNrVTEQSFXzGqBfqVwLX6CAiTgaAEo9Fq+JobkVDCyKa0RkQoSB+
	 k94iAZOXRMAKTjegWM/mS3Utx7SD+JVelIjuRR4iYlMQxtXTwANJW2GBtvyzH/4FGN
	 Ga+sOpRtopsr8mQnvWAwhURwkZ6tSmH1OYKfyGJJIHW+CHqlFUbpdpO8CR1PgCTVs5
	 mf4Y/4dTY9fmgVOIRrcvRMvgtRK733v/ixD2s2p7TltXuyWX6EfThUoXbNUzS95pPQ
	 vVRmD8m4jtcyA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Karol Gugala <kgugala@antmicro.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH] openrisc: migrate to the generic rule for built-in DTB
Date: Sun, 22 Dec 2024 09:23:50 +0900
Message-ID: <20241222002355.2581242-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 654102df2ac2 ("kbuild: add generic support for built-in boot
DTBs") introduced generic support for built-in DTBs.

Select GENERIC_BUILTIN_DTB to use the generic rule.

To keep consistency across architectures, this commit also renames
CONFIG_OPENRISC_BUILTIN_DTB_NAME to CONFIG_BUILTIN_DTB_NAME.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/openrisc/Kbuild                       | 1 -
 arch/openrisc/Kconfig                      | 3 ++-
 arch/openrisc/boot/dts/Makefile            | 2 +-
 arch/openrisc/configs/or1klitex_defconfig  | 2 +-
 arch/openrisc/configs/or1ksim_defconfig    | 2 +-
 arch/openrisc/configs/simple_smp_defconfig | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/openrisc/Kbuild b/arch/openrisc/Kbuild
index b0b0f2b03f87..70bdb24ff204 100644
--- a/arch/openrisc/Kbuild
+++ b/arch/openrisc/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += lib/ kernel/ mm/
-obj-y += boot/dts/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 3279ef457c57..3d053e0b59f4 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -10,6 +10,7 @@ config OPENRISC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select GENERIC_BUILTIN_DTB
 	select COMMON_CLK
 	select OF
 	select OF_EARLY_FLATTREE
@@ -92,7 +93,7 @@ config DCACHE_WRITETHROUGH
 
 	  If unsure say N here
 
-config OPENRISC_BUILTIN_DTB
+config BUILTIN_DTB_NAME
 	string "Builtin DTB"
 	default ""
 
diff --git a/arch/openrisc/boot/dts/Makefile b/arch/openrisc/boot/dts/Makefile
index 13db5a2aab52..3a66e0ef3985 100644
--- a/arch/openrisc/boot/dts/Makefile
+++ b/arch/openrisc/boot/dts/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += $(addsuffix .dtb.o, $(CONFIG_OPENRISC_BUILTIN_DTB))
+dtb-y += $(addsuffix .dtb, $(CONFIG_BUILTIN_DTB_NAME))
 
 #DTC_FLAGS ?= -p 1024
diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
index 466f31a091be..3e849d25838a 100644
--- a/arch/openrisc/configs/or1klitex_defconfig
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -7,7 +7,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SGETMASK_SYSCALL=y
 CONFIG_EXPERT=y
-CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
+CONFIG_BUILTIN_DTB_NAME="or1klitex"
 CONFIG_HZ_100=y
 CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
 CONFIG_NET=y
diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 0116e465238f..59fe33cefba2 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -14,7 +14,7 @@ CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 CONFIG_MODULES=y
 # CONFIG_BLOCK is not set
-CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"
+CONFIG_BUILTIN_DTB_NAME="or1ksim"
 CONFIG_HZ_100=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index b990cb6c9309..6008e824d31c 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -20,7 +20,7 @@ CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 CONFIG_MODULES=y
 # CONFIG_BLOCK is not set
-CONFIG_OPENRISC_BUILTIN_DTB="simple_smp"
+CONFIG_BUILTIN_DTB_NAME="simple_smp"
 CONFIG_SMP=y
 CONFIG_HZ_100=y
 CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
-- 
2.43.0

