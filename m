From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 07:40:48 +0900
Subject: [OpenRISC] [PATCH v2 0/9] Openrisc misc features / fixes
Message-ID: <cover.1492986468.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

I have got a few response on the last series and have fixed them up.  Also
I have dropped the shutdown patch.

These patches I added while working on upcoming openrisc smp support.  This
does not allow for SMP openrisc on qemu "yet" but it does help to allow
booting of an SMP kernel on the uni-processor qemu system which I was using
as a sanity check before testing on fpga hardware.

Changes Since v1:

 o Added Tim's patches to this series (since the vmstate patch depends on
   in)
 o Changed vmstate patch to bump version numbers + support evbar saving
 o Changed Shadow Register patch to use accessor functions
 o Added reviewed-by's
 o Added a patch to remote the `features` field and enums
 o Dropped shutdown on `l.nop 1` patch

-Stafford

Stafford Horne (7):
  target/openrisc: Fixes for memory debugging
  target/openrisc: add numcores and coreid support
  migration: Add VMSTATE_UINTTL_2DARRAY()
  target/openrisc: implement shadow registers
  migration: Add VMSTATE_STRUCT_2DARRAY()
  target/openrisc: Implement full vmstate serialization
  target/openrisc: Remove duplicate features property

Tim 'mithro' Ansell (2):
  target/openrisc: Implement EVBAR register
  target/openrisc: Implement EPH bit

 include/migration/cpu.h             |  7 ++++
 include/migration/vmstate.h         | 15 ++++++++
 linux-user/elfload.c                |  2 +-
 linux-user/main.c                   | 18 ++++-----
 linux-user/openrisc/target_cpu.h    |  6 +--
 linux-user/openrisc/target_signal.h |  2 +-
 linux-user/signal.c                 | 16 ++++----
 target/openrisc/cpu.c               | 13 ++-----
 target/openrisc/cpu.h               | 36 ++++++++++--------
 target/openrisc/gdbstub.c           |  4 +-
 target/openrisc/interrupt.c         |  9 ++++-
 target/openrisc/machine.c           | 75 +++++++++++++++++++++++++++++++++++--
 target/openrisc/mmu.c               | 23 ++++++++++--
 target/openrisc/sys_helper.c        | 22 +++++++++++
 target/openrisc/translate.c         |  5 ++-
 15 files changed, 194 insertions(+), 59 deletions(-)

-- 
2.9.3

