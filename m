From: Stafford Horne <shorne@gmail.com>
Date: Thu, 13 Sep 2018 13:49:40 +0900
Subject: [OpenRISC] OpenRISC GCC requirements
In-Reply-To: <20180908002922.GL4594@lianli.shorne-pla.net>
References: <CAAfxs77YuyjFts4h1ZECHoCV=kw3Y2LGy9k8dVQ_i9v1HobD_A@mail.gmail.com>
 <3bf53e07-2a8b-eae8-6a70-aa81f5c86b32@sholland.org>
 <20180908002922.GL4594@lianli.shorne-pla.net>
Message-ID: <CAAfxs74a5NjKrpVPLnYX1=w=wS8Cirn6CMTvoFuvuZ0_YSmj8Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Sep 8, 2018 at 9:29 AM, Stafford Horne <shorne@gmail.com> wrote:
> On Fri, Sep 07, 2018 at 05:29:09PM -0500, Samuel Holland wrote:

>> Looking at or1k.md, you used l.msync and l.ror, and l.sf*i as well. And l.cmov
>> and l.sf*i are also used in the libgcc implementation. Those also need to be
>> considered.
[...]
> Thanks for the details.  I didnt know it was such a large set of cores missing
> those instructions.

Hello,

I have posted a few patches to allow enabling of the class2
instructions (disabled by default).  To view the changes so far see:

     https://github.com/stffrdhrn/gcc/commits/or1k-port-1

Currently the architecture related openrisc gcc arguments are:

    -mclass2 - enable class 2 instructions (other than div/mul)
    -mhard-div - enable hardware divide instruction
    -mhard-mul - enable hardware multiply instruction

I couldn't really think of a good way to go about the naming, so that
is what I came up with.

Also, currently I didn't not add mclass2 as a 'multilib' argument.  So
libgcc will build with class2 instructions disabled.  If enabled it
would mean we would generate 8 versions of libgcc.  Maybe thats fine.
Anyone have opinions?

-Stafford
