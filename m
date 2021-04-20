From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Tue, 20 Apr 2021 18:05:44 +0200
Subject: [OpenRISC] [PATCH v4 19/20] mips: Convert to GENERIC_CMDLINE
In-Reply-To: <20210409012349.GG3981976@zorba>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
 <20210406173836.GW2469518@zorba>
 <20210408190408.GA1724284@robh.at.kernel.org>
 <20210409012349.GG3981976@zorba>
Message-ID: <d92f99bf-20b7-a4b6-3d86-5b859e42cad8@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 09/04/2021 à 03:23, Daniel Walker a écrit :
> On Thu, Apr 08, 2021 at 02:04:08PM -0500, Rob Herring wrote:
>> On Tue, Apr 06, 2021 at 10:38:36AM -0700, Daniel Walker wrote:
>>> On Fri, Apr 02, 2021 at 03:18:21PM +0000, Christophe Leroy wrote:
>>>> -config CMDLINE_BOOL
>>>> -	bool "Built-in kernel command line"
>>>> -	help
>>>> -	  For most systems, it is firmware or second stage bootloader that
>>>> -	  by default specifies the kernel command line options.  However,
>>>> -	  it might be necessary or advantageous to either override the
>>>> -	  default kernel command line or add a few extra options to it.
>>>> -	  For such cases, this option allows you to hardcode your own
>>>> -	  command line options directly into the kernel.  For that, you
>>>> -	  should choose 'Y' here, and fill in the extra boot arguments
>>>> -	  in CONFIG_CMDLINE.
>>>> -
>>>> -	  The built-in options will be concatenated to the default command
>>>> -	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
>>>> -	  command line will be ignored and replaced by the built-in string.
>>>> -
>>>> -	  Most MIPS systems will normally expect 'N' here and rely upon
>>>> -	  the command line from the firmware or the second-stage bootloader.
>>>> -
>>>
>>>
>>> See how you complained that I have CMDLINE_BOOL in my changed, and you think it
>>> shouldn't exist.
>>>
>>> Yet here mips has it, and you just deleted it with no feature parity in your
>>> changes for this.
>>
>> AFAICT, CMDLINE_BOOL equates to a non-empty or empty CONFIG_CMDLINE. You
>> seem to need it just because you have CMDLINE_PREPEND and
>> CMDLINE_APPEND. If that's not it, what feature is missing? CMDLINE_BOOL
>> is not a feature, but an implementation detail.
> 
> Not true.
> 
> It makes it easier to turn it all off inside the Kconfig , so it's for usability
> and multiple architecture have it even with just CMDLINE as I was commenting
> here.
> 

Among the 13 architectures having CONFIG_CMDLINE, todayb only 6 have a CONFIG_CMDLINE_BOOL in addition:

arch/arm/Kconfig:config CMDLINE
arch/arm64/Kconfig:config CMDLINE
arch/hexagon/Kconfig:config CMDLINE
arch/microblaze/Kconfig:config CMDLINE
arch/mips/Kconfig.debug:config CMDLINE
arch/nios2/Kconfig:config CMDLINE
arch/openrisc/Kconfig:config CMDLINE
arch/powerpc/Kconfig:config CMDLINE
arch/riscv/Kconfig:config CMDLINE
arch/sh/Kconfig:config CMDLINE
arch/sparc/Kconfig:config CMDLINE
arch/x86/Kconfig:config CMDLINE
arch/xtensa/Kconfig:config CMDLINE

arch/microblaze/Kconfig:config CMDLINE_BOOL
arch/mips/Kconfig.debug:config CMDLINE_BOOL
arch/nios2/Kconfig:config CMDLINE_BOOL
arch/sparc/Kconfig:config CMDLINE_BOOL
arch/x86/Kconfig:config CMDLINE_BOOL
arch/xtensa/Kconfig:config CMDLINE_BOOL


In the begining I hesitated about the CMDLINE_BOOL, at the end I decided to go the same way as what 
is done today in the kernel for initramfs with CONFIG_INITRAMFS_SOURCE.

The problem I see within adding CONFIG_CMDLINE_BOOL for every architecture which don't have it today 
is that when doing a "make oldconfig" on their custom configs, thousands of users will loose their 
CMDLINE without notice.

When we do the other way round, removing CONFIG_CMDLINE_BOOL on the 6 architectures that have it 
today will have no impact on existing config.

Also, in order to avoid tons of #ifdefs in the code as mandated by Kernel Codying Style §21, we have 
to have CONFIG_CMDLINE defined at all time, so at the end CONFIG_CMDLINE_BOOL is really redundant 
with an empty CONFIG_CMDLINE.

Unlike you, the approach I took for my series is to minimise the impact on existing implementation 
and existing configurations as much as possible.

I know you have a different approach where you break every existing config anyway.

https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation

Christophe
