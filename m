From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Mon, 7 Jun 2021 08:55:54 +0800
Subject: [OpenRISC] [PATCH v2 00/15] init_mm: cleanup ARCH's
 text/data/brk setup code
In-Reply-To: <YL0+Jargm+y9aqx1@kernel.org>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <YL0+Jargm+y9aqx1@kernel.org>
Message-ID: <481056ab-686e-9f42-3b8a-b31941f58af6@huawei.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-13"
Content-Transfer-Encoding: quoted-printable
To: openrisc@lists.librecores.org


On 2021/6/7 5:29, Mike Rapoport wrote:
> Hello Kefeng,
>
> On Fri, Jun 04, 2021 at 03:06:18PM +0800, Kefeng Wang wrote:
>> Add setup_initial_init_mm() helper, then use it
>> to cleanup the text, data and brk setup code.
>>
>> v2:
>> - change argument from "char *" to "void *" setup_initial_init_mm()
>>    suggested by Geert Uytterhoeven
>> - use NULL instead of (void *)0 on h8300 and m68k
>> - collect ACKs
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
>> Kefeng Wang (15):
>>    mm: add setup_initial_init_mm() helper
>>    arc: convert to setup_initial_init_mm()
>>    arm: convert to setup_initial_init_mm()
>>    arm64: convert to setup_initial_init_mm()
>>    csky: convert to setup_initial_init_mm()
>>    h8300: convert to setup_initial_init_mm()
>>    m68k: convert to setup_initial_init_mm()
>>    nds32: convert to setup_initial_init_mm()
>>    nios2: convert to setup_initial_init_mm()
>>    openrisc: convert to setup_initial_init_mm()
>>    powerpc: convert to setup_initial_init_mm()
>>    riscv: convert to setup_initial_init_mm()
>>    s390: convert to setup_initial_init_mm()
>>    sh: convert to setup_initial_init_mm()
>>    x86: convert to setup_initial_init_mm()
> I might be missing something, but AFAIU the init_mm.start_code and other
> fields are not used really early so the new setup_initial_init_mm()
> function can be called in the generic code outside setup_arch(), e.g in
> mm_init().

Hi Mike=EF=BC=8C each architecture has their own value, not the same, eg m6=
8K and

h8300, also the name of the text/code/brk is different in some arch, so=20
I keep

unchanged.

>  =20
>>   arch/arc/mm/init.c                 | 5 +----
>>   arch/arm/kernel/setup.c            | 5 +----
>>   arch/arm64/kernel/setup.c          | 5 +----
>>   arch/csky/kernel/setup.c           | 5 +----
>>   arch/h8300/kernel/setup.c          | 5 +----
>>   arch/m68k/kernel/setup_mm.c        | 5 +----
>>   arch/m68k/kernel/setup_no.c        | 5 +----
>>   arch/nds32/kernel/setup.c          | 5 +----
>>   arch/nios2/kernel/setup.c          | 5 +----
>>   arch/openrisc/kernel/setup.c       | 5 +----
>>   arch/powerpc/kernel/setup-common.c | 5 +----
>>   arch/riscv/kernel/setup.c          | 5 +----
>>   arch/s390/kernel/setup.c           | 5 +----
>>   arch/sh/kernel/setup.c             | 5 +----
>>   arch/x86/kernel/setup.c            | 5 +----
>>   include/linux/mm_types.h           | 8 ++++++++
>>   16 files changed, 23 insertions(+), 60 deletions(-)
>>
>> --=20
>> 2.26.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
