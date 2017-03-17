From: Stafford Horne <shorne@gmail.com>
Date: Fri, 17 Mar 2017 14:39:06 +0900
Subject: [OpenRISC] [PATCH v3 0/5] sim port for OpenRISC
Message-ID: <cover.1489728532.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Again,

Please find attached the sim patches that allow to get a basic OpenRISC
system running.  This was used to verify the OpenRISC gdb port.

The main author is Peter Gavin who should have his FSF copyright in place.

Request for comments on:
 - The testcase has a few tests commented out. I do not plan to fix now,
   but hopefully be addressed after upstreaming.
 - Openrisc supports a l.rem instruction which has been implemented here
   using the drem() function from libmath.  It seems no other functions use
   libmath now, I hope this is ok.

Sim dejagnu tests were added specifically for openrisc and used to test
this.  Please see the details of running the testsuite for sim below:

=== sim Summary ===

# of expected passes            17
/home/shorne/work/openrisc/build-gdb/sim/or1k/run 0.5

Thanks,
-Stafford

Changes since v2
 * Removed 64-bit implementation (reduced files)
 * Removed cgen suffix patch
 * Removed different builds for linux
 * Removed unused macros
 * Fixed gnu style issues pointed out by Mike
 * Fixed copyrights (not Cygnus, added to each file)

Changes since v1
 * Squashed sim patches into single sim patch
 * Put Generated files in separate patch
 * I have my sim/gdb copyright assignment complete


Peter Gavin (3):
  sim: cgen: add rem (remainder) function (needed for OR1K lf.rem.[sd])
  sim: cgen: add mul-o1flag, mul-o2flag RTL functions to CGEN
  sim: testsuite: add testsuite for or1k sim

Stafford Horne (2):
  sim: or1k: add or1k target to sim
  sim: or1k: Add generated files.

