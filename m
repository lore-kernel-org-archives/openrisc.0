From: Stafford Horne <shorne@gmail.com>
Date: Tue, 22 May 2018 20:56:13 +0900
Subject: [OpenRISC] problems debugging
In-Reply-To: <165182593-7748@mail.famsneijers.nl>
References: <CAAfxs77tq6-+wTG2mS9ezURGbto_A6fA4X1Q7VvvN30ymdS33w@mail.gmail.com>
 <165182593-7748@mail.famsneijers.nl>
Message-ID: <20180522115613.GM3652@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 22, 2018 at 01:20:05PM +0200, Wesley Sneijers wrote:
> 
> Hi,
> 
> I am currently using version 8.1.50.20180203-git of GDB. Indeed I am running a
> C program (I added the comment about R1 to point out that I checked the
> registers). Since I posted the problem I've gotten a bit further in tracking
> down the cause. I now think it is a problem with the espresso / pronto
> espresso variants. It seems like there is an issue between the softcore and
> the debugging hardware. I made an issue on github about it
> (https://github.com/openrisc/mor1kx/issues/60). The result is that all
> registers read by GDB return 0 (I'm sure they aren't). When I use the
> cappuccino variant this problem does not exist.

This explains it, I just had a look at the _espresso core and cant really see
its missing anything.  If you are up for debugging the RTL you can try probing
the du_* signals in mor1kx_ctrl_espresso.v.

Or you can try an ping some of the authors to see if someone picks up the github
issue.

> Back to your questions. It is possible to read / write to memory using GDB.
> Also the values returned are correct. The registers themselves are set to
> correct values (validated using simulation and running same C code with
> cappuccino). I read through the steps on the debugging page. The steps
> accessing memory all work. However when reading out registers from the
> register file (R1 etc.) they return 0.
> 
I think we will need to figure out why you cant read registers.  Its important
for debugging.

-Stafford
