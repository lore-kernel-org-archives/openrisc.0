From: Stafford Horne <shorne@gmail.com>
Date: Wed, 3 Nov 2021 18:14:44 +0900
Subject: [OpenRISC] OpenRISC SMP kernels broken after 5.8?
In-Reply-To: <a29b15d7-3e8a-4851-8175-66fa805f4dff@rwth-aachen.de>
References: <e35018e8-a15b-550d-cc3e-6b6d045f1b52@rwth-aachen.de>
 <YX8O0ix3MyOGQnqq@antec> <a29b15d7-3e8a-4851-8175-66fa805f4dff@rwth-aachen.de>
Message-ID: <CAAfxs76wvwwYNTBBbCqpts8HWNZK9Dx-ETtvEge-Hva6dafumQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Jan,

You are right. I'll update those as well.

I'll send a patch later tonight. I'm out right now.

On Wed, Nov 3, 2021, 5:02 PM Jan Henrik Weinstock <
jan.weinstock@rwth-aachen.de> wrote:

> Hi Stafford,
>
> your patch has fixed the issue for me. I tested this with a 5.10 kernel
> on single-, dual- and quad- Openriscs in my simulator and it ran stable.
>
> However, are we sure we caught everything? For example, I see the same
> issue in flush_tlb_page [1], which can also have vma == NULL in the
> page_[set|clear]_nocache functions [2]. It does not trigger a panic for
> me though (probably because I do not have any DMA devices in the
> simulator at the moment)...
>
> Jan
>
> [1]
>
> https://elixir.bootlin.com/linux/v5.10.76/source/arch/openrisc/kernel/smp.c#L304
> [2]
>
> https://elixir.bootlin.com/linux/v5.10.76/source/arch/openrisc/kernel/dma.c#L36
>
> On 31/10/2021 22:46, Stafford Horne wrote:
> > On Tue, Oct 26, 2021 at 10:43:45PM +0200, Jan Henrik Weinstock wrote:
> >> Hi all,
> >>
> >> I recently tried to update the kernel my simulator[1] is running to
> 5.10,
> >> but I noticed the newer kernels (>5.8) all panic in flush_tlb_page[2],
> >> because it is called with vma == NULL from flush_tlb_kernel_range[3].
> >> Looking at the code, I do not see how this could work for any SMP kernel
> >> (however, for non-SMP, we call local_tlb_flush_page[4], where we do not
> use
> >> vma, so I guess its fine there). Any ideas?
> >
> > Hi Jan,
> >
> > (sorry for late reply, I need to fix my filters)
> >
> > Are you running on a SMP machine or are you running SMP kernel on a
> single CPU
> > with no ompic device?
> >
> > I haven't had issues when running the SMP kernels on single CPU devices,
> > however, I can't recall how recent that is.
> >
> > I did make a patch to this around 5.10, so I am pretty user it was
> working at
> > this point.  The reason added this patch was because I noticed
> simulators were
> > spending a lot of time, ~90%+, in TLB flushes I figured that reducing
> the work
> > done for TLB flushes would improve performance, and it did.
> >
> > The patch:
> >
> >   -
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=c28b27416da9
> >
> > But it looks like this is what introduced the issue.  Somehow this
> slipped
> > through.  I think a patch like the following would help for now, I
> cannot easily
> > test now due to my environment being occupied by some long running
> tests.  Any
> > suggestions?
> >
> > Basically the idea is, we only need the VMA to figure out which CPU's to
> flush
> > the range on.  When we pass in NULL it means its a kernel flush and we
> should
> > flush on all CPU's.  There may be something more efficient (maybe using
> > init_mm), but this is all I can think of that is safe.
> >
> > -Stafford
> >
> > diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> > index 415e209732a3..cf5079bd8f43 100644
> > --- a/arch/openrisc/kernel/smp.c
> > +++ b/arch/openrisc/kernel/smp.c
> > @@ -320,7 +320,9 @@ void flush_tlb_page(struct vm_area_struct *vma,
> unsigned
> > long uaddr)
> >   void flush_tlb_range(struct vm_area_struct *vma,
> >                       unsigned long start, unsigned long end)
> >   {
> > -       smp_flush_tlb_range(mm_cpumask(vma->vm_mm), start, end);
> > +       struct cpumask *cmask = (vma == NULL) ? cpu_online_mask
> > +                                             : mm_cpumask(vma->vm_mm);
> > +       smp_flush_tlb_range(cmask, start, end);
> >   }
> >
> >   /* Instruction cache invalidate - performed on each cpu */
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20211103/053c64c3/attachment.htm>
