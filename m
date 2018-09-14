From: Stafford Horne <shorne@gmail.com>
Date: Fri, 14 Sep 2018 09:43:22 +0900
Subject: [OpenRISC] OpenRISC GCC requirements
In-Reply-To: <5452543D6EF34B21985854C2E5DC1200@BAndViG>
References: <CAAfxs77YuyjFts4h1ZECHoCV=kw3Y2LGy9k8dVQ_i9v1HobD_A@mail.gmail.com>
 <3bf53e07-2a8b-eae8-6a70-aa81f5c86b32@sholland.org>
 <20180908002922.GL4594@lianli.shorne-pla.net>
 <CAAfxs74a5NjKrpVPLnYX1=w=wS8Cirn6CMTvoFuvuZ0_YSmj8Q@mail.gmail.com>
 <5452543D6EF34B21985854C2E5DC1200@BAndViG>
Message-ID: <CAAfxs74t+dWRK6ydHY3d+6rNOHFGHF0RkGP4AqZ4HmZDTVVxuw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Sep 14, 2018, 2:57 AM BAndViG <bandvig@mail.ru> wrote:

> >Currently the architecture related openrisc gcc arguments are:
>
> >    -mclass2 - enable class 2 instructions (other than div/mul)
> >    -mhard-div - enable hardware divide instruction
> >    -mhard-mul - enable hardware multiply instruction
>
> What about to follow the approach implemented in current GCC? I.e. use
> separate options: -mcmov, -mror, -msext, and additional to
> them: -mmac, -madrp. For example, various "multiply-accumulate"
> instructions
> are also Class-II, however I doubt that they are implemented elsewhere
> than
> simulator. I think, multilib configuration could be given just as a
> relatively simple example (with short list of variants) in commentaries in
> appropriate file ("gcc/config/or1k/t-or1k" if I remember correctly) ,
> while
> default should be minimum set (i.e. just class-I).
>

Thanks,

That makes sense.  My though was to first have the mclass2 blanket argument
to enable everything.  Then, if anyone wants to have instruction specific
switches it should be pretty easy to add.  So I don't plan to add at first.
Is that fair?

One thing I will do now is expose these via configure as suggested by
Samuel. I.e. ./configure --enable-class2.

Note, my most recent patches have cause a few hundred tests to fail. Please
use the releases from GitHub if you want to play with the toolchain.

-stafford
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180914/0f2b482f/attachment.html>
