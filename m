From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri,  2 Apr 2021 15:18:01 +0000 (UTC)
Subject: [OpenRISC] [PATCH v4 00/20] Implement GENERIC_CMDLINE
Message-ID: <cover.1617375802.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The purpose of this series is to improve and enhance the
handling of kernel boot arguments.

Current situation is that most if not all architectures are using
similar options to do some manupulation on command line arguments:
- Prepend built-in arguments in front of bootloader provided arguments
- Append built-in arguments after bootloader provided arguments
- Replace bootloader provided arguments by built-in arguments
- Use built-in arguments when none is provided by bootloader.

On some architectures, all the options are possible. On other ones,
only a subset are available.

The purpose of this series is to refactor and enhance the
handling of kernel boot arguments so that every architecture can
benefit from all possibilities.

It is first focussed on powerpc but also extends the capability
for other arches.

The work has been focussed on minimising the churn in architectures
by keeping the most commonly used namings.

Main changes in V4:
- Included patch from Daniel to replace powerpc's strcpy() by strlcpy()
- Using strlcpy() instead of zeroing first char + strlcat() (idea taken frm Daniel's series)
- Reworked the convertion of EFI which was wrong in V3
- Added "too long" command line handling
- Changed cmdline macro into a function
- Done a few fixes in arch (NIOS2, SH, ARM)
- Taken comments into account (see individual responses for details)
- Tested on powerpc, build tested on ARM64, X86_64.

Main changes in V3:
- Also accept destination equal to source in cmdline_build() by setting a tmp buffer in __initdata. Powerpc provides different source and destination and call __cmdline_build() directly.
- Taken comments received from Will and Rob
- Converted all architectures (Only tested on powerpc)

Christophe Leroy (19):
  cmdline: Add generic function to build command line.
  drivers: of: use cmdline building function
  x86/efi: Replace CONFIG_CMDLINE_OVERRIDE by CONFIG_CMDLINE_FORCE
  drivers: firmware: efi: use cmdline building function
  cmdline: Gives architectures opportunity to use generically defined
    boot cmdline manipulation
  powerpc: Convert to GENERIC_CMDLINE
  arm: Convert to GENERIC_CMDLINE
  arm64: Convert to GENERIC_CMDLINE
  hexagon: Convert to GENERIC_CMDLINE
  microblaze: Convert to GENERIC_CMDLINE
  nios2: Convert to GENERIC_CMDLINE
  openrisc: Convert to GENERIC_CMDLINE
  riscv: Convert to GENERIC_CMDLINE
  sh: Convert to GENERIC_CMDLINE
  sparc: Convert to GENERIC_CMDLINE
  xtensa: Convert to GENERIC_CMDLINE
  x86: Convert to GENERIC_CMDLINE
  mips: Convert to GENERIC_CMDLINE
  cmdline: Remove CONFIG_CMDLINE_EXTEND

Daniel Walker (1):
  powerpc: convert strcpy to strlcpy in prom_init

 arch/arm/Kconfig                              | 38 +--------
 arch/arm/kernel/atags_parse.c                 | 13 +--
 arch/arm64/Kconfig                            | 33 +-------
 arch/arm64/kernel/idreg-override.c            |  9 +--
 arch/hexagon/Kconfig                          | 11 +--
 arch/hexagon/kernel/setup.c                   | 10 +--
 arch/microblaze/Kconfig                       | 24 +-----
 arch/microblaze/configs/mmu_defconfig         |  2 +-
 arch/microblaze/kernel/head.S                 |  4 +-
 arch/mips/Kconfig                             |  1 +
 arch/mips/Kconfig.debug                       | 44 -----------
 arch/mips/configs/ar7_defconfig               |  1 -
 arch/mips/configs/bcm47xx_defconfig           |  1 -
 arch/mips/configs/bcm63xx_defconfig           |  1 -
 arch/mips/configs/bmips_be_defconfig          |  1 -
 arch/mips/configs/bmips_stb_defconfig         |  1 -
 arch/mips/configs/capcella_defconfig          |  1 -
 arch/mips/configs/ci20_defconfig              |  1 -
 arch/mips/configs/cu1000-neo_defconfig        |  1 -
 arch/mips/configs/cu1830-neo_defconfig        |  1 -
 arch/mips/configs/e55_defconfig               |  1 -
 arch/mips/configs/generic_defconfig           |  1 -
 arch/mips/configs/gpr_defconfig               |  1 -
 arch/mips/configs/loongson3_defconfig         |  1 -
 arch/mips/configs/mpc30x_defconfig            |  1 -
 arch/mips/configs/rt305x_defconfig            |  1 -
 arch/mips/configs/tb0219_defconfig            |  1 -
 arch/mips/configs/tb0226_defconfig            |  1 -
 arch/mips/configs/tb0287_defconfig            |  1 -
 arch/mips/configs/workpad_defconfig           |  1 -
 arch/mips/configs/xway_defconfig              |  1 -
 arch/mips/kernel/relocate.c                   |  4 +-
 arch/mips/kernel/setup.c                      | 40 +---------
 arch/mips/pic32/pic32mzda/early_console.c     |  2 +-
 arch/mips/pic32/pic32mzda/init.c              |  2 -
 arch/nios2/Kconfig                            | 25 +-----
 arch/nios2/kernel/setup.c                     | 13 +--
 arch/openrisc/Kconfig                         | 10 +--
 arch/powerpc/Kconfig                          | 37 +--------
 arch/powerpc/kernel/prom_init.c               | 46 ++++++-----
 arch/riscv/Kconfig                            | 44 +----------
 arch/riscv/kernel/setup.c                     |  7 +-
 arch/sh/Kconfig                               | 28 +------
 arch/sh/configs/ap325rxa_defconfig            |  2 +-
 arch/sh/configs/dreamcast_defconfig           |  2 +-
 arch/sh/configs/ecovec24-romimage_defconfig   |  2 +-
 arch/sh/configs/ecovec24_defconfig            |  2 +-
 arch/sh/configs/edosk7760_defconfig           |  2 +-
 arch/sh/configs/espt_defconfig                |  2 +-
 arch/sh/configs/j2_defconfig                  |  2 +-
 arch/sh/configs/kfr2r09-romimage_defconfig    |  2 +-
 arch/sh/configs/kfr2r09_defconfig             |  2 +-
 arch/sh/configs/lboxre2_defconfig             |  2 +-
 arch/sh/configs/microdev_defconfig            |  2 +-
 arch/sh/configs/migor_defconfig               |  2 +-
 arch/sh/configs/polaris_defconfig             |  2 +-
 arch/sh/configs/r7780mp_defconfig             |  2 +-
 arch/sh/configs/r7785rp_defconfig             |  2 +-
 arch/sh/configs/rsk7201_defconfig             |  2 +-
 arch/sh/configs/rsk7203_defconfig             |  2 +-
 arch/sh/configs/rts7751r2d1_defconfig         |  2 +-
 arch/sh/configs/rts7751r2dplus_defconfig      |  2 +-
 arch/sh/configs/sdk7780_defconfig             |  2 +-
 arch/sh/configs/sdk7786_defconfig             |  2 +-
 arch/sh/configs/se7206_defconfig              |  2 +-
 arch/sh/configs/se7343_defconfig              |  2 +-
 arch/sh/configs/se7712_defconfig              |  2 +-
 arch/sh/configs/se7721_defconfig              |  2 +-
 arch/sh/configs/se7724_defconfig              |  2 +-
 arch/sh/configs/se7751_defconfig              |  2 +-
 arch/sh/configs/se7780_defconfig              |  2 +-
 arch/sh/configs/sh03_defconfig                |  2 +-
 arch/sh/configs/sh2007_defconfig              |  2 +-
 arch/sh/configs/sh7757lcr_defconfig           |  2 +-
 arch/sh/configs/sh7763rdp_defconfig           |  2 +-
 arch/sh/configs/shmin_defconfig               |  2 +-
 arch/sh/configs/shx3_defconfig                |  2 +-
 arch/sh/configs/titan_defconfig               |  2 +-
 arch/sh/configs/ul2_defconfig                 |  2 +-
 arch/sh/kernel/setup.c                        | 11 +--
 arch/sparc/Kconfig                            | 18 +----
 arch/sparc/prom/bootstr_64.c                  |  2 +-
 arch/x86/Kconfig                              | 45 +----------
 arch/x86/kernel/setup.c                       | 17 +---
 arch/xtensa/Kconfig                           | 15 +---
 arch/xtensa/configs/audio_kc705_defconfig     |  1 -
 arch/xtensa/configs/common_defconfig          |  1 -
 arch/xtensa/configs/generic_kc705_defconfig   |  1 -
 arch/xtensa/configs/iss_defconfig             |  1 -
 arch/xtensa/configs/nommu_kc705_defconfig     |  1 -
 arch/xtensa/configs/smp_lx200_defconfig       |  1 -
 arch/xtensa/configs/virt_defconfig            |  1 -
 arch/xtensa/configs/xip_kc705_defconfig       |  1 -
 arch/xtensa/kernel/setup.c                    | 10 +--
 .../firmware/efi/libstub/efi-stub-helper.c    | 35 ++++----
 drivers/firmware/efi/libstub/efi-stub.c       | 23 ++----
 drivers/firmware/efi/libstub/efistub.h        |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c       | 18 +----
 drivers/of/fdt.c                              | 23 +-----
 include/linux/cmdline.h                       | 79 +++++++++++++++++++
 init/Kconfig                                  | 46 +++++++++++
 usr/Kconfig                                   |  2 +-
 102 files changed, 265 insertions(+), 628 deletions(-)
 create mode 100644 include/linux/cmdline.h

-- 
2.25.0

