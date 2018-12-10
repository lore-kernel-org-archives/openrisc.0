From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Dec 2018 20:25:08 +0100
Subject: [OpenRISC] [PATCH 02/10] arm64/iommu: don't remap contiguous
 allocations for coherent devices
In-Reply-To: <eaf8ce49-ab5e-7c02-a028-74671172b684@arm.com>
References: <20181208173702.15158-1-hch@lst.de>
 <20181208173702.15158-3-hch@lst.de>
 <eaf8ce49-ab5e-7c02-a028-74671172b684@arm.com>
Message-ID: <20181210192508.GA31318@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 10, 2018 at 07:19:30PM +0000, Robin Murphy wrote:
> On 08/12/2018 17:36, Christoph Hellwig wrote:
>> There is no need to have an additional kernel mapping for a contiguous
>> allocation if the device already is DMA coherent, so skip it.
>
> FWIW, the "need" was that it kept the code in this path simple and the 
> mapping behaviour consistent with the regular iommu_dma_alloc() case. One 
> could quite easily retort that there is no need for the extra complexity of 
> this patch, since vmalloc is cheap on a 64-bit architecture ;)

Heh.  Well, without the remap we do less work, we prepare for a simple
implementation of DMA_ATTR_NON_CONSISTENT, and also prepapre the code
to be better reusable for architectures that don't do remapping of
DMA allocations at all.

>>   		if (addr) {
>>   			memset(addr, 0, size);
>> -			if (!coherent)
>> -				__dma_flush_area(page_to_virt(page), iosize);
>> +			__dma_flush_area(page_to_virt(page), iosize);
>
> Oh poo - seems I missed it at the time but the existing logic here is 
> wrong. Let me send a separate fix to flip those statements into the correct 
> order...

Yes, flushing the remapped alias only after zeroing it looks odd.
