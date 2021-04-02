From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 2 Apr 2021 17:33:59 +0200
Subject: [OpenRISC] [PATCH v3 09/17] nios2: Convert to GENERIC_CMDLINE
In-Reply-To: <BY5PR11MB38934E74AF74D40379E46AB9CC7E9@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <85b1dc6339351cbc46d179e8fdb9dfc398e58303.1616765870.git.christophe.leroy@csgroup.eu>
 <BY5PR11MB38934E74AF74D40379E46AB9CC7E9@BY5PR11MB3893.namprd11.prod.outlook.com>
Message-ID: <18f89697-5612-6a1a-ab9d-8842c1b943db@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 29/03/2021 à 03:35, Tan, Ley Foon a écrit :
> 
> 
>> -----Original Message-----
>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Sent: Friday, March 26, 2021 9:45 PM
>> To: will at kernel.org; danielwa at cisco.com; robh at kernel.org;
>> daniel at gimpelevich.san-francisco.ca.us
>> Cc: linux-arch at vger.kernel.org; devicetree at vger.kernel.org; linuxppc-
>> dev at lists.ozlabs.org; linux-kernel at vger.kernel.org; linuxppc-
>> dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org; microblaze
>> <monstr@monstr.eu>; linux-mips at vger.kernel.org; Tan, Ley Foon
>> <ley.foon.tan@intel.com>; openrisc at lists.librecores.org; linux-
>> hexagon at vger.kernel.org; linux-riscv at lists.infradead.org; x86 at kernel.org;
>> linux-xtensa at linux-xtensa.org; linux-sh at vger.kernel.org;
>> sparclinux at vger.kernel.org
>> Subject: [PATCH v3 09/17] nios2: Convert to GENERIC_CMDLINE
>>
>> This converts the architecture to GENERIC_CMDLINE.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/nios2/Kconfig        | 24 +-----------------------
>>   arch/nios2/kernel/setup.c | 13 ++++---------
>>   2 files changed, 5 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig index
>> c24955c81c92..f66c97b15813 100644
>> --- a/arch/nios2/Kconfig
>> +++ b/arch/nios2/Kconfig
>> @@ -90,31 +90,9 @@ config NIOS2_ALIGNMENT_TRAP
>>
>>   comment "Boot options"
>>
>> -config CMDLINE_BOOL
>> -	bool "Default bootloader kernel arguments"
>> -	default y
>> -
>> -config CMDLINE
>> -	string "Default kernel command string"
>> -	default ""
>> -	depends on CMDLINE_BOOL
>> -	help
>> -	  On some platforms, there is currently no way for the boot loader to
>> -	  pass arguments to the kernel. For these platforms, you can supply
>> -	  some command-line options at build time by entering them here.  In
>> -	  other cases you can specify kernel args so that you don't have
>> -	  to set them up in board prom initialization routines.
>> -
>> -config CMDLINE_FORCE
>> -	bool "Force default kernel command string"
>> -	depends on CMDLINE_BOOL
>> -	help
>> -	  Set this to have arguments from the default kernel command string
>> -	  override those passed by the boot loader.
>> -
>>   config NIOS2_CMDLINE_IGNORE_DTB
>>   	bool "Ignore kernel command string from DTB"
>> -	depends on CMDLINE_BOOL
>> +	depends on CMDLINE != ""
>>   	depends on !CMDLINE_FORCE
>>   	default y
>>   	help
> 
> Missing " select GENERIC_CMDLINE" ?

Added in v4

Thanks
Christophe
