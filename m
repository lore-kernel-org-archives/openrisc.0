From: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Date: Tue, 26 Oct 2021 22:43:45 +0200
Subject: [OpenRISC] OpenRISC SMP kernels broken after 5.8?
Message-ID: <e35018e8-a15b-550d-cc3e-6b6d045f1b52@rwth-aachen.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all,

I recently tried to update the kernel my simulator[1] is running to 
5.10, but I noticed the newer kernels (>5.8) all panic in 
flush_tlb_page[2], because it is called with vma == NULL from 
flush_tlb_kernel_range[3]. Looking at the code, I do not see how this 
could work for any SMP kernel (however, for non-SMP, we call 
local_tlb_flush_page[4], where we do not use vma, so I guess its fine 
there). Any ideas?

[1] https://github.com/janweinstock/or1kmvp
[2] 
https://elixir.bootlin.com/linux/v5.10.75/source/arch/openrisc/kernel/smp.c#L312
[3] 
https://elixir.bootlin.com/linux/v5.10.75/source/arch/openrisc/include/asm/tlbflush.h#L59
[4] 
https://elixir.bootlin.com/linux/v5.10.75/source/arch/openrisc/mm/tlb.c#L96
