From: Marc Zyngier <marc.zyngier@arm.com>
Date: Mon, 4 Sep 2017 08:35:19 +0100
Subject: [OpenRISC] [PATCH 05/13] irqchip: add initial support for ompic
In-Reply-To: <20170903221236.GM2609@lianli.shorne-pla.net>
References: <cover.1504129273.git.shorne@gmail.com>
 <538699c64b5601e8800b77da29f7951bf23f57ce.1504129273.git.shorne@gmail.com>
 <1b062d84-7335-8553-39c7-2e60973b4396@arm.com>
 <20170901012449.GG2609@lianli.shorne-pla.net>
 <97879c84-3ce8-b2bf-d438-679a69b60774@arm.com>
 <20170903221236.GM2609@lianli.shorne-pla.net>
Message-ID: <aaf3a8dc-bd10-7c93-8293-0d9b79a7c4af@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 03/09/17 23:12, Stafford Horne wrote:
> On Fri, Sep 01, 2017 at 06:25:01PM +0100, Marc Zyngier wrote:
>> On 01/09/17 02:24, Stafford Horne wrote:
>>> On Thu, Aug 31, 2017 at 10:28:01AM +0100, Marc Zyngier wrote:
>>>> On 30/08/17 22:58, Stafford Horne wrote:
>>>>> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

[...]

>>>>> +	unsigned int dst_cpu;
>>>>> +	unsigned int src_cpu = smp_processor_id();
>>>>> +
>>>>> +	for_each_cpu(dst_cpu, mask) {
>>>>> +		set_bit(irq, &ipi_data[dst_cpu].ops);
>>>>> +
>>>>> +		ompic_writereg(ompic_base, OMPIC_IPI_CTRL(src_cpu),
>>>>> +			       OMPIC_IPI_CTRL_IRQ_GEN |
>>>>> +			       OMPIC_IPI_CTRL_DST(dst_cpu) |
>>>>> +			       OMPIC_IPI_DATA(1));
>>>>
>>>> What guarantees that the action of set_bit can be observed by the target
>>>> CPU? set-bit gives you atomicity, but no barrier.
>>>
>>> The bit will not be read by target CPUs until after the ompic_writereg()
>>> which will trigger the target CPU interrupt to be raised.  OpenRISC stores
>>> are ordered.
>>
>> Are they really ordered irrespective of the memory type (one is
>> cacheable RAM, the other is a device...)?
>>
>> And assuming they are (which I find a bit odd), that doesn't necessarily
>> guarantee that the interrupt will only be delivered once the effect of
>> set_bit can be seen on the target CPU...
> 
> OpenRISC might be a bit odd here, but I think this is correct.  On OpenRISC
> the atomic instructions also imply a pipeline flush for stores and loads
> (l.swa/l.lwa).  This is highlighted in the architecture spec section 7.3 [0].

OK, fair enough. This is quite unusual (and I'm prepared to bet that
this will be relaxed in future evolutions of the architecture), but
that's indeed the gospel.

Please add a comment between set_bit and writereg so that we know we've
been through this discussion already.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
