From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Mon, 7 Jun 2021 07:48:54 +0200
Subject: [OpenRISC] [PATCH v2 00/15] init_mm: cleanup ARCH's
 text/data/brk setup code
In-Reply-To: <481056ab-686e-9f42-3b8a-b31941f58af6@huawei.com>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <YL0+Jargm+y9aqx1@kernel.org>
 <481056ab-686e-9f42-3b8a-b31941f58af6@huawei.com>
Message-ID: <006eb573-5a20-1ac7-6234-338d11346a08@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi Kefeng,

Le 07/06/2021 à 02:55, Kefeng Wang a écrit :
> 
> On 2021/6/7 5:29, Mike Rapoport wrote:
>> Hello Kefeng,
>>
>> On Fri, Jun 04, 2021 at 03:06:18PM +0800, Kefeng Wang wrote:
>>> Add setup_initial_init_mm() helper, then use it
>>> to cleanup the text, data and brk setup code.
>>>
>>> v2:
>>> - change argument from "char *" to "void *" setup_initial_init_mm()
>>>    suggested by Geert Uytterhoeven
>>> - use NULL instead of (void *)0 on h8300 and m68k
>>> - collect ACKs
>>>
>>> Cc: linux-snps-arc at lists.infradead.org
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-csky at vger.kernel.org
>>> Cc: uclinux-h8-devel at lists.sourceforge.jp
>>> Cc: linux-m68k at lists.linux-m68k.org
>>> Cc: openrisc at lists.librecores.org
>>> Cc: linuxppc-dev at lists.ozlabs.org
>>> Cc: linux-riscv at lists.infradead.org
>>> Cc: linux-sh at vger.kernel.org
>>> Cc: linux-s390 at vger.kernel.org
>>> Kefeng Wang (15):
>>>    mm: add setup_initial_init_mm() helper
>>>    arc: convert to setup_initial_init_mm()
>>>    arm: convert to setup_initial_init_mm()
>>>    arm64: convert to setup_initial_init_mm()
>>>    csky: convert to setup_initial_init_mm()
>>>    h8300: convert to setup_initial_init_mm()
>>>    m68k: convert to setup_initial_init_mm()
>>>    nds32: convert to setup_initial_init_mm()
>>>    nios2: convert to setup_initial_init_mm()
>>>    openrisc: convert to setup_initial_init_mm()
>>>    powerpc: convert to setup_initial_init_mm()
>>>    riscv: convert to setup_initial_init_mm()
>>>    s390: convert to setup_initial_init_mm()
>>>    sh: convert to setup_initial_init_mm()
>>>    x86: convert to setup_initial_init_mm()
>> I might be missing something, but AFAIU the init_mm.start_code and other
>> fields are not used really early so the new setup_initial_init_mm()
>> function can be called in the generic code outside setup_arch(), e.g in
>> mm_init().
> 
> Hi Mike， each architecture has their own value, not the same, eg m68K and
> 
> h8300, also the name of the text/code/brk is different in some arch, so I keep
> 
> unchanged.

What you could do is to define a __weak function that architectures can override and call that 
function from mm_init() as suggested by Mike,

Something like:

void __weak setup_initial_init_mm(void)
{
	init_mm.start_code = (unsigned long)_stext;
	init_mm.end_code = (unsigned long)_etext;
	init_mm.end_data = (unsigned long)_edata;
	init_mm.brk = (unsigned long)_end;
}

Then only the few architecture that are different would override it.

I see a few archictectures are usigne PAGE_OFFSET to set .start_code, but it is likely that this is 
equivalent to _stext.

Christophe
