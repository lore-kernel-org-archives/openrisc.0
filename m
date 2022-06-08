Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A0CCA47E
	for <openrisc@archiver.kernel.org>; Wed,  8 Jun 2022 23:00:30 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 952BA249CD;
	Thu,  9 Jun 2022 01:00:29 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mail.librecores.org (Postfix) with ESMTPS id 9C069249A5
 for <openrisc@lists.librecores.org>; Wed,  8 Jun 2022 17:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ezwSP2ycpO1p3eEM9FoNLAzo6tW/B/UAxq7z/I5YF+c=; b=VX18ZEOxSUcNpyBZYrsteOdpBT
 HZTcWzeAfZ6BJYQuFjLWfCOJvTMUxk8MBr1xKoL2P60bmS4cJFpNLiXDZtftqzI+rgduxGS68DtiK
 n2sX7U8y/70osNz3d2Xt0J6OluKnOUM3YB9Zi9fJja9GYLe+tapPXdVPaGQ3u9lSN6Xi3CMW1rzUO
 e3CAfEEv9OEh2D7wgtx4oI2+cs3IN1VyHSrg0xW5CGtOKE5NiMzT399Egt+AxLGeudx7a3sdf9LdV
 Mi/zih0vfnOHChkKnY+yM8XUEhW7zxYgPk9eAQTvAmT+1w3WkGykJpFbfD3mdaGEeXhyHnkHSdNZ4
 EXPPsicA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyxHH-00CjeB-22; Wed, 08 Jun 2022 15:07:23 +0000
Date: Wed, 8 Jun 2022 16:07:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Subject: Re: [mm]  9b12e49e9b: BUG:Bad_page_state_in_process
Message-ID: <YqC7K0e2FFp7vT6i@casper.infradead.org>
References: <d35f42f7b598f629437940f941826e2cc49a97f6.1654271618.git.baolin.wang@linux.alibaba.com>
 <20220608143819.GA31193@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608143819.GA31193@xsang-OptiPlex-9020>
X-Mailman-Approved-At: Thu, 09 Jun 2022 00:59:57 +0200
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
Cc: linux-arch@vger.kernel.org, 0day robot <lkp@intel.com>, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
 lkp@lists.01.org, openrisc@lists.librecores.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Jun 08, 2022 at 10:38:19PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 9b12e49e9b02bbaca8041f236a6b2fd4586d45c8 ("[RFC PATCH 3/3] mm: Add kernel PTE level pagetable pages account")

> [   75.338681][ T4873] BUG: Bad page state in process 444  pfn:20b066
> [   75.338840][ T4873] page:0000000016cf0259 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x20b066

mapcount:-512 is PG_table.  Somebody forgot to call
pgtable_pte_page_dtor() (or similar)

> [   75.339041][ T4873] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [   75.339190][ T4873] raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
> [   75.339350][ T4873] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
> [   75.339508][ T4873] page dumped because: nonzero mapcount
> [   75.341013][ T4873] Call Trace:
> [   75.341080][ T4873]  <TASK>
> [ 75.341142][ T4873] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
> [ 75.341236][ T4873] bad_page.cold (mm/page_alloc.c:637) 
> [ 75.341326][ T4873] free_pcppages_bulk (mm/page_alloc.c:1511) 
> [ 75.341428][ T4873] free_unref_page (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3444) 
> [ 75.341524][ T4873] __mmdrop (arch/x86/include/asm/mmu_context.h:125 (discriminator 3) kernel/fork.c:791 (discriminator 3)) 
> [ 75.341608][ T4873] ? __mmput (arch/x86/include/asm/atomic.h:123 include/linux/atomic/atomic-instrumented.h:576 include/linux/sched/mm.h:49 kernel/fork.c:1194) 
> [ 75.341889][ T4873] exec_mmap (fs/exec.c:1035) 
> [ 75.341977][ T4873] begin_new_exec (fs/exec.c:1293) 
> [ 75.342071][ T4873] ? kernel_read (fs/read_write.c:455) 
> [ 75.342160][ T4873] load_elf_binary (fs/binfmt_elf.c:1002) 
