From: Arnd Bergmann <arnd@kernel.org>
Date: Sat,  8 May 2021 00:07:45 +0200
Subject: [OpenRISC] [RFC 0/12] Unify asm/unaligned.h around struct helper
Message-ID: <20210507220813.365382-1-arnd@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann <arnd@arndb.de>

The get_unaligned()/put_unaligned() helpers are traditionally architecture
specific, with the two main variants being the "access-ok.h" version
that assumes unaligned pointer accesses always work on a particular
architecture, and the "le-struct.h" version that casts the data to a
byte aligned type before dereferencing, for architectures that cannot
always do unaligned accesses in hardware.

Based on the discussion linked below, it appears that the access-ok
version is not realiable on any architecture, but the struct version
probably has no downsides. This series changes the code to use the
same implementation on all architectures, addressing the few exceptions
separately.

I've pushed the patches to the asm-generic git tree for testing.

	Arnd

Link: https://lore.kernel.org/lkml/75d07691-1e4f-741f-9852-38c0b4f520bc at synopsys.com/
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100363
Link: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git unaligned-rework

Arnd Bergmann (12):
  asm-generic: use asm-generic/unaligned.h for most architectures
  openrisc: always use unaligned-struct header
  sh: remove unaligned access for sh4a
  m68k: select CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
  powerpc: use linux/unaligned/le_struct.h on LE power7
  asm-generic: unaligned: remove byteshift helpers
  asm-generic: unaligned always use struct helpers
  partitions: msdos: fix one-byte get_unaligned()
  apparmor: use get_unaligned() only for multi-byte words
  mwifiex: re-fix for unaligned accesses
  netpoll: avoid put_unaligned() on single character
  asm-generic: simplify asm/unaligned.h

 arch/alpha/include/asm/unaligned.h          |  12 --
 arch/arm/include/asm/unaligned.h            |  27 ---
 arch/ia64/include/asm/unaligned.h           |  12 --
 arch/m68k/Kconfig                           |   1 +
 arch/m68k/include/asm/unaligned.h           |  26 ---
 arch/microblaze/include/asm/unaligned.h     |  27 ---
 arch/mips/crypto/crc32-mips.c               |   2 +-
 arch/openrisc/include/asm/unaligned.h       |  47 -----
 arch/parisc/include/asm/unaligned.h         |   6 +-
 arch/powerpc/include/asm/unaligned.h        |  22 ---
 arch/sh/include/asm/unaligned-sh4a.h        | 199 --------------------
 arch/sh/include/asm/unaligned.h             |  13 --
 arch/sparc/include/asm/unaligned.h          |  11 --
 arch/x86/include/asm/unaligned.h            |  15 --
 arch/xtensa/include/asm/unaligned.h         |  29 ---
 block/partitions/ldm.h                      |   2 +-
 block/partitions/msdos.c                    |   2 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c |  10 +-
 include/asm-generic/unaligned.h             | 149 ++++++++++++---
 include/linux/unaligned/access_ok.h         |  68 -------
 include/linux/unaligned/be_byteshift.h      |  71 -------
 include/linux/unaligned/be_memmove.h        |  37 ----
 include/linux/unaligned/be_struct.h         |  37 ----
 include/linux/unaligned/generic.h           | 115 -----------
 include/linux/unaligned/le_byteshift.h      |  71 -------
 include/linux/unaligned/le_memmove.h        |  37 ----
 include/linux/unaligned/le_struct.h         |  37 ----
 include/linux/unaligned/memmove.h           |  46 -----
 net/core/netpoll.c                          |   4 +-
 security/apparmor/policy_unpack.c           |   2 +-
 30 files changed, 137 insertions(+), 1000 deletions(-)
 delete mode 100644 arch/alpha/include/asm/unaligned.h
 delete mode 100644 arch/arm/include/asm/unaligned.h
 delete mode 100644 arch/ia64/include/asm/unaligned.h
 delete mode 100644 arch/m68k/include/asm/unaligned.h
 delete mode 100644 arch/microblaze/include/asm/unaligned.h
 delete mode 100644 arch/openrisc/include/asm/unaligned.h
 delete mode 100644 arch/powerpc/include/asm/unaligned.h
 delete mode 100644 arch/sh/include/asm/unaligned-sh4a.h
 delete mode 100644 arch/sh/include/asm/unaligned.h
 delete mode 100644 arch/sparc/include/asm/unaligned.h
 delete mode 100644 arch/x86/include/asm/unaligned.h
 delete mode 100644 arch/xtensa/include/asm/unaligned.h
 delete mode 100644 include/linux/unaligned/access_ok.h
 delete mode 100644 include/linux/unaligned/be_byteshift.h
 delete mode 100644 include/linux/unaligned/be_memmove.h
 delete mode 100644 include/linux/unaligned/be_struct.h
 delete mode 100644 include/linux/unaligned/generic.h
 delete mode 100644 include/linux/unaligned/le_byteshift.h
 delete mode 100644 include/linux/unaligned/le_memmove.h
 delete mode 100644 include/linux/unaligned/le_struct.h
 delete mode 100644 include/linux/unaligned/memmove.h

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ganapathi Bhat <ganapathi017@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: James Morris <jmorris@namei.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Rich Felker <dalias@libc.org>
Cc: "Richard Russon (FlatCap)" <ldm@flatcap.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Xinming Hu <huxinming820@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: x86 at kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-m68k at lists.linux-m68k.org
Cc: linux-crypto at vger.kernel.org
Cc: openrisc at lists.librecores.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-sh at vger.kernel.org
Cc: sparclinux at vger.kernel.org
Cc: linux-ntfs-dev at lists.sourceforge.net
Cc: linux-block at vger.kernel.org
Cc: linux-wireless at vger.kernel.org
Cc: netdev at vger.kernel.org
Cc: linux-arch at vger.kernel.org
Cc: linux-security-module at vger.kernel.org

-- 
2.29.2

