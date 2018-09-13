From: BAndViG <bandvig@mail.ru>
Date: Thu, 13 Sep 2018 20:56:59 +0300
Subject: [OpenRISC] OpenRISC GCC requirements
In-Reply-To: <CAAfxs74a5NjKrpVPLnYX1=w=wS8Cirn6CMTvoFuvuZ0_YSmj8Q@mail.gmail.com>
References: <CAAfxs77YuyjFts4h1ZECHoCV=kw3Y2LGy9k8dVQ_i9v1HobD_A@mail.gmail.com>
 <3bf53e07-2a8b-eae8-6a70-aa81f5c86b32@sholland.org>
 <20180908002922.GL4594@lianli.shorne-pla.net>
 <CAAfxs74a5NjKrpVPLnYX1=w=wS8Cirn6CMTvoFuvuZ0_YSmj8Q@mail.gmail.com>
Message-ID: <5452543D6EF34B21985854C2E5DC1200@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

>Currently the architecture related openrisc gcc arguments are:

>    -mclass2 - enable class 2 instructions (other than div/mul)
>    -mhard-div - enable hardware divide instruction
>    -mhard-mul - enable hardware multiply instruction

What about to follow the approach implemented in current GCC? I.e. use 
separate options: -mcmov, -mror, -msext, and additional to 
them: -mmac, -madrp. For example, various "multiply-accumulate" instructions 
are also Class-II, however I doubt that they are implemented elsewhere than 
simulator. I think, multilib configuration could be given just as a 
relatively simple example (with short list of variants) in commentaries in 
appropriate file ("gcc/config/or1k/t-or1k" if I remember correctly) , while 
default should be minimum set (i.e. just class-I).

WBR
Andrey

