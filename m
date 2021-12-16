From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 16 Dec 2021 18:29:40 +0100
Subject: [OpenRISC] [PATCH v2 00/13] Unify asm/unaligned.h around struct
 helper
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
Message-ID: <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Arnd,

(replying to an old thread as this came up in the discussion regarding
misaligned loads and stored in siphash() when compiled for ARM
[f7e5b9bfa6c8820407b64eabc1f29c9a87e8993d])

On Fri, 14 May 2021 at 12:02, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The get_unaligned()/put_unaligned() helpers are traditionally architecture
> specific, with the two main variants being the "access-ok.h" version
> that assumes unaligned pointer accesses always work on a particular
> architecture, and the "le-struct.h" version that casts the data to a
> byte aligned type before dereferencing, for architectures that cannot
> always do unaligned accesses in hardware.
>
> Based on the discussion linked below, it appears that the access-ok
> version is not realiable on any architecture, but the struct version
> probably has no downsides. This series changes the code to use the
> same implementation on all architectures, addressing the few exceptions
> separately.
>
> I've included this version in the asm-generic tree for 5.14 already,
> addressing the few issues that were pointed out in the RFC. If there
> are any remaining problems, I hope those can be addressed as follow-up
> patches.
>

I think this series is a huge improvement, but it does not solve the
UB problem completely. As we found, there are open issues in the GCC
bugzilla regarding assumptions in the compiler that aligned quantities
either overlap entirely or not at all. (e.g.,
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100363)

CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is used in many places to
conditionally emit code that violates C alignment rules. E.g., there
is this example in Documentation/core-api/unaligned-memory-access.rst:

bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
{
#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
  u32 fold = ((*(const u32 *)addr1) ^ (*(const u32 *)addr2)) |
             ((*(const u16 *)(addr1 + 4)) ^ (*(const u16 *)(addr2 + 4)));
  return fold == 0;
#else
...

(which now deviates from its actual implementation, but the point is
the same) where CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is used in the
wrong way (IMHO).

The pattern seems to be

#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
  // ignore alignment rules, just cast to a more aligned pointer type
#else
  // use unaligned accessors, which could be either cheap or expensive,
  // depending on the architecture
#endif

whereas the following pattern makes more sense, I think, and does not
violate any C rules in the common case:

#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
  // use unaligned accessors, which are cheap or even entirely free
#else
  // avoid unaligned accessors, as they are expensive; instead, reorganize
  // the data so we don't need them (similar to setting NET_IP_ALIGN to 2)
#endif

The only remaining problem here is reinterpreting a char* pointer to a
u32*, e.g., for accessing the IP address in an Ethernet frame when
NET_IP_ALIGN == 2, which could suffer from the same UB problem again,
as I understand it.

In the 32-bit ARM case (v6+) [which is admittedly an outlier] this
makes a substantial difference, as ARMv6 does have efficient unaligned
accessors (load/store word or halfword may be used on misaligned
addresses) but requires that load/store double-word and load/store
multiple are only used on 32-bit aligned addresses. GCC does the right
thing with the unaligned accessors, but blindly casting away
misalignment may result in alignment traps if the compiler happened to
emit load-double or load-multiple instructions for the memory access
in question.

Jason already verifed that in the siphash() case, the aligned and
unaligned versions of the code actually compile to the same machine
code on x86, as the unaligned accessors just disappear. I suspect this
to be the case for many instances where
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is being used, mostly in the
networking stack.

So I intend to dig a bit deeper into this, and perhaps propose some
changes where the interpretation of
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is documented more clearly, and
tweaked according to my suggestion above (while ensuring that codegen
does not suffer, of course)

Thoughts, concerns, objections?


--
Ard.




> Link: https://lore.kernel.org/lkml/75d07691-1e4f-741f-9852-38c0b4f520bc at synopsys.com/
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100363
> Link: https://lore.kernel.org/lkml/20210507220813.365382-14-arnd at kernel.org/
> Link: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git unaligned-rework-v2
>
>
> Arnd Bergmann (13):
>   asm-generic: use asm-generic/unaligned.h for most architectures
>   openrisc: always use unaligned-struct header
>   sh: remove unaligned access for sh4a
>   m68k: select CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>   powerpc: use linux/unaligned/le_struct.h on LE power7
>   asm-generic: unaligned: remove byteshift helpers
>   asm-generic: unaligned always use struct helpers
>   partitions: msdos: fix one-byte get_unaligned()
>   apparmor: use get_unaligned() only for multi-byte words
>   mwifiex: re-fix for unaligned accesses
>   netpoll: avoid put_unaligned() on single character
>   asm-generic: uaccess: 1-byte access is always aligned
>   asm-generic: simplify asm/unaligned.h
>
>  arch/alpha/include/asm/unaligned.h          |  12 --
>  arch/arm/include/asm/unaligned.h            |  27 ---
>  arch/ia64/include/asm/unaligned.h           |  12 --
>  arch/m68k/Kconfig                           |   1 +
>  arch/m68k/include/asm/unaligned.h           |  26 ---
>  arch/microblaze/include/asm/unaligned.h     |  27 ---
>  arch/mips/crypto/crc32-mips.c               |   2 +-
>  arch/openrisc/include/asm/unaligned.h       |  47 -----
>  arch/parisc/include/asm/unaligned.h         |   6 +-
>  arch/powerpc/include/asm/unaligned.h        |  22 ---
>  arch/sh/include/asm/unaligned-sh4a.h        | 199 --------------------
>  arch/sh/include/asm/unaligned.h             |  13 --
>  arch/sparc/include/asm/unaligned.h          |  11 --
>  arch/x86/include/asm/unaligned.h            |  15 --
>  arch/xtensa/include/asm/unaligned.h         |  29 ---
>  block/partitions/ldm.h                      |   2 +-
>  block/partitions/msdos.c                    |   2 +-
>  drivers/net/wireless/marvell/mwifiex/pcie.c |  10 +-
>  include/asm-generic/uaccess.h               |   4 +-
>  include/asm-generic/unaligned.h             | 141 +++++++++++---
>  include/linux/unaligned/access_ok.h         |  68 -------
>  include/linux/unaligned/be_byteshift.h      |  71 -------
>  include/linux/unaligned/be_memmove.h        |  37 ----
>  include/linux/unaligned/be_struct.h         |  37 ----
>  include/linux/unaligned/generic.h           | 115 -----------
>  include/linux/unaligned/le_byteshift.h      |  71 -------
>  include/linux/unaligned/le_memmove.h        |  37 ----
>  include/linux/unaligned/le_struct.h         |  37 ----
>  include/linux/unaligned/memmove.h           |  46 -----
>  net/core/netpoll.c                          |   4 +-
>  security/apparmor/policy_unpack.c           |   2 +-
>  31 files changed, 131 insertions(+), 1002 deletions(-)
>  delete mode 100644 arch/alpha/include/asm/unaligned.h
>  delete mode 100644 arch/arm/include/asm/unaligned.h
>  delete mode 100644 arch/ia64/include/asm/unaligned.h
>  delete mode 100644 arch/m68k/include/asm/unaligned.h
>  delete mode 100644 arch/microblaze/include/asm/unaligned.h
>  delete mode 100644 arch/openrisc/include/asm/unaligned.h
>  delete mode 100644 arch/powerpc/include/asm/unaligned.h
>  delete mode 100644 arch/sh/include/asm/unaligned-sh4a.h
>  delete mode 100644 arch/sh/include/asm/unaligned.h
>  delete mode 100644 arch/sparc/include/asm/unaligned.h
>  delete mode 100644 arch/x86/include/asm/unaligned.h
>  delete mode 100644 arch/xtensa/include/asm/unaligned.h
>  delete mode 100644 include/linux/unaligned/access_ok.h
>  delete mode 100644 include/linux/unaligned/be_byteshift.h
>  delete mode 100644 include/linux/unaligned/be_memmove.h
>  delete mode 100644 include/linux/unaligned/be_struct.h
>  delete mode 100644 include/linux/unaligned/generic.h
>  delete mode 100644 include/linux/unaligned/le_byteshift.h
>  delete mode 100644 include/linux/unaligned/le_memmove.h
>  delete mode 100644 include/linux/unaligned/le_struct.h
>  delete mode 100644 include/linux/unaligned/memmove.h
>
> --
> 2.29.2
>
> Cc: Amitkumar Karwar <amitkarwar@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ganapathi Bhat <ganapathi017@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "Richard Russon (FlatCap)" <ldm@flatcap.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Xinming Hu <huxinming820@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: x86 at kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-m68k at lists.linux-m68k.org
> Cc: linux-crypto at vger.kernel.org
> Cc: openrisc at lists.librecores.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-sh at vger.kernel.org
> Cc: sparclinux at vger.kernel.org
> Cc: linux-ntfs-dev at lists.sourceforge.net
> Cc: linux-block at vger.kernel.org
> Cc: linux-wireless at vger.kernel.org
> Cc: netdev at vger.kernel.org
> Cc: linux-arch at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org
>
>
