From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 2 Apr 2021 17:19:02 +0200
Subject: [OpenRISC] [PATCH v3 05/17] arm: Convert to GENERIC_CMDLINE
In-Reply-To: <CAL_Jsq+LF-s5K4Jwd5jCHrU8271L5WCiGb0tR7aTUa8ddHF1YQ@mail.gmail.com>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <7362e4f6a5f5b79e6ad3fd3cec3183a4a283f7fc.1616765870.git.christophe.leroy@csgroup.eu>
 <CAL_Jsq+LF-s5K4Jwd5jCHrU8271L5WCiGb0tR7aTUa8ddHF1YQ@mail.gmail.com>
Message-ID: <f0ef9e09-982a-e44a-1a5f-0dd56a151789@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 26/03/2021 à 16:47, Rob Herring a écrit :
> On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>> This converts the architecture to GENERIC_CMDLINE.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/arm/Kconfig              | 38 +----------------------------------
>>   arch/arm/kernel/atags_parse.c | 15 +++++---------
>>   2 files changed, 6 insertions(+), 47 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 5da96f5df48f..67bc75f2da81 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -50,6 +50,7 @@ config ARM
>>          select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
>>          select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
>>          select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>> +       select GENERIC_CMDLINE if ATAGS
> 
> Don't we need this enabled for !ATAGS (i.e. DT boot)?
> 
> Can we always enable GENERIC_CMDLINE for OF_EARLY_FLATTREE?
> 

Done in v4
