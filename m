From: Stafford Horne <shorne@gmail.com>
Date: Wed, 30 Nov 2016 21:40:55 +0900 (JST)
Subject: [OpenRISC] [PATCH v2 0/9] openrisc: Misc fixes from backlog
In-Reply-To: <20161130012311.GA4833@roeck-us.net>
References: <1479130239-30707-1-git-send-email-shorne@gmail.com>
 <20161130012311.GA4833@roeck-us.net>
Message-ID: <alpine.LFD.2.20.1611301932290.29569@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On Tue, 29 Nov 2016, Guenter Roeck wrote:

> On Mon, Nov 14, 2016 at 10:30:30PM +0900, Stafford Horne wrote:
>> Hello,
>>
>> This patch is a small set of fixes from the openrisc backlog. These
>> changes fix several issues with the openrisc build on modern tool chains
>> and address other issues which have cropped up as the kernel has been
>> getting updated.
>>
>
> Do you plan to send those patches to Linus yourself, or do you want me to do it
> for you this time ? If so I'd ask for the patch series to be added to -next
> and send it to Linus after the commit window opens. Let me know.

Hi Guenter,

Thanks for following up. One of the members of the openrisc team was able 
to get his key signed recently [0].  But, it puts me at 4 levels from 
Linus, which may not be good enough for accepting pull requests. At the 
same time, I am working with one Japan kernel developer to get my key 
signed, but there was a minor issue when we met. I hope that can get 
resolved this friday when I meet again at Japan Technical Jamboree [1].

You might not be interested in all of that. I will do the following:

   1 Create for-next branch on the github openrisc/linux with my current
     patch set
   2 Send a mail to Stephen Rothwell for including in linux next
   3 When the merge window opens either the other OpenRISC maintainer or I
     will create a signed tag and send a pull reuest to linus.

If those done work we will ask you for help.

Thanks for your help,

-Stafford

[0] 
https://pgp.cs.uu.nl/mk_path.cgi?FROM=00411886&TO=5E6627E4&PATHS=trust+paths
[1] http://elinux.org/Japan_Technical_Jamboree_59

>> Consider for Pull:
>>
>> The following changes since commit a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6:
>>
>>   Linux 4.9-rc5 (2016-11-13 10:32:32 -0800)
>>
>> are available in the git repository at:
>>
>>   https://github.com/stffrdhrn/linux.git tags/or1k-fixes-4.9
>>
>> for you to fetch changes up to a9fae5563e34217ff99efafde7e7bf607a5d5ec6:
>>
>>   openrisc: include l.swa in check for write data pagefault (2016-11-14 21:58:33 +0900)
>>
>> Regards,
>>  Stafford
>>
>> Changes since V1:
>>  - Removed SMP option patch and replaced with NR_CPUS default value
>>  - Removed Apply transparent_union on semun patch as its handled by libc
>>  - Added memblock patch as suggested by Jonas
>>  - Added MAINTAINERS patch as suggested by Guenter
>>  - Added l.swa patch as its needed to fix musl programs
>>  - Improved commit message on rt_sigreturn patch
>>
>> Christian Svensson (1):
>>   openrisc: Add thread-local storage (TLS) support
>>
>> Guenter Roeck (1):
>>   openrisc: Support both old (or32) and new (or1k) toolchain
>>
>> Jonas Bonn (1):
>>   openrisc: restore all regs on rt_sigreturn
>>
>> Rob Herring (1):
>>   openrisc: remove the redundant of_platform_populate
>>
>> Stafford Horne (3):
>>   openrisc: add NR_CPUS Kconfig default value
>>   openrisc: Consolidate setup to use memblock instead of bootmem
>>   openrisc: Updates after openrisc.net has been lost
>>
>> Stefan Kristiansson (2):
>>   openrisc: fix PTRS_PER_PGD define
>>   openrisc: include l.swa in check for write data pagefault
>>
>>  MAINTAINERS                         |  6 +++--
>>  arch/openrisc/Kconfig               |  4 ++++
>>  arch/openrisc/README.openrisc       |  8 +++----
>>  arch/openrisc/TODO.openrisc         |  3 ---
>>  arch/openrisc/include/asm/pgalloc.h |  1 -
>>  arch/openrisc/include/asm/pgtable.h |  2 +-
>>  arch/openrisc/kernel/entry.S        | 12 ++++++++--
>>  arch/openrisc/kernel/process.c      | 13 ++++++++++
>>  arch/openrisc/kernel/setup.c        | 48 ++++++++++---------------------------
>>  arch/openrisc/kernel/vmlinux.lds.S  |  8 ++++++-
>>  arch/openrisc/mm/init.c             |  4 ++--
>>  arch/openrisc/mm/ioremap.c          |  4 ----
>>  12 files changed, 58 insertions(+), 55 deletions(-)
>>
>> --
>> 2.7.4
>>
>

