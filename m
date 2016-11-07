From: Stefan Wallentowitz <stefan@wallentowitz.de>
Date: Mon, 7 Nov 2016 19:24:06 +0100
Subject: [OpenRISC] Nexys4DDR and OpenRISC
In-Reply-To: <CA+2xKH_FCLWPB_r=oP5OkCgttWrzWNeaz7bE0Gk5oos4LjQJGg@mail.gmail.com>
References: <CA+2xKH_FCLWPB_r=oP5OkCgttWrzWNeaz7bE0Gk5oos4LjQJGg@mail.gmail.com>
Message-ID: <62626c02-f6d5-acfa-9fb6-751d9fec76b5@wallentowitz.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 24.10.2016 16:56, Marcus Swift wrote:
> Hi all,
> 
> I am new to OpenRISC and have been attempting to use FuseSOC to build a
> system for the Nexys4DRR board.
> 
> [..]
>
> If anyone could point me in the right direction on getting an OpenRISC
> SOC to run on the nexys4ddr or in troubleshooting the above problems I
> would be very grateful!

Hi,

in OpTiMSoC we used Xilinx Vivado directly to generate the core. In my
humble opinion thats the most sane way. You end up with AXI ports then
unfortunately, but handling that in the proper clock domain is probably
easier than what you are facing and the "user interface" of MIG.

This is the fusesoc core file:
https://github.com/optimsoc/sources/blob/master/external/extra_cores/boards/nexys4ddr/nexys4ddr-ddr.core

The xci is what I generated in Vivado:
https://github.com/optimsoc/sources/blob/master/external/extra_cores/boards/nexys4ddr/ip/mig_7series.xci

And a data file comes along:
https://github.com/optimsoc/sources/blob/master/external/extra_cores/boards/nexys4ddr/ip/mig_config.prj

If anything needs to be changed, you should generate, customize and then
write back to the xci and prj files.

We then have an abstraction layer (sorry, this is something I plan to
extend and standardize for months now):
https://github.com/optimsoc/sources/blob/master/external/extra_cores/boards/nexys4ddr/rtl/verilog/nexys4ddr.sv

You can see the mig instantiated there. Beside that I have written a
very, very, very simple wb2axi, that does not support anything except
two-cycle accesses (no bursts). But that may be a good start and I would
be happy to assist extensions (planned: i. register, ii. bursts).

I hope that helps a little bit.

Cheers,
Stefan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20161107/6f5ae1d3/attachment.sig>
