From: Stafford Horne <shorne@gmail.com>
Date: Thu, 20 Apr 2017 05:06:25 +0900
Subject: [OpenRISC] [Qemu-devel] [PATCH 1/7] target/openrisc: Fixes for
 memory debugging
In-Reply-To: <54fe7d09-7f47-2c7d-c0f5-2f90daf6caba@twiddle.net>
References: <cover.1492384862.git.shorne@gmail.com>
 <575d21dff52df4fa53d17e77728018453f82e8e5.1492384862.git.shorne@gmail.com>
 <382ab324-39c0-5549-ff01-3fe7cc1319de@twiddle.net>
 <20170418141846.GA2599@lianli.shorne-pla.net>
 <54fe7d09-7f47-2c7d-c0f5-2f90daf6caba@twiddle.net>
Message-ID: <20170419200625.GA2468@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Apr 18, 2017 at 08:00:06AM -0700, Richard Henderson wrote:
> On 04/18/2017 07:18 AM, Stafford Horne wrote:
> > On Tue, Apr 18, 2017 at 12:47:30AM -0700, Richard Henderson wrote:
> > > On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > > > When debugging in gdb you might want to inspect instructions in mapped
> > > > pages or in exception vectors like 0x800 etc.  This was previously not
> > > > possible in qemu since the *get_phys_page_debug() routine only looked
> > > > into the data tlb.
> > > > 
> > > > Change to fall back to look into instruction tlb and plain physical
> > > > pages.
> > > > 
> > > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > 
> > > Oh the horrors of a software managed TLB.
> > > 
> > > You might do well to architecturally define an SPR that holds the page table
> > > base, even if for real hardware that's only used by the software refill to
> > > load up the address.
> > > 
> > > That would give qemu the option of performing a real page table walk.  This
> > > would fix this debug hook properly (so that you can examine pages that
> > > aren't in the TLB at all).  It would also optionally allow QEMU to skip the
> > > software refill, which *significantly* speeds up emulation.
> > 
> > Understood, I guess we would also need a way to represent which paging
> > model we are using (1 level, 2 level etc)?
> 
> I suppose.  You really have a 1-level lookup?  For huge pages only, or is
> this a virtual 2-level lookup with double-faulting to handle the second
> level?

We don't,  the linux kernel is implemented with basic 2-level lookup's with
single fault.  I was just thinking its not ideal for the emulator to assume
the paging model since it could change from kernel to kernel.

But I guess it will not change anytime soon.

-Stafford
