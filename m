From: Andrey Bacherov <bandvig@mail.ru>
Date: Sun, 24 May 2020 22:12:54 +0300
Subject: [OpenRISC] OpenRISC: User mode writing to FPCSR
In-Reply-To: <CAAfxs74qCX4HnA04XcSN1DxbAotNX4iLqUP5m5c-pvP5pn0z8g@mail.gmail.com>
References: <20200506220323.GB2550@lianli.shorne-pla.net>
 <652e3bb7-93aa-4310-e798-2258b00300af@mail.ru>
 <20200508221759.GB4359@lianli.shorne-pla.net>
 <CAAfxs74qCX4HnA04XcSN1DxbAotNX4iLqUP5m5c-pvP5pn0z8g@mail.gmail.com>
Message-ID: <96a984da-4053-6d83-423e-7c327e12c8d7@mail.ru>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


> FYI, I posted the proposal on the website here:
> 
> https://openrisc.io/proposals/p17-user-mode-fpcsr

I've got a note about current SPRs access implementation in CAPPUCCINO 
and MAROCCINO. In fact:
1) Any SPR could be read in user mode excluding SPRs in CAPPUCCINO's PCU.
2) Only FPCSR ans SR writes are protected by SR[SM] excluding SPRs in 
CAPPUCCINO's PCU again.

Initially we could implement user mode write access just for FPCSR as 
hot-fix.

Does it make sense to rename SUMRA to SUMA (SPRs User Mode Access)? To 
reflect the fact such access couldn't just for read.

WBR
Andrey


