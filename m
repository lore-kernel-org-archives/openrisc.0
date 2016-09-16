From: Stafford Horne <shorne@gmail.com>
Date: Fri, 16 Sep 2016 23:51:20 +0900 (JST)
Subject: [OpenRISC] [PATCH 0/7] openrisc: Misc fixes from backlog
In-Reply-To: <1474036985-20981-1-git-send-email-shorne@gmail.com>
References: <1474036985-20981-1-git-send-email-shorne@gmail.com>
Message-ID: <alpine.LFD.2.20.1609162350270.2354@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


Forgot to CC the new openrisc list.

On Fri, 16 Sep 2016, Stafford Horne wrote:

> Hello,
>
> This patch is a small set of fixes from the openrisc backlog. These
> changes fix several issues with the openrisc build on modern tool chains
> and address other issues which have cropped up as the kernel as it is
> being used on newer hardware.
>
> Please consider for merge.
>
> On-the-other-hand
>
> The openrisc project has been missing a kernel maintainer
> for some time now. Currently listed in MAINTAINERS is Jonas
> and a website that no longer exists.
>
>
> Some mail threads from Jonas
> https://lkml.org/lkml/2015/5/13/469 - mail from Jonas mentioning
>                                      he is no longer able to maintain
> https://lkml.org/lkml/2015/6/11/426 - mail from Jonas mentioning stefan
>                                      is to be the new maintainer
>
> Ideally stefan kristiansson would become the maintainer but he
> does not have a PGP key signed by kernel maintainers.  Also, he
> does not seem to have much time recently.
>
> We would like some help on how to proceed, options:
> - Someone take these patches into a branch that will be pulled
>   by linus? I can work to maintain the patch queue for openrisc.
> - I can work to get a my PGP key signed and send git pull requests
>   to linus?
>
> Regards,
>  Stafford
>
>
> Christian Svensson (1):
>  openrisc: Add thread-local storage (TLS) support
>
> Guenter Roeck (1):
>  openrisc: Support both old (or32) and new (or1k) toolchain
>
> Jonas Bonn (2):
>  Apply transparent_union attribute to union semun
>  openrisc: restore call-saved regs on sigreturn
>
> Rob Herring (1):
>  openrisc: remove the redundant of_platform_populate
>
> Stefan Kristiansson (2):
>  openrisc: fix PTRS_PER_PGD define
>  openrisc: add SMP and NR_CPUS Kconfig options
>
> arch/openrisc/Kconfig               | 14 ++++++++++++++
> arch/openrisc/include/asm/pgtable.h |  2 +-
> arch/openrisc/kernel/entry.S        | 10 +++++++++-
> arch/openrisc/kernel/process.c      | 13 +++++++++++++
> arch/openrisc/kernel/setup.c        | 10 ----------
> arch/openrisc/kernel/vmlinux.lds.S  |  8 +++++++-
> arch/openrisc/mm/init.c             |  2 +-
> include/uapi/linux/sem.h            |  2 +-
> 8 files changed, 46 insertions(+), 15 deletions(-)
>
> -- 
> 2.7.4
>
>

