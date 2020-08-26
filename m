From: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 27 Aug 2020 00:33:05 +1000
Subject: [OpenRISC] [PATCH 14/24] openrisc: use
 asm-generic/mmu_context.h for no-op implementations
In-Reply-To: <20200729114554.GG80756@lianli.shorne-pla.net>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-15-npiggin@gmail.com>
 <20200729114554.GG80756@lianli.shorne-pla.net>
Message-ID: <1598452354.xwvdyvp4t6.astroid@bobo.none>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Excerpts from Stafford Horne's message of July 29, 2020 9:45 pm:
> On Tue, Jul 28, 2020 at 01:33:55PM +1000, Nicholas Piggin wrote:
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>> Cc: Stafford Horne <shorne@gmail.com>
>> Cc: openrisc at lists.librecores.org
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/openrisc/include/asm/mmu_context.h | 8 +++-----
>>  arch/openrisc/mm/tlb.c                  | 2 ++
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/openrisc/include/asm/mmu_context.h b/arch/openrisc/include/asm/mmu_context.h
>> index ced577542e29..a6702384c77d 100644
>> --- a/arch/openrisc/include/asm/mmu_context.h
>> +++ b/arch/openrisc/include/asm/mmu_context.h
>> @@ -17,13 +17,13 @@
>>  
>>  #include <asm-generic/mm_hooks.h>
>>  
>> +#define init_new_context init_new_context
>>  extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
>> +#define destroy_context destroy_context
>>  extern void destroy_context(struct mm_struct *mm);
>>  extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>  		      struct task_struct *tsk);
>>  
>> -#define deactivate_mm(tsk, mm)	do { } while (0)
>> -
>>  #define activate_mm(prev, next) switch_mm((prev), (next), NULL)
>>  
>>  /* current active pgd - this is similar to other processors pgd
>> @@ -32,8 +32,6 @@ extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>  
>>  extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fault.c */
>>  
>> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>> -{
>> -}
>> +#include <asm-generic/mmu_context.h>
> 
> This looks ok.
> 
>>  #endif
>> diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
>> index 4b680aed8f5f..821aab4cf3be 100644
>> --- a/arch/openrisc/mm/tlb.c
>> +++ b/arch/openrisc/mm/tlb.c
>> @@ -159,6 +159,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>   * instance.
>>   */
>>  
>> +#define init_new_context init_new_context
>>  int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>>  {
>>  	mm->context = NO_CONTEXT;
>> @@ -170,6 +171,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>>   * drops it.
>>   */
>>  
>> +#define destroy_context destroy_context
>>  void destroy_context(struct mm_struct *mm)
>>  {
>>  	flush_tlb_mm(mm);
> 
> I don't think we need the #define's in the .c file.  Do we?

You're right, I fixed that and the same issue in another arch.

Thanks,
Nick
