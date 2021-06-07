From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Mon, 7 Jun 2021 09:50:31 +0800
Subject: [OpenRISC] [PATCH v2 01/15] mm: add setup_initial_init_mm()
 helper
In-Reply-To: <YL0+nZPViz5xzxca@kernel.org>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <20210604070633.32363-2-wangkefeng.wang@huawei.com>
 <YL0+nZPViz5xzxca@kernel.org>
Message-ID: <d07abbe5-941d-a27f-d968-e3d14ef9329a@huawei.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


On 2021/6/7 5:31, Mike Rapoport wrote:
> Hello Kefeng,
>
> On Fri, Jun 04, 2021 at 03:06:19PM +0800, Kefeng Wang wrote:
>> Add setup_initial_init_mm() helper to setup kernel text,
>> data and brk.
>>
>> Cc: linux-snps-arc at lists.infradead.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-csky at vger.kernel.org
>> Cc: uclinux-h8-devel at lists.sourceforge.jp
>> Cc: linux-m68k at lists.linux-m68k.org
>> Cc: openrisc at lists.librecores.org
>> Cc: linuxppc-dev at lists.ozlabs.org
>> Cc: linux-riscv at lists.infradead.org
>> Cc: linux-sh at vger.kernel.org
>> Cc: linux-s390 at vger.kernel.org
>> Cc: x86 at kernel.org
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/mm_types.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 5aacc1c10a45..e1d2429089a4 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -572,6 +572,14 @@ struct mm_struct {
>>   };
>>   
>>   extern struct mm_struct init_mm;
>> +static inline void setup_initial_init_mm(void *start_code, void *end_code,
>> +					 void *end_data, void *brk)
> I think it's not that performance sensitive to make it inline. It can be
> placed in mm/init-mm.c with a forward declaration in mm.h

Ok, I will send a update one with this change.

>
>> +{
>> +	init_mm.start_code = (unsigned long)start_code;
>> +	init_mm.end_code = (unsigned long)end_code;
>> +	init_mm.end_data = (unsigned long)end_data;
>> +	init_mm.brk = (unsigned long)brk;
>> +}
>    
>>   /* Pointer magic because the dynamic array size confuses some compilers. */
>>   static inline void mm_init_cpumask(struct mm_struct *mm)
>> -- 
>> 2.26.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
