From: BAndViG <bandvig@mail.ru>
Date: Sun, 28 Jan 2018 22:22:54 +0300
Subject: [OpenRISC] Linux4 does not boot on Atlys SoC
In-Reply-To: <AB8A0ACF1D594E2A874B40F24E1C27E9@BAndViG>
References: <AB8A0ACF1D594E2A874B40F24E1C27E9@BAndViG>
Message-ID: <D07B6A366A7B448CBE61BFAA6BBCD03C@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

It looks like it is definitely a problem with lwa/swa implementation in 
CAPPUCCINO.
I'm working  with pseudo- clock domain crossing support for MAROCCHINO 
pipeline  (https://github.com/bandvig/mor1kx/tree/wb_cdc_75). "Pseudo" means 
two assumptions (1) core clock must be greater or equal to Wishbone clock 
and (2) core clock and Wishbone clock must be aligned. Almost all things are 
implemented for multi-core support. In fact just DCACHE snoop is the rest. 
Atomic instructions are already implemented and I've tested them in single 
core SoC (modified Atlys SoC) with successful run of Linux-4.15.

BR
Andrey Bacherov 

