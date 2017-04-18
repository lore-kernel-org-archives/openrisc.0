From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Apr 2017 00:47:30 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH 1/7] target/openrisc: Fixes for
 memory debugging
In-Reply-To: <575d21dff52df4fa53d17e77728018453f82e8e5.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
 <575d21dff52df4fa53d17e77728018453f82e8e5.1492384862.git.shorne@gmail.com>
Message-ID: <382ab324-39c0-5549-ff01-3fe7cc1319de@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 04/16/2017 04:23 PM, Stafford Horne wrote:
> When debugging in gdb you might want to inspect instructions in mapped
> pages or in exception vectors like 0x800 etc.  This was previously not
> possible in qemu since the *get_phys_page_debug() routine only looked
> into the data tlb.
>
> Change to fall back to look into instruction tlb and plain physical
> pages.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Oh the horrors of a software managed TLB.

You might do well to architecturally define an SPR that holds the page table 
base, even if for real hardware that's only used by the software refill to load 
up the address.

That would give qemu the option of performing a real page table walk.  This 
would fix this debug hook properly (so that you can examine pages that aren't 
in the TLB at all).  It would also optionally allow QEMU to skip the software 
refill, which *significantly* speeds up emulation.

That said,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
