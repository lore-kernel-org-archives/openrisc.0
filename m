From: BAndViG <bandvig@mail.ru>
Date: Mon, 17 Sep 2018 21:44:11 +0300
Subject: [OpenRISC] OpenRISC GCC requirements
In-Reply-To: <CAAfxs74t+dWRK6ydHY3d+6rNOHFGHF0RkGP4AqZ4HmZDTVVxuw@mail.gmail.com>
References: <CAAfxs77YuyjFts4h1ZECHoCV=kw3Y2LGy9k8dVQ_i9v1HobD_A@mail.gmail.com>
 <3bf53e07-2a8b-eae8-6a70-aa81f5c86b32@sholland.org>
 <20180908002922.GL4594@lianli.shorne-pla.net>
 <CAAfxs74a5NjKrpVPLnYX1=w=wS8Cirn6CMTvoFuvuZ0_YSmj8Q@mail.gmail.com>
 <5452543D6EF34B21985854C2E5DC1200@BAndViG>
 <CAAfxs74t+dWRK6ydHY3d+6rNOHFGHF0RkGP4AqZ4HmZDTVVxuw@mail.gmail.com>
Message-ID: <36C30435CA9F4EE88B9DDD304398F854@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

>My though was to first have the mclass2 blanket argument to enable everything.  
>Then, if anyone wants to have instruction specific switches it should be pretty easy to add.  
>So I don't plan to add at first. Is that fair?

Yes, absolutely.

>One thing I will do now is expose these via configure as suggested by Samuel. 
>I.e. ./configure --enable-class2.

I think, it would be useful to implement similar ability for each “–m*” option. The approach is more elegant than editing source code to select default options configurations.

>Note, my most recent patches have cause a few hundred tests to fail. 
>Please use the releases from GitHub if you want to play with the toolchain.

It is exaclty which I do.

WBR
Andrey
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180917/845be244/attachment.html>
