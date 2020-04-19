From: Stafford Horne <shorne@gmail.com>
Date: Mon, 20 Apr 2020 05:57:28 +0900
Subject: [OpenRISC] [PATCHv3 24/50] openrisc: Add show_stack_loglvl()
In-Reply-To: <20200418201944.482088-25-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-25-dima@arista.com>
Message-ID: <20200419205728.GT7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Apr 18, 2020 at 09:19:18PM +0100, Dmitry Safonov wrote:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with

Instead of realization I would say "Implementation".

> lower log level or higher than the stacktrace (depending on
> a platform or user).
> 
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
> 
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
> 
> Introduce show_stack_loglvl(), that eventually will substitute
> show_stack().

Will you do the work to replace show_stack(), when is that planned?

Other than that small comment this looks fine.

Acked-by: Stafford Horne <shorne@gmail.com>


> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: openrisc at lists.librecores.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima at arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
