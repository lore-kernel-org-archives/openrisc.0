From: Stafford Horne <shorne@gmail.com>
Date: Tue, 7 Apr 2020 21:19:58 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for v5.6
Message-ID: <20200407121958.GQ7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Er, Sorry, this should be for 5.7.

I was a bit confused because of other things going on.  Let me know if you are
ok with this or need a new tag.  It should apply just fine for 5.7.

-Stafford

On Tue, Apr 07, 2020 at 09:16:15PM +0900, Stafford Horne wrote:
> Hi Linus,
> 
> Please consider pulling...
> 
> The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:
> 
>   Linux 5.5 (2020-01-26 16:23:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/openrisc/linux.git tags/for-linus
> 
> for you to fetch changes up to 9737e2c5f0bc768b58416ec070bd96c91c52a153:
> 
>   openrisc: Remove obsolete show_trace_task function (2020-03-18 22:10:44 +0900)
> 
> ----------------------------------------------------------------
> OpenRISC updates for 5.6
> 
> A few cleanups all over the place, things of note:
>  - Enable the clone3 syscall
>  - Remove CONFIG_CROSS_COMPILE from Krzysztof Kozlowski
>  - Update to use mmgrab from Julia Lawall
> 
> ----------------------------------------------------------------
> Julia Lawall (1):
>       openrisc: use mmgrab
> 
> Krzysztof Kozlowski (1):
>       openrisc: configs: Cleanup CONFIG_CROSS_COMPILE
> 
> Stafford Horne (4):
>       openrisc: Convert copy_thread to copy_thread_tls
>       openrisc: Enable the clone3 syscall
>       openrisc: Cleanup copy_thread_tls docs and comments
>       openrisc: Remove obsolete show_trace_task function
> 
>  Documentation/openrisc/openrisc_port.rst   |  4 ++--
>  arch/openrisc/Kconfig                      |  1 +
>  arch/openrisc/configs/or1ksim_defconfig    |  1 -
>  arch/openrisc/configs/simple_smp_defconfig |  1 -
>  arch/openrisc/include/uapi/asm/unistd.h    |  1 +
>  arch/openrisc/kernel/process.c             | 18 ++++++------------
>  arch/openrisc/kernel/smp.c                 |  3 ++-
>  arch/openrisc/kernel/traps.c               |  7 -------
>  8 files changed, 12 insertions(+), 24 deletions(-)
