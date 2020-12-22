From: Enrico Weigelt, metux IT consult <lkml@metux.net>
Date: Tue, 22 Dec 2020 21:14:19 +0100
Subject: [OpenRISC] [PATCH] arch: consolidate pm_power_off callback
In-Reply-To: <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
References: <20201222184510.19415-1-info@metux.net>
 <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
Message-ID: <2f1d53e9-0dbb-78ef-22d5-ab230438ddf0@metux.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 22.12.20 19:54, Geert Uytterhoeven wrote:

Hi,

> On Tue, Dec 22, 2020 at 7:46 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>> Move the pm_power_off callback into one global place and also add an
>> function for conditionally calling it (when not NULL), in order to remove
>> code duplication in all individual archs.
>>
>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> Thanks for your patch!
> 
>> --- a/arch/alpha/kernel/process.c
>> +++ b/arch/alpha/kernel/process.c
>> @@ -43,12 +43,6 @@
>>  #include "proto.h"
>>  #include "pci_impl.h"
>>
>> -/*
>> - * Power off function, if any
>> - */
>> -void (*pm_power_off)(void) = machine_power_off;
> 
> Assignments like these are lost in the conversion.

Yes, but this doesn't seem to be ever called anyways. (in arch/alpha)
And, BTW, letting it point to machine_power_off() doesn't make much
sense, since it's the arch's machine_power_off() function, who're
calling pm_power_off().

Actually, we could remove pm_power_off completely from here, assuming
nobody would *build* any drivers that register themselves into
pm_power_off.

If you feel better with it, I could post a patch that just removes
pm_power_off from arch/alpha.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info at metux.net -- +49-151-27565287
