From: Stafford Horne <shorne@gmail.com>
Date: Sun, 12 Feb 2017 21:33:49 +0900
Subject: [OpenRISC] [PATCH 0/2] Update cpu definition to handle ppc
Message-ID: <cover.1486902449.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Recently when testing qemu I found that the native gdb sim did not properly
set the ppc.  After some time of investigation I figured the best place to
fix this is by udating the pc set sematics in the cgen definition.

The patch is pretty simple, but maybe too much so?

I am sending this patch to see if anyone has a better idea of how to
support ppc updating in the gdb native sim.

-Stafford 

Stafford Horne (2):
  cpu: or1k: Set ppc on pc change
  sim: or1k: Regenerate sim files

 cpu/or1kcommon.cpu | 5 +++++
 sim/or1k/cpu32.c   | 4 ++--
 sim/or1k/cpu32.h   | 8 +++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.9.3

