From: Davidson Francis <davidsondfgl@gmail.com>
Date: Sun, 20 May 2018 00:31:50 -0300
Subject: [OpenRISC] OpenRISC - SPR_PICMR always 'OR-ing' the values
In-Reply-To: <20180520025454.GH3652@lianli.shorne-pla.net>
References: <CALAE4RoqNTXyGEUbV3LmonNcyA=o8toPhRrDS23w4W_Zg3z3qg@mail.gmail.com>
 <20180520025454.GH3652@lianli.shorne-pla.net>
Message-ID: <CALAE4RpKFttWOBaw-15bTKsU4LG=h6K=K9=U08ThDsGieSJ1=g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Thank you for quick reply,

Yes, I've tried, after that, the register works as expected, but even so, if I
enable the interrupts right after, I still receive interrupts from the same IRQ,
but maybe there is something wrong with my code.

Regards,
Davidson Francis.

2018-05-19 23:54 GMT-03:00 Stafford Horne <shorne@gmail.com>:
> On Sat, May 19, 2018 at 08:08:47PM -0300, Davidson Francis wrote:
>> Hello Stafford,
>>
>> I'm currently using or1k as a target CPU in an operating system that
>> I'm working.
>> It happens that I'm having some issues regarding the PICMR register: I realize
>> that in the latest Qemu version (2.12) when I write into PICMR, the Qemu is
>> actually 'OR-ing' the values (as I could note in target/openrisc/sys_helper.c
>> file), so I can't mask an already enabled interrupt.
>>
>> I don't know if this behaviour is expected and if so, I'm sorry, but this does
>> not occurs in the or1ksim, so I thought this could be might an issue.
>
> Hello, thanks for pointing this out.  It looks wrong to me too.  Have you tested
> changing it to just `env->picmr = rb;`?
>
> -Stafford
