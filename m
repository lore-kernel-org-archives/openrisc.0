From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Sun, 28 Jan 2018 22:31:02 +0200
Subject: [OpenRISC] Linux4 does not boot on Atlys SoC
In-Reply-To: <D07B6A366A7B448CBE61BFAA6BBCD03C@BAndViG>
References: <AB8A0ACF1D594E2A874B40F24E1C27E9@BAndViG>
 <D07B6A366A7B448CBE61BFAA6BBCD03C@BAndViG>
Message-ID: <CADzBsGM_4riVz67CyK=CssJHavTTv76SQG7vnMWh6BpKw2HaMg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

>If I remember correctly it isn't possible to force simulation of atomic instructions at compile time in Linux-4.x. Instead, Linux-4.x should switch on such simulation by appropriate "instruction invalid" exception. However, it looks like the approach works in Stafford's development
> environment (I mean QEMU), but doesn't in HW- implemented pipe.

I tested the implementation that I did (that Stafford then improved)
on hardware, but that was many moons ago.

On Sun, Jan 28, 2018 at 9:22 PM, BAndViG <bandvig@mail.ru> wrote:
> It looks like it is definitely a problem with lwa/swa implementation in
> CAPPUCCINO.
> I'm working  with pseudo- clock domain crossing support for MAROCCHINO
> pipeline  (https://github.com/bandvig/mor1kx/tree/wb_cdc_75). "Pseudo" means
> two assumptions (1) core clock must be greater or equal to Wishbone clock
> and (2) core clock and Wishbone clock must be aligned. Almost all things are
> implemented for multi-core support. In fact just DCACHE snoop is the rest.
> Atomic instructions are already implemented and I've tested them in single
> core SoC (modified Atlys SoC) with successful run of Linux-4.15.
>
>
> BR
> Andrey Bacherov
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
