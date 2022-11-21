Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C089AC4332F
	for <openrisc@archiver.kernel.org>; Mon, 21 Nov 2022 17:12:13 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C4DD72491E;
	Mon, 21 Nov 2022 18:12:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by mail.librecores.org (Postfix) with ESMTPS id DCB162491E
 for <openrisc@lists.librecores.org>; Mon, 21 Nov 2022 18:12:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BA8521ED7;
 Mon, 21 Nov 2022 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669050730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DZnidYhlob4wYa4haMFdTT34ayZpbbmwklQkgFc8Awk=;
 b=igSelbSqFd3w5BzmX0A298SdSKeA17HOh2pkXAxBvORbNrOVcERZdte79/CIP7kyZ9OEQc
 qGTUwmDBZupXek/Pmhfp3udI5D94Oj0RJVsjFfgjZC+pWWslxUZg2BB5qo/PzH90NPa33a
 kz5FoQyCzMhgnlT8dzZH2qs2wVTkhV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669050730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DZnidYhlob4wYa4haMFdTT34ayZpbbmwklQkgFc8Awk=;
 b=9DPAJO6vdbpnXuxOCWq1ear04Z0+sgJIIyVq6GX4W7oxMG//ydLJqKKD/AnzraAic+kNFl
 ixgzkrl3OEeOHpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12F081377F;
 Mon, 21 Nov 2022 17:12:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uQP0A2qxe2MQeQAAMHmgww
 (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:12:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 00/12] Introduce CONFIG_SLUB_TINY and deprecate SLOB
Date: Mon, 21 Nov 2022 18:11:50 +0100
Message-Id: <20221121171202.22080-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.1
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
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-riscv@lists.infradead.org,
 Jonas Bonn <jonas@southpole.se>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Josh Triplett <josh@joshtriplett.org>, openrisc@lists.librecores.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 patches@lists.linux.dev, Conor Dooley <conor@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi,

this continues the discussion from [1]. Reasons to remove SLOB are
outlined there and no-one has objected so far. The last patch of this
series therefore deprecates CONFIG_SLOB and updates all the defconfigs
using CONFIG_SLOB=y in the tree.

There is a k210 board with 8MB RAM where switching to SLUB caused issues
[2] and the lkp bot wasn't also happy about code bloat [3]. To address
both, this series introduces CONFIG_SLUB_TINY to perform some rather
low-hanging fruit modifications to SLUB to reduce its memory overhead.
This seems to have been successful at least in the k210 case [4]. I
consider this as an acceptable tradeoff for getting rid of SLOB.

The series is also available in git:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-tiny-v1r2

[1] https://lore.kernel.org/all/b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz/
[2] https://lore.kernel.org/all/a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com/
[3] https://lore.kernel.org/all/Y25E9cJbhDAKi1vd@99bb1221be19/
[4] https://lore.kernel.org/all/6a1883c4-4c3f-545a-90e8-2cd805bcf4ae@opensource.wdc.com/

Vlastimil Babka (12):
  mm, slab: ignore hardened usercopy parameters when disabled
  mm, slub: add CONFIG_SLUB_TINY
  mm, slub: disable SYSFS support with CONFIG_SLUB_TINY
  mm, slub: retain no free slabs on partial list with CONFIG_SLUB_TINY
  mm, slub: lower the default slub_max_order with CONFIG_SLUB_TINY
  mm, slub: don't create kmalloc-rcl caches with CONFIG_SLUB_TINY
  mm, slab: ignore SLAB_RECLAIM_ACCOUNT with CONFIG_SLUB_TINY
  mm, slub: refactor free debug processing
  mm, slub: split out allocations from pre/post hooks
  mm, slub: remove percpu slabs with CONFIG_SLUB_TINY
  mm, slub: don't aggressively inline with CONFIG_SLUB_TINY
  mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED

 arch/arm/configs/clps711x_defconfig           |   3 +-
 arch/arm/configs/collie_defconfig             |   3 +-
 arch/arm/configs/multi_v4t_defconfig          |   3 +-
 arch/arm/configs/omap1_defconfig              |   3 +-
 arch/arm/configs/pxa_defconfig                |   3 +-
 arch/arm/configs/tct_hammer_defconfig         |   3 +-
 arch/arm/configs/xcep_defconfig               |   3 +-
 arch/openrisc/configs/or1ksim_defconfig       |   3 +-
 arch/openrisc/configs/simple_smp_defconfig    |   3 +-
 arch/riscv/configs/nommu_k210_defconfig       |   3 +-
 .../riscv/configs/nommu_k210_sdcard_defconfig |   3 +-
 arch/riscv/configs/nommu_virt_defconfig       |   3 +-
 arch/sh/configs/rsk7201_defconfig             |   3 +-
 arch/sh/configs/rsk7203_defconfig             |   3 +-
 arch/sh/configs/se7206_defconfig              |   3 +-
 arch/sh/configs/shmin_defconfig               |   3 +-
 arch/sh/configs/shx3_defconfig                |   3 +-
 include/linux/slab.h                          |   8 +
 include/linux/slub_def.h                      |   6 +-
 kernel/configs/tiny.config                    |   5 +-
 mm/Kconfig                                    |  38 +-
 mm/Kconfig.debug                              |   2 +-
 mm/slab_common.c                              |  16 +-
 mm/slub.c                                     | 415 ++++++++++++------
 24 files changed, 377 insertions(+), 164 deletions(-)

-- 
2.38.1

