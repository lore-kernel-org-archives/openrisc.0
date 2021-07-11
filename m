From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date: Sun, 11 Jul 2021 15:41:12 +0200
Subject: [OpenRISC] Maybe another or1k bug
In-Reply-To: <16b3a02d-f749-0806-ed0f-df3ad7050bb3@linaro.org>
References: <16b3a02d-f749-0806-ed0f-df3ad7050bb3@linaro.org>
Message-ID: <6B8D2091-E973-4F7D-A4FE-41D03FAB2970@benettiengineering.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org


> Il giorno 11 lug 2021, alle ore 15:24, Richard Henderson <richard.henderson@linaro.org> ha scritto:
> 
> ﻿On 7/11/21 1:36 AM, Giulio Benetti wrote:
>> Substituting SYMBOL_REFERENCES_LOCAL with SYMBOL_CALLS_LOCAL fixes the problem.
>> Only one thing, is it valid for every case in that switch or must it be only for R_OR1K_INSN_REL_26?
> 
> Only for INSN_REL_26.

Perfect, I’m going to modify and submit soon.

Thank you
Giulio
