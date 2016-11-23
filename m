From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 08:04:27 +0900 (JST)
Subject: [OpenRISC] [PATCH 00/18] sim: port for OpenRISC
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <alpine.LFD.2.20.1611240756460.29569@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


Hello,

Sorry, for the spam. Some of these sim patches are too large for the 
sourceware.org server and getting bounced with:

ezmlm-reject: fatal: Sorry, I don't accept messages larger than 400000 
bytes (#5.2.3)

I don't think I can really split them up:
   [PATCH 04/18] sim: or1k: add or1k target to sim
   [PATCH 14/18] sim: or1k: Regenerate autotool files

If you are interested, all patches are being staged in my github repo 
here:

https://github.com/stffrdhrn/binutils-gdb/commits/or1k-upstream

Also,

The following changes since commit 
ca3cbe5cd7715d1559d55f8e71be1dd7340f13b1:

   Fix spelling mistakes in comments in shell scripts (2016-11-22 16:05:00 
+0000)

are available in the git repository at:

   https://github.com/stffrdhrn/binutils-gdb.git

for you to fetch changes up to 42cbafbf5fc83efe133995121aa0c357939546e2:

   gdb: or1k: Refactor to new bp_kind_from_pc and pb_from_kind (2016-11-23 
18:47:43 +0900)

-Stafford

On Thu, 24 Nov 2016, Stafford Horne wrote:

> Hello,
>
> Please find attached the sim patches that allow to get a basic OpenRISC
> system running.  This was used to verify the OpenRISC gdb port.
>
> The main author is Peter Gavin who should have his FSF copyright in place.
>
> Also some new tests were added specifically for openrisc. Please see the
> details of running the testsuite for sim below:
>
> === sim Summary ===
>
> # of expected passes            17
> /home/shorne/work/openrisc/build-gdb/sim/or1k/run 0.5
>
> Thanks,
> -Stafford
>
> Peter Gavin (11):
>  sim: cgen: add rem (remainder) function (needed for OR1K lf.rem.[sd])
>  sim: cgen: add mul-o1flag, mul-o2flag RTL functions to CGEN
>  sim: cgen: allow suffix on generated arch.[ch] and cpuall.h
>  sim: or1k: add or1k target to sim
>  sim: or1k: add NOP_EXIT_SILENT; make simulator print exit code for
>    NOP_EXIT;
>  sim: or1k: fix branching and exceptions in sim
>  sim: or1k: remove erroneous warning message in sim/or1k/or1k.c
>  sim: or1k: fix fl1 in sim
>  sim: or1k: regenerate sim files
>  sim: testsuite: add testsuite for or1k sim
>  sim: or1k: fix segfault when run without arguments
>
> Stafford Horne (7):
>  sim: or1k: Get or1k sim building with latest sim common
>  sim: or1k: Regenerate cgen files
>  sim: or1k: Regenerate autotool files
>  sim: or1k: Implement register store/fetch
>  sim: or1k: Do trap breakpoint handling
>  sim: or1k: Implement fetch/store for ppc and sr
>  sim: or1k: add additional stubs for linux build
>
>

