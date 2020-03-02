From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 2 Mar 2020 16:07:27 +0530
Subject: [OpenRISC] [PATCH] mm/special: Create generic fallbacks for
 pte_special() and pte_mkspecial()
In-Reply-To: <CAMuHMdXnUeYib2dMALyzrW8LKhTjsnGFsqALoTxVHzPGc+OUTg@mail.gmail.com>
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
 <CAMuHMdXnUeYib2dMALyzrW8LKhTjsnGFsqALoTxVHzPGc+OUTg@mail.gmail.com>
Message-ID: <02997860-9374-28b9-8703-dc9b62b3f8ff@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


On 03/02/2020 01:49 PM, Geert Uytterhoeven wrote:
> Hi Anshuman,
> 
> Thanks for your patch!
> 
> On Mon, Mar 2, 2020 at 2:56 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> Currently there are many platforms that dont enable HAVE_ARCH_PTE_SPECIAL
> ARCH_HAS_PTE_SPECIAL
> 
>> but required to define quite similar fallback stubs for special page table
>> entry helpers such as pte_special() and pte_mkspecial(), as they get build
>> in generic MM without a config check. This creates two generic fallback
>> stub definitions for these helpers, eliminating much code duplication.
>>
>> mips platform has a special case where pte_special() and pte_mkspecial()
>> visibility is wider than what HAVE_ARCH_PTE_SPECIAL enablement requires.
> ARCH_HAS_PTE_SPECIAL
> 

Oops, will fix it. I have been juggling between too many HAVE_ARCH_* and
ARCH_HAS_* lately :)
