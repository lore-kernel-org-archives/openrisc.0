From: Robin Murphy <robin.murphy@arm.com>
Date: Fri, 9 Mar 2018 14:15:00 +0000
Subject: [OpenRISC] [RFC PATCH 0/6] arm64: untag user pointers passed to
	the kernel
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
Message-ID: <963e112a-88a0-94bc-e6eb-0e9f9a6ee14a@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Andrey,

On 09/03/18 14:01, Andrey Konovalov wrote:
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [1]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.

If you propose changing the ABI, then 
Documentation/arm64/tagged-pointers.txt needs to reflect the new one, 
since passing nonzero tags via syscalls is currently explicitly forbidden.

Robin.

> This patch makes a few of the kernel interfaces accept tagged user
> pointers. The kernel is already able to handle user faults with tagged
> pointers and has the untagged_addr macro, which this patchset reuses.
> 
> We're not trying to cover all possible ways the kernel accepts user
> pointers in one patchset, so this one should be considered as a start.
> It would be nice to learn about the interfaces that I missed though.
> 
> Sending this as an RFC, as I'm not sure if this should be committed as is,
> and would like to receive some feedback.
> 
> Thanks!
> 
> [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
> 
> Andrey Konovalov (6):
>    arm64: add type casts to untagged_addr macro
>    arm64: untag user addresses in copy_from_user and others
>    mm, arm64: untag user addresses in memory syscalls
>    mm, arm64: untag user addresses in mm/gup.c
>    lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
>    arch: add untagged_addr definition for other arches
> 
>   arch/alpha/include/asm/uaccess.h      |  2 ++
>   arch/arc/include/asm/uaccess.h        |  1 +
>   arch/arm/include/asm/uaccess.h        |  2 ++
>   arch/arm64/include/asm/uaccess.h      |  9 +++++++--
>   arch/blackfin/include/asm/uaccess.h   |  2 ++
>   arch/c6x/include/asm/uaccess.h        |  2 ++
>   arch/cris/include/asm/uaccess.h       |  2 ++
>   arch/frv/include/asm/uaccess.h        |  2 ++
>   arch/ia64/include/asm/uaccess.h       |  2 ++
>   arch/m32r/include/asm/uaccess.h       |  2 ++
>   arch/m68k/include/asm/uaccess.h       |  2 ++
>   arch/metag/include/asm/uaccess.h      |  2 ++
>   arch/microblaze/include/asm/uaccess.h |  2 ++
>   arch/mips/include/asm/uaccess.h       |  2 ++
>   arch/mn10300/include/asm/uaccess.h    |  2 ++
>   arch/nios2/include/asm/uaccess.h      |  2 ++
>   arch/openrisc/include/asm/uaccess.h   |  2 ++
>   arch/parisc/include/asm/uaccess.h     |  2 ++
>   arch/powerpc/include/asm/uaccess.h    |  2 ++
>   arch/riscv/include/asm/uaccess.h      |  2 ++
>   arch/score/include/asm/uaccess.h      |  2 ++
>   arch/sh/include/asm/uaccess.h         |  2 ++
>   arch/sparc/include/asm/uaccess.h      |  2 ++
>   arch/tile/include/asm/uaccess.h       |  2 ++
>   arch/x86/include/asm/uaccess.h        |  2 ++
>   arch/xtensa/include/asm/uaccess.h     |  2 ++
>   include/asm-generic/uaccess.h         |  2 ++
>   lib/strncpy_from_user.c               |  2 ++
>   lib/strnlen_user.c                    |  2 ++
>   mm/gup.c                              | 12 ++++++++++++
>   mm/madvise.c                          |  2 ++
>   mm/mempolicy.c                        |  6 ++++++
>   mm/mincore.c                          |  2 ++
>   mm/mlock.c                            |  5 +++++
>   mm/mmap.c                             |  9 +++++++++
>   mm/mprotect.c                         |  2 ++
>   mm/mremap.c                           |  2 ++
>   mm/msync.c                            |  3 +++
>   38 files changed, 105 insertions(+), 2 deletions(-)
> 
