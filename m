From: Doug Evans <dje@google.com>
Date: Mon, 09 Oct 2017 16:55:50 +0000
Subject: [OpenRISC] [PATCH v5 0/6] sim port for OpenRISC
Message-ID: <001a114c9b6e14b276055b20101a@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Stafford Horne writes:
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

fwiw, I'm totally ok with adding a README in a suitable directory.
sim/or1k/README?
I'm not too picky with what to put in there.
You could add all of this and that would be fine by me.

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
