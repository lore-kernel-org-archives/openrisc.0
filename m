From: Olof Kindgren <olof.kindgren@gmail.com>
Date: Wed, 16 Nov 2016 08:13:42 +0100
Subject: [OpenRISC] [PATCH v2 8/9] openrisc: Updates after openrisc.net
 has been lost
In-Reply-To: <85a10b7601c10dc0cf710f69d5729bf1871de22c.1479128947.git.shorne@gmail.com>
References: <cover.1479128947.git.shorne@gmail.com>
 <1479130239-30707-1-git-send-email-shorne@gmail.com>
 <85a10b7601c10dc0cf710f69d5729bf1871de22c.1479128947.git.shorne@gmail.com>
Message-ID: <CAKaYPCMmxtgzggNh=gv_k6BhvRREbdwksZWaSH_veuHSu8Oqng@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Nov 14, 2016 at 2:30 PM, Stafford Horne <shorne@gmail.com> wrote:
> The openrisc.net domain expired and was taken over by squatters.
> These updates point documentation to the new domain, mailing lists
> and git repos.
>
> Also, Jonas is not the main maintainer anylonger, he reviews changes
> but does not maintain a repo or sent pull requests.  Updating this to
> add Stafford and Stefan who are the active maintainers.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  MAINTAINERS                   | 6 ++++--
>  arch/openrisc/README.openrisc | 8 ++++----
>  arch/openrisc/kernel/setup.c  | 2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 851b89b..d84a585 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8958,9 +8958,11 @@ F:       drivers/of/resolver.c
>
>  OPENRISC ARCHITECTURE
>  M:     Jonas Bonn <jonas@southpole.se>
> -W:     http://openrisc.net
> +M:     Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> +M:     Stafford Horne <shorne@gmail.com>
> +L:     openrisc at lists.librecores.org
> +W:     http://openrisc.io
>  S:     Maintained
> -T:     git git://openrisc.net/~jonas/linux
>  F:     arch/openrisc/
>
>  OPENVSWITCH
> diff --git a/arch/openrisc/README.openrisc b/arch/openrisc/README.openrisc
> index c9f7edf..072069a 100644
> --- a/arch/openrisc/README.openrisc
> +++ b/arch/openrisc/README.openrisc
> @@ -6,7 +6,7 @@ target architecture, specifically, is the 32-bit OpenRISC 1000 family (or1k).
>
>  For information about OpenRISC processors and ongoing development:
>
> -       website         http://openrisc.net
> +       website         http://openrisc.io
>
>  For more information about Linux on OpenRISC, please contact South Pole AB.
>
> @@ -24,17 +24,17 @@ In order to build and run Linux for OpenRISC, you'll need at least a basic
>  toolchain and, perhaps, the architectural simulator.  Steps to get these bits
>  in place are outlined here.
>
> -1)  The toolchain can be obtained from openrisc.net.  Instructions for building
> +1)  The toolchain can be obtained from openrisc.io.  Instructions for building
>  a toolchain can be found at:
>
> -http://openrisc.net/toolchain-build.html
> +https://github.com/openrisc/tutorials
>
>  2) or1ksim (optional)
>
>  or1ksim is the architectural simulator which will allow you to actually run
>  your OpenRISC Linux kernel if you don't have an OpenRISC processor at hand.
>
> -       git clone git://openrisc.net/jonas/or1ksim-svn
> +       git clone https://github.com/openrisc/or1ksim.git
>
>         cd or1ksim
>         ./configure --prefix=$OPENRISC_PREFIX
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 6329d7a..cb797a3 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -295,7 +295,7 @@ void __init setup_arch(char **cmdline_p)
>
>         *cmdline_p = boot_command_line;
>
> -       printk(KERN_INFO "OpenRISC Linux -- http://openrisc.net\n");
> +       printk(KERN_INFO "OpenRISC Linux -- http://openrisc.io\n");
>  }
>
>  static int show_cpuinfo(struct seq_file *m, void *v)
> --
> 2.7.4
>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc

This looks all correct
Acked-by: Olof Kindgren <olof.kindgren@gmail.com>

