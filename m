From: Dinh Nguyen <dinguyen@kernel.org>
Date: Thu, 24 Feb 2022 22:30:31 -0600
Subject: [OpenRISC] [PATCH v2 12/18] uaccess: fix type mismatch warnings
 from access_ok()
In-Reply-To: <20220216131332.1489939-13-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-13-arnd@kernel.org>
Message-ID: <824a2d98-e992-0406-518f-adcde2a1372a@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 2/16/22 07:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On some architectures, access_ok() does not do any argument type
> checking, so replacing the definition with a generic one causes
> a few warnings for harmless issues that were never caught before.
> 
> Fix the ones that I found either through my own test builds or
> that were reported by the 0-day bot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arc/kernel/process.c           |  2 +-
>   arch/arm/kernel/swp_emulate.c       |  2 +-
>   arch/arm/kernel/traps.c             |  2 +-
>   arch/csky/kernel/signal.c           |  2 +-
>   arch/mips/sibyte/common/sb_tbprof.c |  6 +++---
>   arch/nios2/kernel/signal.c          | 20 +++++++++++---------

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
