From: Stafford Horne <shorne@gmail.com>
Date: Mon, 17 Apr 2017 08:23:49 +0900
Subject: [OpenRISC] [PATCH 0/7] Openrisc misc features / fixes
Message-ID: <cover.1492384862.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

The first patch here I sent a few weeks ago and got go response.  Sending
again.

The second was requested by the uclibc-ng maintainer as when he is testing
his builds he uses qemu and would like to have a way for the system to shut
down.  This models how our other simulators shutdown, so no changes are
needed on the kernel side.

The others I added while working on upcoming openrisc smp support.

-Stafford

Stafford Horne (7):
  target/openrisc: Fixes for memory debugging
  target/openrisc: add shutdown logic
  target/openrisc: add numcores and coreid support
  target/openrisc: implement shadow registers
  migration: Add VMSTATE_UINTTL_2DARRAY()
  migration: Add VMSTATE_STRUCT_2DARRAY()
  target/openrisc: Implement full vmstate serialization

 include/migration/cpu.h      |  7 ++++
 include/migration/vmstate.h  | 15 +++++++++
 target/openrisc/cpu.c        |  5 ++-
 target/openrisc/cpu.h        |  4 ++-
 target/openrisc/helper.h     |  1 +
 target/openrisc/machine.c    | 76 ++++++++++++++++++++++++++++++++++++++++++--
 target/openrisc/mmu.c        | 23 +++++++++++---
 target/openrisc/sys_helper.c | 32 +++++++++++++++++++
 target/openrisc/translate.c  |  8 +++--
 9 files changed, 160 insertions(+), 11 deletions(-)

-- 
2.9.3

