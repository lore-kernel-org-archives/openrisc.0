From: Stafford Horne <shorne@gmail.com>
Date: Wed,  3 Mar 2021 22:50:22 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC fixes and setjmp/longjmp work
Message-ID: <20210303135026.3450789-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

These are the patches I came up with to get the setjmp/longjmp routines to work
on OpenRISC.  It seems to be working well.

The patches are on github here:
  https://github.com/stffrdhrn/barebox/tree/openrisc-bthread

I had to revert a commit to remove openrisc to do this work, I hope that can be
reverted.

Test output:

    barebox at or1ksim:/ bthread -v
    bthread_printer yield #1
    bthread_printer yield #2
    bthread_printer yield #3
    bthread_printer yield #4
    36441 bthread yield calls in 1s
    barebox at or1ksim:/ bthread -v
    bthread_printer yield #1
    bthread_printer yield #2
    bthread_printer yield #3
    bthread_printer yield #4
    36504 bthread yield calls in 1s
    barebox at or1ksim:/ bthread

    bthread - print info about registered bthreads

    print info about registered barebox threads

    Options:
	    -i      Print information about registered bthreads
	    -t      measure how many bthreads we currently run in 1s
	    -c      count maximum context switches in 1s
	    -v      verify correct bthread operation

    barebox at or1ksim:/ bthread -c
    bthread -c
    269536 bthread context switches possible in 1s

Stafford Horne (4):
  openrisc: Use movhi to zero registers
  openrisc: Add gitignore for dtb files
  openrisc: Add linkage.h
  openrisc: Implement setjmp/longjmp/initjmp

 arch/openrisc/Kconfig               |  1 +
 arch/openrisc/cpu/start.S           |  6 ++--
 arch/openrisc/dts/.gitignore        |  1 +
 arch/openrisc/include/asm/linkage.h |  7 ++++
 arch/openrisc/include/asm/setjmp.h  | 17 +++++++++
 arch/openrisc/lib/Makefile          |  1 +
 arch/openrisc/lib/setjmp.S          | 56 +++++++++++++++++++++++++++++
 7 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 arch/openrisc/dts/.gitignore
 create mode 100644 arch/openrisc/include/asm/linkage.h
 create mode 100644 arch/openrisc/include/asm/setjmp.h
 create mode 100644 arch/openrisc/lib/setjmp.S

-- 
2.26.2

