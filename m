From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Wed, 4 Mar 2020 10:49:13 +0530
Subject: [OpenRISC] [RFC 1/3] mm/vma: Define a default value for
 VM_DATA_DEFAULT_FLAGS
In-Reply-To: <b243be54-7b5e-c6e9-fb68-46369d7d7aa4@suse.cz>
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
 <1583131666-15531-2-git-send-email-anshuman.khandual@arm.com>
 <b243be54-7b5e-c6e9-fb68-46369d7d7aa4@suse.cz>
Message-ID: <8b0f4c1b-f693-e139-4f66-ee4e1e88b95c@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 03/03/2020 10:55 PM, Vlastimil Babka wrote:
> On 3/2/20 7:47 AM, Anshuman Khandual wrote:
>> There are many platforms with exact same value for VM_DATA_DEFAULT_FLAGS
>> This creates a default value for VM_DATA_DEFAULT_FLAGS in line with the
>> existing VM_STACK_DEFAULT_FLAGS. While here, also define some more macros
>> with standard VMA access flag combinations that are used frequently across
>> many platforms. Apart from simplification, this reduces code duplication
>> as well.
>>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Mark Salter <msalter@redhat.com>
>> Cc: Guo Ren <guoren@kernel.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Brian Cain <bcain@codeaurora.org>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: Paul Burton <paulburton@kernel.org>
>> Cc: Nick Hu <nickhu@andestech.com>
>> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Guan Xuetao <gxt@pku.edu.cn>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-alpha at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: linux-snps-arc at lists.infradead.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-c6x-dev at linux-c6x.org
>> Cc: uclinux-h8-devel at lists.sourceforge.jp
>> Cc: linux-hexagon at vger.kernel.org
>> Cc: linux-ia64 at vger.kernel.org
>> Cc: linux-m68k at lists.linux-m68k.org
>> Cc: linux-mips at vger.kernel.org
>> Cc: nios2-dev at lists.rocketboards.org
>> Cc: openrisc at lists.librecores.org
>> Cc: linux-parisc at vger.kernel.org
>> Cc: linuxppc-dev at lists.ozlabs.org
>> Cc: linux-riscv at lists.infradead.org
>> Cc: linux-s390 at vger.kernel.org
>> Cc: linux-sh at vger.kernel.org
>> Cc: sparclinux at vger.kernel.org
>> Cc: linux-um at lists.infradead.org
>> Cc: linux-xtensa at linux-xtensa.org
>> Cc: linux-mm at kvack.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nit:
> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index b0e53ef13ff1..7a764ae6ab68 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -342,6 +342,21 @@ extern unsigned int kobjsize(const void *objp);
>>  /* Bits set in the VMA until the stack is in its final location */
>>  #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
>>  
>> +#define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
>> +
>> +/* Common data flag combinations */
>> +#define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
>> +				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>> +#define VM_DATA_FLAGS_NON_EXEC	(VM_READ | VM_WRITE | VM_MAYREAD | \
>> +				 VM_MAYWRITE | VM_MAYEXEC)
>> +#define VM_DATA_FLAGS_EXEC	(VM_READ | VM_WRITE | VM_EXEC | \
>> +				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>> +
>> +#ifndef VM_DATA_DEFAULT_FLAGS		/* arch can override this */
>> +#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
>> +				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> 
> Should you use VM_DATA_FLAGS_EXEC here? Yeah one more macro to expand, but it's
> right above this.

Sure, can do that.

> 
>> +#endif
>> +
>>  #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
>>  #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
>>  #endif
>>
> 
> 
> 
