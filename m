From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 9 Apr 2021 12:20:49 +0200
Subject: [OpenRISC] [PATCH v4 18/20] x86: Convert to GENERIC_CMDLINE
In-Reply-To: <20210408194148.GB1724284@robh.at.kernel.org>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <ab0fd4477964cdbf99e3dd2965a455aa3e738e4b.1617375802.git.christophe.leroy@csgroup.eu>
 <20210408194148.GB1724284@robh.at.kernel.org>
Message-ID: <834c4850-5541-b5c2-0b7b-d7d960ab2629@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 08/04/2021 à 21:41, Rob Herring a écrit :
> On Fri, Apr 02, 2021 at 03:18:20PM +0000, Christophe Leroy wrote:
>> This converts the architecture to GENERIC_CMDLINE.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/x86/Kconfig        | 45 ++---------------------------------------
>>   arch/x86/kernel/setup.c | 17 ++--------------
>>   2 files changed, 4 insertions(+), 58 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index a20684d56b4b..66b384228ca3 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -104,6 +104,7 @@ config X86
>>   	select ARCH_USE_QUEUED_SPINLOCKS
>>   	select ARCH_USE_SYM_ANNOTATIONS
>>   	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>> +	select ARCH_WANT_CMDLINE_PREPEND_BY_DEFAULT
> 
> Seems to be non-existent kconfig option.

Oops. Added in v5.

>> @@ -883,18 +881,7 @@ void __init setup_arch(char **cmdline_p)
>>   	bss_resource.start = __pa_symbol(__bss_start);
>>   	bss_resource.end = __pa_symbol(__bss_stop)-1;
>>   
>> -#ifdef CONFIG_CMDLINE_BOOL
>> -#ifdef CONFIG_CMDLINE_FORCE
>> -	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>> -#else
>> -	if (builtin_cmdline[0]) {
>> -		/* append boot loader cmdline to builtin */
>> -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
>> -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>> -		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>> -	}
>> -#endif
>> -#endif
>> +	cmdline_build(boot_command_line, boot_command_line);
>>   
>>   	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>>   	*cmdline_p = command_line;
> 
> Once this is all done, I wonder if we can get rid of the strlcpy and
> perhaps also cmdline_p.
> 

It seems rather complicated, in init/main.c you have heavy manipulations of command lines which 
seems to be done in setup_command_line() which seems to add stuff in front of command lines, at the 
end we end up with several command lines:

/* Untouched saved command line (eg. for /proc) */
char *saved_command_line;
/* Command line for parameter parsing */
static char *static_command_line;
/* Untouched extra command line */
static char *extra_command_line;

Some of them come from the cmdline_p which others are from boot_command_line.

I think a cleanup on all that stuff would be worth it as a further step.
