From: Petr Mladek <pmladek@suse.com>
Date: Wed, 13 Nov 2019 09:47:22 +0100
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191113063334.GA147997@google.com>
References: <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
 <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
 <20191112101229.GA201294@google.com>
 <20191113012337.GA70781@google.com>
 <25ff45f0-6420-f660-55a8-637f11ab5ab4@arista.com>
 <20191113063334.GA147997@google.com>
Message-ID: <20191113084722.emzee7g34zki4kkl@pathway.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed 2019-11-13 15:33:34, Sergey Senozhatsky wrote:
> On (19/11/13 02:25), Dmitry Safonov wrote:
> > I guess I've pointed that in my point of view price for one-time testing
> > code is cheaper than adding a new printk feature to swap log levels on
> > the fly.
> [..]
> > I've gone through functions used by sysrq driver and the same changes
> > introducing log level parameter would be needed for: sched_show_task(),
> > debug_show_all_locks(), show_regs(), show_state(), show_mem(). Some of
> > them don't need any platform changes, but at least show_regs() needs.
> 
> Good points and nice conclusion.
> 
> Well, here we go. There is a number of generally useful functions that
> print nice data and where people might want to have better loglevel control
> (for debugging purposes). show_stack() is just one of them.

Could you please provide some examples so that we get an idea about
the scope, usefulness, and requirements?

> Patching all
> those functions, which you have mentioned above, is hardly a fun task to do.
> Hence the printk() per-CPU per-context loglevel proposition. The code there
> is not clever or complicated and is meant for debugging purposes only, but
> with just 3 lines of code one can do some stuff:
> 
> 	/* @BTW you can't do this with "%s" KERN_FOO ;P */
> +	printk_emergency_enter(LOGLEVEL_SCHED);
> +	debug_show_all_locks();
> +	printk_emergency_exit();

But this will not solve situations where the original loglevel should
stay from any reason. It happened in this patchset, see

https://lkml.kernel.org/r/20191106091258.GS25745 at shell.armlinux.org.uk
https://lkml.kernel.org/r/20191106132516.GC5808 at willie-the-truck

We would need to investigate more potential users of this feature to
see eventual requirements. If there are too many exceptions and modes
then the generic API might get pretty complicated.

At the moment, I am in favor of this patchset. It is huge and
needed a lot of manual work. But the result is straightforward and
easy to understand.

Best Regards,
Petr
