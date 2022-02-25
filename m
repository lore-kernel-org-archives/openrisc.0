From: Dinh Nguyen <dinguyen@kernel.org>
Date: Thu, 24 Feb 2022 22:33:46 -0600
Subject: [OpenRISC] [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS
 users
In-Reply-To: <20220216131332.1489939-19-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-19-arnd@kernel.org>
Message-ID: <3927b6f5-c8d0-1421-407d-850ede02dd0f@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 2/16/22 07:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are no remaining callers of set_fs(), so CONFIG_SET_FS
> can be removed globally, along with the thread_info field and
> any references to it.
> 
> This turns access_ok() into a cheaper check against TASK_SIZE_MAX.
> 
> With CONFIG_SET_FS gone, so drop all remaining references to
> set_fs()/get_fs(), mm_segment_t and uaccess_kernel().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/Kconfig                              |  3 -
>   arch/alpha/Kconfig                        |  1 -
>   arch/alpha/include/asm/processor.h        |  4 --
>   arch/alpha/include/asm/thread_info.h      |  2 -
>   arch/alpha/include/asm/uaccess.h          | 19 ------
>   arch/arc/Kconfig                          |  1 -
>   arch/arc/include/asm/segment.h            | 20 -------
>   arch/arc/include/asm/thread_info.h        |  3 -
>   arch/arc/include/asm/uaccess.h            |  1 -
>   arch/arm/lib/uaccess_with_memcpy.c        | 10 ----
>   arch/csky/Kconfig                         |  1 -
>   arch/csky/include/asm/processor.h         |  2 -
>   arch/csky/include/asm/segment.h           | 10 ----
>   arch/csky/include/asm/thread_info.h       |  2 -
>   arch/csky/include/asm/uaccess.h           |  3 -
>   arch/csky/kernel/asm-offsets.c            |  1 -
>   arch/h8300/Kconfig                        |  1 -
>   arch/h8300/include/asm/processor.h        |  1 -
>   arch/h8300/include/asm/segment.h          | 40 -------------
>   arch/h8300/include/asm/thread_info.h      |  3 -
>   arch/h8300/kernel/entry.S                 |  1 -
>   arch/h8300/kernel/head_ram.S              |  1 -
>   arch/h8300/mm/init.c                      |  6 --
>   arch/h8300/mm/memory.c                    |  1 -
>   arch/hexagon/Kconfig                      |  1 -
>   arch/hexagon/include/asm/thread_info.h    |  6 --
>   arch/hexagon/kernel/process.c             |  1 -
>   arch/microblaze/Kconfig                   |  1 -
>   arch/microblaze/include/asm/thread_info.h |  6 --
>   arch/microblaze/include/asm/uaccess.h     | 24 --------
>   arch/microblaze/kernel/asm-offsets.c      |  1 -
>   arch/microblaze/kernel/process.c          |  1 -
>   arch/nds32/Kconfig                        |  1 -
>   arch/nds32/include/asm/thread_info.h      |  4 --
>   arch/nds32/include/asm/uaccess.h          | 15 +----
>   arch/nds32/kernel/process.c               |  5 +-
>   arch/nds32/mm/alignment.c                 |  3 -
>   arch/nios2/Kconfig                        |  1 -
>   arch/nios2/include/asm/thread_info.h      |  9 ---
>   arch/nios2/include/asm/uaccess.h          | 12 ----

For NIOS2:

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
