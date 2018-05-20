From: Stafford Horne <shorne@gmail.com>
Date: Sun, 20 May 2018 11:54:54 +0900
Subject: [OpenRISC] OpenRISC - SPR_PICMR always 'OR-ing' the values
In-Reply-To: <CALAE4RoqNTXyGEUbV3LmonNcyA=o8toPhRrDS23w4W_Zg3z3qg@mail.gmail.com>
References: <CALAE4RoqNTXyGEUbV3LmonNcyA=o8toPhRrDS23w4W_Zg3z3qg@mail.gmail.com>
Message-ID: <20180520025454.GH3652@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, May 19, 2018 at 08:08:47PM -0300, Davidson Francis wrote:
> Hello Stafford,
> 
> I'm currently using or1k as a target CPU in an operating system that
> I'm working.
> It happens that I'm having some issues regarding the PICMR register: I realize
> that in the latest Qemu version (2.12) when I write into PICMR, the Qemu is
> actually 'OR-ing' the values (as I could note in target/openrisc/sys_helper.c
> file), so I can't mask an already enabled interrupt.
> 
> I don't know if this behaviour is expected and if so, I'm sorry, but this does
> not occurs in the or1ksim, so I thought this could be might an issue.

Hello, thanks for pointing this out.  It looks wrong to me too.  Have you tested
changing it to just `env->picmr = rb;`?

-Stafford
