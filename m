From: Marc Zyngier <marc.zyngier@arm.com>
Date: Thu, 14 Sep 2017 19:31:46 +0100
Subject: [OpenRISC] [PATCH v2 06/14] irqchip: add initial support for
	ompic
In-Reply-To: <20170914065402.GU2609@lianli.shorne-pla.net> (Stafford Horne's
 message of "Thu, 14 Sep 2017 15:54:02 +0900")
References: <20170910064926.5874-1-shorne@gmail.com>
 <20170910064926.5874-7-shorne@gmail.com> <86h8w6see4.fsf@arm.com>
 <20170914065402.GU2609@lianli.shorne-pla.net>
Message-ID: <86vaklqgh9.fsf@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Sep 14 2017 at  3:54:02 pm BST, Stafford Horne <shorne@gmail.com> wrote:
> On Wed, Sep 13, 2017 at 06:21:39PM +0100, Marc Zyngier wrote:

[...]

>> > +{
>> > +	unsigned int dst_cpu;
>> > +	unsigned int src_cpu = smp_processor_id();
>> > +
>> > +	for_each_cpu(dst_cpu, mask) {
>> > +		set_bit(ipi_msg, &per_cpu(ops, dst_cpu));
>> > +
>> > +		/*
>> > +		 * On OpenRISC the atomic set_bit() call implies a memory
>> > +		 * barrier.  Otherwise we would need: smp_wmb(); paired
>> > +		 * with the read in ompic_ipi_handler.
>> > +		 */
>> 
>> One last question on this, because the architecture document is terribly
>> unclear: If you have CPU0 doing an atomic operation A0, CPU1 seeing A0
>> and doeing another atomic A1 (the set_bit above) followed by an IPI to
>> CPU2, is CPU2 *guaranteed* to observe both A0 *and* A1? Because that's
>> required by the IPI semantics, and you wouldn't see that kind of issue
>> with only two CPUs.
>
> Could you suggest an architecture document that makes this case clear?
>
> I believe this will not be a problem, but:
>   1. If this needs to be clear in the architecture document I can propose
>      changes.
>   2. To be clear is this the scenario you mean..
>
> CASE1 - A0 and A1 are to different locations?
>   A0 - writes to some unrelated global location?
>
> CPU0                       CPU1                     CPU2
>  A0:atomic store (global)
>                            A1:set_bit (ops[CPU2])
>                            IPI
>                                                     read (A0,A1)
>
>
> OR
>
> CASE2 - A0 and A1 are to the same location.
>   A0 - writes to the same location as A1
>
> CPU0                       CPU1                     CPU2
>  A0:set_bit (ops[CPU2])
>                            A1:set_bit (ops[CPU2])
>                            IPI
>                                                     read (A0,A1)
>  IPI

I think this covers both cases I had in mind.

>
>
> OR - something else?
>
> In both cases CPU2 would be able to see the results of both atomic
> operations.  All, cpus in the OpenRISC system snoop for memory writes to
> enable cash coherency, so each CPU would see each write once it is synced
> to memory (there is a single memory bus).  This is not limited to atomic
> operations, but the atomic operations provide a syncrhonization point
> accross all CPUs.

OK. It would be good if the architecture document had something about
transitivity of writes on SMP (maybe it has, I only went through it
pretty quickly). But overall, the above will work correctly.

> ps: Frank Zappa rocks :)

His music certainly does! ;-)

Thanks,

        M.
-- 
Jazz is not dead. It just smells funny.
