From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 19 Jul 2018 08:41:04 +0900
Subject: [OpenRISC] [PATCH 0/6] kbuild: clean-up and rename LDFLAGS to
	KBUILD_LDFLAGS
In-Reply-To: <20180712140539.4b5xdraq34i5dbii@kshutemo-mobl1>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
 <20180712140539.4b5xdraq34i5dbii@kshutemo-mobl1>
Message-ID: <CAK7LNAThEpLsFgD_pv4ZgLWfbXcNPBiPEU7qZ5ah_R=x8LQA0w@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

2018-07-12 23:05 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
> On Thu, Jul 12, 2018 at 05:01:30PM +0900, Masahiro Yamada wrote:
>>
>> This series renames LDFLAGS to KBUILD_LDFLAGS
>> after some Makefile cleanups.
>>
>> Currently, the last patch does not apply to Linus' tree
>> due to missing pre-requisite patches.
>>
>> I will resolve conflicts as needed.
>>
>>
>>
>> Masahiro Yamada (6):
>>   um: remove redundant 'export LDFLAGS' in arch/x86/Makefile.um
>>   ARM: vfp: clean-up arch/arm/vfp/Makefile
>>   kbuild: remove redundant LDFLAGS clearing in arch/*/Makefile
>>   kbuild: replace $(LDFLAGS) $(ldflags-y) with $(ld_flags)
>>   kbuild: change ld_flags to contain LDFLAGS_$(@F)
>>   kbuild: rename LDFLAGS to KBUILD_LDFLAGS
>
> Thanks! Looks sane to me
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>


Patch 1, 3, 4, 5 applied to linux-kbuild.



-- 
Best Regards
Masahiro Yamada
