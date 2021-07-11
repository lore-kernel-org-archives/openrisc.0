From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date: Sun, 11 Jul 2021 10:36:32 +0200
Subject: [OpenRISC] Maybe another or1k bug
In-Reply-To: <YOdxwtNeQ2eUr+L3@antec>
References: <YOdxwtNeQ2eUr+L3@antec>
Message-ID: <D68EB4FF-538F-4FF1-ACFC-24AFEB098314@benettiengineering.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi Stafford, All,

> Il giorno 8 lug 2021, alle ore 23:44, Stafford Horne <shorne@gmail.com> ha scritto:
> 
> ﻿On Wed, Jul 07, 2021 at 02:25:39PM -0700, Richard Henderson wrote:
>>> On 7/7/21 2:06 PM, Stafford Horne wrote:
>>> +CC Richards other account
>>> 
>>> Hi Richard,
>>> 
>>> I Cced this to you twiddle.net account you on this one originally. Do you recall
>>> why we added the below check in or1k bfd?  It seems to be overly restrictive and
>>> causing some issues below.
>>> 
>>>  case R_OR1K_INSN_REL_26:
>>>    if (bfd_link_pic (info) && !SYMBOL_REFERENCES_LOCAL (info, h))
>>>      ERROR
>> ...
>>>> 4. The symbols are from `readelf -s`:
>>>> 
>>>>    221: 00008ce4   716 FUNC    GLOBAL PROTECTED   24 alSourcePausev
>>>>    222: 00008fb0    36 FUNC    GLOBAL PROTECTED   24 alSourcePause
>>>>    223: 00008fd4   784 FUNC    GLOBAL PROTECTED   24 alSourceStopv
>>>>    224: 000092e4    36 FUNC    GLOBAL PROTECTED   24 alSourceStop
>>>>    225: 00009308   720 FUNC    GLOBAL PROTECTED   24 alSourceRewindv
>>>>    226: 000095d8    36 FUNC    GLOBAL PROTECTED   24 alSourceRewind
>> 
>> Ah, STV_PROTECTED.  Unusual.
>> 
>> It looks like this should be SYMBOL_CALLS_LOCAL.  The only difference from
>> SYMBOL_REFERENCES_LOCAL is versus protected symbols.
> 
> Thanks Richard.
> 
> I will post a patch for this in a few days.  Or, maybe Giulio can do it if he
> has time.

Substituting SYMBOL_REFERENCES_LOCAL with SYMBOL_CALLS_LOCAL fixes the problem.
Only one thing, is it valid for every case in that switch or must it be only for R_OR1K_INSN_REL_26?

I’ve built and entire buildroot system with all cases with that new condition and it builds successfully.

Please let me know so I can send a patch for this.

Thank you and
Best regards
Giulio Benetti
