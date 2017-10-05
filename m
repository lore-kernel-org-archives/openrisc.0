From: Stafford Horne <shorne@gmail.com>
Date: Thu, 5 Oct 2017 22:57:19 +0900
Subject: [OpenRISC] [PATCH v5 0/6] sim port for OpenRISC
In-Reply-To: <20171005134912.26799-1-shorne@gmail.com>
References: <20171005134912.26799-1-shorne@gmail.com>
Message-ID: <20171005135719.GA2630@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

In case people are looking for it the patch [5/6] containing a 16k line
generated configure script was dropped my the mta.

Please let me know if you need it and I can send a .gz, the shortlog is:

sim/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
	    Peter Gavin  <pgavin@gmail.com>

	* configure: Regenerated.
	* or1k/aclocal.m4: Generated.
	* or1k/config.in: Generated.
	* or1k/configure: Generated.

-Stafford

On Thu, Oct 05, 2017 at 10:49:06PM +0900, Stafford Horne wrote:
> Hello,
> 
> (what I thought would be a few days turned into a month since the comments
> on v4)
> 
> Please find attached the sim patches that allow to get a basic OpenRISC
> system running.  This was used to verify the OpenRISC gdb port.
> 
> The main author is Peter Gavin who should have his FSF copyright in place.
> 
> Request for comments on:
>  - The testcase has a few tests commented out. I do not plan to fix now,
>    but hopefully be addressed after upstreaming.
> 
>                            # Guide to Code #
> 
> As Simon has requested I have tried to comment on the functions in the
> simulator implementation.  But I want to provide some general architecture
> comments here for reference.  Please let me know if there is a better place
> for these kind of docs.
> 
> The or1k sim uses the CGEN system to generate most of the simulator code.
> There is some documentation for CGEN on sourceware.org here:
> 
>   https://sourceware.org/cgen/docs/cgen.html
> 
> In the binutils-gdb project there are several files which get combined to
> make up the CGEN simulator.  The process for how those are built can be
> seen in `or1k/Makefile.in`.  But the main files are:
> 
> MAIN
>  sim/common/nrun.c - the main() calls sim_open(), sim_resume() and others
>  sim/or1k/sim-if.c - implements sim_open() and others used by nrun
>                      when envoking sim in gdb, gdb uses sim_open() directly
> 
> CGEN input and generated files
>  cpu/or1k*.cpu - these define the hardware, model and semantics
>  sim/or1k/arch.c - generated defines sim_machs array
>  sim/or1k/cpu.c - *generated defines register setters and getters
>  sim/or1k/decode.c - generated defines instruction decoder
>  sim/or1k/model.c - generated defines instruction cycles
>  sim/or1k/sem.c - *generated defines instruction operation semantics
>  sim/or1k/sem-switch.c - *generated ditto but as a switch
> 
> ENGINE runs decode execute loop
>  sim/common/cgen-* - cgen implementation helpers
>  sim/common/cgen-run.c - implements sim_resume() which runs the engine
>  sim/common/genmloop.sh - helper script to generate mloop.c engine the
>                           decode, execute loop
>  sim/or1k/mloop.in - openRISC implementation of mloop parts
> 
> EXTRAS callbacks from sem* to c code
>  sim/or1k/or1k.c - implements some instructions in c (not cgen schema)
>  sim/or1k/traps.c - exception handler
> 
> For each sim architecture we have choices for how the mloop is implemented.
> The OpenRISC engine uses scache pbb (pseudo-basic-block) instruction
> extraction with both fast (sem-switch.c based) and full (sem.c based)
> implementations.  The fast and full modes are switch via the command line
> options to the `run` command, i.e. --trace-insn will run in full mode.
> 
>                             # Building #
> 
> Simon asked for some details on how we build and test the openrisc sim.
> Here are some details:
> 
>                             ## TOOLCHAIN ##
> 
> This may not be needed as binutils contains most/all of the utilities
> required.  But if needed, get this toolchain (this is the newlib binary,
> others also available)
> 
>   https://github.com/openrisc/or1k-gcc/releases/download/or1k-5.4.0-20170218/or1k-elf-5.4.0-20170218.tar.xz
> 
> If you want to build that from scratch look to:
> 
>   https://github.com/openrisc/newlib/blob/scripts/build.sh
> 
>                               ## GDB ##
> 
> In a directory along side binutils-gdb source
> 
>   mkdir build-or1k-elf-gdb
>   cd build-or1k-elf-gdb
> 
>   ../binutils-gdb/configure --target=or1k-elf \
>     --prefix=/opt/shorne/software/or1k \
>     --disable-itcl \
>     --disable-tk \
>     --disable-tcl \
>     --disable-winsup \
>     --disable-gdbtk \
>     --disable-libgui \
>     --disable-rda \
>     --disable-sid \
>     --with-sysroot \
>     --disable-newlib \
>     --disable-libgloss \
>     --disable-gas \
>     --disable-ld \
>     --disable-binutils \
>     --disable-gprof \
>     --with-system-zlib
> 
>   # make gdb, sim
>   make
> 
>   # test sim
>   cd sim
>   make check
> 
> The sim creates a binary simulator too, you can run binaries such as hello
> world with:
> 
>   or1k-elf-gcc hello.c
>   ./or1k/run --trace-insn ./a.out
> 
>                             # Test Results #
> 
> Sim dejagnu tests were added specifically for openrisc and used to test
> this.  Please see the details of running the testsuite for sim below:
> 
> === sim Summary ===
> 
> # of expected passes            18
> /home/shorne/work/openrisc/build-gdb/sim/or1k/run 0.5
> 
> 
> Thanks,
> -Stafford
> 
> Changes since v4
>  * Added comments to most of the functions
>  * Implemented remainder fpu function
>  * Actually wire in fpu and error handling logic
>  * Added fpu test case
> 
> Changes since v3
>  * Cleaned up indentation and style of sim testsuite
>  * Cleaned up TODOs in testsuite
>  * Implemented range exception
> 
> Changes since v2
>  * Removed 64-bit implementation (reduced files)
>  * Removed cgen suffix patch
>  * Removed different builds for linux
>  * Removed unused macros
>  * Fixed gnu style issues pointed out by Mike
>  * Fixed copyrights (not Cygnus, added to each file)
> 
> Changes since v1
>  * Squashed sim patches into single sim patch
>  * Put Generated files in separate patch
>  * I have my sim/gdb copyright assignment complete
> 
> 
> Peter Gavin (3):
>   sim: cgen: add remainder functions (needed for OR1K lf.rem.[sd])
>   sim: cgen: add MUL2OFSI and MUL1OFSI macros (needed for OR1K l.mul[u])
>   sim: testsuite: add testsuite for or1k sim
> 
> Stafford Horne (3):
>   sim: or1k: add or1k target to sim
>   sim: or1k: add cgen generated files
>   sim: or1k: add autoconf generated files
> 
>  sim/common/cgen-accfp.c                        |    40 +
>  sim/common/cgen-fpu.h                          |     4 +
>  sim/common/cgen-ops.h                          |    18 +
>  sim/common/sim-fpu.c                           |    90 +-
>  sim/common/sim-fpu.h                           |    13 +-
>  sim/configure                                  |     9 +
>  sim/configure.tgt                              |     4 +
>  sim/or1k/Makefile.in                           |   147 +
>  sim/or1k/aclocal.m4                            |   119 +
>  sim/or1k/arch.c                                |    38 +
>  sim/or1k/arch.h                                |    50 +
>  sim/or1k/config.in                             |   248 +
>  sim/or1k/configure                             | 16043 +++++++++++++++++++++++
>  sim/or1k/configure.ac                          |    17 +
>  sim/or1k/cpu.c                                 | 10181 ++++++++++++++
>  sim/or1k/cpu.h                                 |  5024 +++++++
>  sim/or1k/cpuall.h                              |    66 +
>  sim/or1k/decode.c                              |  2559 ++++
>  sim/or1k/decode.h                              |    94 +
>  sim/or1k/mloop.in                              |   242 +
>  sim/or1k/model.c                               |  3809 ++++++
>  sim/or1k/or1k-sim.h                            |    95 +
>  sim/or1k/or1k.c                                |   355 +
>  sim/or1k/sem-switch.c                          |  2748 ++++
>  sim/or1k/sem.c                                 |  2953 +++++
>  sim/or1k/sim-if.c                              |   281 +
>  sim/or1k/sim-main.h                            |    81 +
>  sim/or1k/traps.c                               |   299 +
>  sim/testsuite/configure                        |     4 +
>  sim/testsuite/sim/or1k/add.S                   |   606 +
>  sim/testsuite/sim/or1k/alltests.exp            |    34 +
>  sim/testsuite/sim/or1k/and.S                   |   198 +
>  sim/testsuite/sim/or1k/basic.S                 |   522 +
>  sim/testsuite/sim/or1k/div.S                   |   290 +
>  sim/testsuite/sim/or1k/ext.S                   |   236 +
>  sim/testsuite/sim/or1k/find.S                  |   100 +
>  sim/testsuite/sim/or1k/flag.S                  |   378 +
>  sim/testsuite/sim/or1k/fpu.S                   |   128 +
>  sim/testsuite/sim/or1k/jump.S                  |   104 +
>  sim/testsuite/sim/or1k/load.S                  |   358 +
>  sim/testsuite/sim/or1k/mac.S                   |   778 ++
>  sim/testsuite/sim/or1k/mfspr.S                 |   171 +
>  sim/testsuite/sim/or1k/mul.S                   |   573 +
>  sim/testsuite/sim/or1k/or.S                    |   199 +
>  sim/testsuite/sim/or1k/or1k-asm-test-env.h     |    59 +
>  sim/testsuite/sim/or1k/or1k-asm-test-helpers.h |   121 +
>  sim/testsuite/sim/or1k/or1k-asm-test.h         |   225 +
>  sim/testsuite/sim/or1k/or1k-asm.h              |    37 +
>  sim/testsuite/sim/or1k/or1k-test.ld            |    75 +
>  sim/testsuite/sim/or1k/ror.S                   |   159 +
>  sim/testsuite/sim/or1k/shift.S                 |   541 +
>  sim/testsuite/sim/or1k/spr-defs.h              |   120 +
>  sim/testsuite/sim/or1k/sub.S                   |   201 +
>  sim/testsuite/sim/or1k/xor.S                   |   200 +
>  54 files changed, 52037 insertions(+), 7 deletions(-)
>  create mode 100644 sim/or1k/Makefile.in
>  create mode 100644 sim/or1k/aclocal.m4
>  create mode 100644 sim/or1k/arch.c
>  create mode 100644 sim/or1k/arch.h
>  create mode 100644 sim/or1k/config.in
>  create mode 100755 sim/or1k/configure
>  create mode 100644 sim/or1k/configure.ac
>  create mode 100644 sim/or1k/cpu.c
>  create mode 100644 sim/or1k/cpu.h
>  create mode 100644 sim/or1k/cpuall.h
>  create mode 100644 sim/or1k/decode.c
>  create mode 100644 sim/or1k/decode.h
>  create mode 100644 sim/or1k/mloop.in
>  create mode 100644 sim/or1k/model.c
>  create mode 100644 sim/or1k/or1k-sim.h
>  create mode 100644 sim/or1k/or1k.c
>  create mode 100644 sim/or1k/sem-switch.c
>  create mode 100644 sim/or1k/sem.c
>  create mode 100644 sim/or1k/sim-if.c
>  create mode 100644 sim/or1k/sim-main.h
>  create mode 100644 sim/or1k/traps.c
>  create mode 100644 sim/testsuite/sim/or1k/add.S
>  create mode 100644 sim/testsuite/sim/or1k/alltests.exp
>  create mode 100644 sim/testsuite/sim/or1k/and.S
>  create mode 100644 sim/testsuite/sim/or1k/basic.S
>  create mode 100644 sim/testsuite/sim/or1k/div.S
>  create mode 100644 sim/testsuite/sim/or1k/ext.S
>  create mode 100644 sim/testsuite/sim/or1k/find.S
>  create mode 100644 sim/testsuite/sim/or1k/flag.S
>  create mode 100644 sim/testsuite/sim/or1k/fpu.S
>  create mode 100644 sim/testsuite/sim/or1k/jump.S
>  create mode 100644 sim/testsuite/sim/or1k/load.S
>  create mode 100644 sim/testsuite/sim/or1k/mac.S
>  create mode 100644 sim/testsuite/sim/or1k/mfspr.S
>  create mode 100644 sim/testsuite/sim/or1k/mul.S
>  create mode 100644 sim/testsuite/sim/or1k/or.S
>  create mode 100644 sim/testsuite/sim/or1k/or1k-asm-test-env.h
>  create mode 100644 sim/testsuite/sim/or1k/or1k-asm-test-helpers.h
>  create mode 100644 sim/testsuite/sim/or1k/or1k-asm-test.h
>  create mode 100644 sim/testsuite/sim/or1k/or1k-asm.h
>  create mode 100644 sim/testsuite/sim/or1k/or1k-test.ld
>  create mode 100644 sim/testsuite/sim/or1k/ror.S
>  create mode 100644 sim/testsuite/sim/or1k/shift.S
>  create mode 100644 sim/testsuite/sim/or1k/spr-defs.h
>  create mode 100644 sim/testsuite/sim/or1k/sub.S
>  create mode 100644 sim/testsuite/sim/or1k/xor.S
> 
> -- 
> 2.13.5
> 
