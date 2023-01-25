Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D312BC38142
	for <openrisc@archiver.kernel.org>; Sat, 28 Jan 2023 19:03:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DED00229DC;
	Sat, 28 Jan 2023 20:03:37 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id 37CD4215A8
 for <openrisc@lists.librecores.org>; Sat, 28 Jan 2023 20:03:37 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B1CEAB81B8C;
 Wed, 25 Jan 2023 19:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A964C433D2;
 Wed, 25 Jan 2023 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674673699;
 bh=qBn35DQSqUXJuSRxeDRwfpJWNfuE/0crpJYRHd83v4o=;
 h=From:To:Cc:Subject:Date:From;
 b=YEcaLAiW8LOEsQEOizhwah/DgYdk0Sj0EasElxRkmwC22UeVxExd/uj6NUQmANgP4
 jAVzwBza/ip8qzByaan6itTOheGqmGzh/hD5E5BgZdD+9/3Ftzb0GYHM6hdAJnWG8c
 +0dGrFu7IRI1vv+/xNF7SyJwcJ060FgtAE8tFhY0qs9BSVQGxK9kiiDi+9Al/inQ5y
 QgjBkIDWnjNcjAsez+fQtgv2zY2/zSGOHn2szZ/WwbSgKX3evSa6IUTI2vOHlKyjnc
 FhqKk/BuoBaxEuVWyr0QicxLbVmc8narKWe5G38G00CIXLChnK8wks51ggl7FZlFcj
 PHJVAXzE1TuvQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] mm,
 arch: add generic implementation of pfn_valid() for FLATMEM
Date: Wed, 25 Jan 2023 21:07:54 +0200
Message-Id: <20230125190757.22555-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.29
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 WANG Xuerui <kernel@xen0n.name>, Greg Ungerer <gerg@linux-m68k.org>,
 linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, linux-riscv@lists.infradead.org,
 Vineet Gupta <vgupta@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, linux--csky@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org,
 linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 loongarch@lists.linux.dev, Stafford Horne <shorne@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 "Mike Rapoport \(IBM\)" <rppt@kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

Every architecture that supports FLATMEM memory model defines its own
version of pfn_valid() that essentially compares a pfn to max_mapnr.

Use mips/powerpc version implemented as static inline as a generic
implementation of pfn_valid() and drop its per-architecture definitions

Mike Rapoport (IBM) (3):
  m68k: use asm-generic/memory_model.h for both MMU and !MMU
  mips: drop definition of pfn_valid() for DISCONTIGMEM
  mm, arch: add generic implementation of pfn_valid() for FLATMEM

 arch/alpha/include/asm/page.h      |  4 ----
 arch/arc/include/asm/page.h        |  1 -
 arch/csky/include/asm/page.h       |  1 -
 arch/hexagon/include/asm/page.h    |  1 -
 arch/ia64/include/asm/page.h       |  4 ----
 arch/loongarch/include/asm/page.h  | 13 -------------
 arch/m68k/include/asm/page.h       |  6 +-----
 arch/m68k/include/asm/page_mm.h    |  1 -
 arch/m68k/include/asm/page_no.h    |  4 ----
 arch/microblaze/include/asm/page.h |  1 -
 arch/mips/include/asm/page.h       | 28 ----------------------------
 arch/nios2/include/asm/page.h      |  9 ---------
 arch/openrisc/include/asm/page.h   |  2 --
 arch/parisc/include/asm/page.h     |  4 ----
 arch/powerpc/include/asm/page.h    |  9 ---------
 arch/riscv/include/asm/page.h      |  5 -----
 arch/sh/include/asm/page.h         |  3 ---
 arch/sparc/include/asm/page_32.h   |  1 -
 arch/um/include/asm/page.h         |  1 -
 arch/x86/include/asm/page_32.h     |  4 ----
 arch/x86/include/asm/page_64.h     |  4 ----
 arch/xtensa/include/asm/page.h     |  2 --
 include/asm-generic/memory_model.h | 12 ++++++++++++
 include/asm-generic/page.h         |  2 --
 24 files changed, 13 insertions(+), 109 deletions(-)


base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
-- 
2.35.1

