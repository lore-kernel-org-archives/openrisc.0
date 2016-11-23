From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:14 +0900
Subject: [OpenRISC] [PATCH 00/18] sim: port for OpenRISC
Message-ID: <1479939272-1754-1-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Please find attached the sim patches that allow to get a basic OpenRISC
system running.  This was used to verify the OpenRISC gdb port. 

The main author is Peter Gavin who should have his FSF copyright in place.

Also some new tests were added specifically for openrisc. Please see the 
details of running the testsuite for sim below:

=== sim Summary ===

# of expected passes            17
/home/shorne/work/openrisc/build-gdb/sim/or1k/run 0.5

Thanks,
-Stafford

Peter Gavin (11):
  sim: cgen: add rem (remainder) function (needed for OR1K lf.rem.[sd])
  sim: cgen: add mul-o1flag, mul-o2flag RTL functions to CGEN
  sim: cgen: allow suffix on generated arch.[ch] and cpuall.h
  sim: or1k: add or1k target to sim
  sim: or1k: add NOP_EXIT_SILENT; make simulator print exit code for
    NOP_EXIT;
  sim: or1k: fix branching and exceptions in sim
  sim: or1k: remove erroneous warning message in sim/or1k/or1k.c
  sim: or1k: fix fl1 in sim
  sim: or1k: regenerate sim files
  sim: testsuite: add testsuite for or1k sim
  sim: or1k: fix segfault when run without arguments

Stafford Horne (7):
  sim: or1k: Get or1k sim building with latest sim common
  sim: or1k: Regenerate cgen files
  sim: or1k: Regenerate autotool files
  sim: or1k: Implement register store/fetch
  sim: or1k: Do trap breakpoint handling
  sim: or1k: Implement fetch/store for ppc and sr
  sim: or1k: add additional stubs for linux build


