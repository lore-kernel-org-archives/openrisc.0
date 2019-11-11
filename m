From: Petr Mladek <pmladek@suse.com>
Date: Mon, 11 Nov 2019 10:12:07 +0100
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191111012336.GA85185@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
Message-ID: <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon 2019-11-11 10:23:36, Sergey Senozhatsky wrote:
> On (19/11/08 14:04), Petr Mladek wrote:
> [..]
> > I agree that it is complicated to pass the loglevel as
> > a parameter. It would be better define the default
> > log level for a given code section. It might be stored
> > in task_struct for the normal context and in per-CPU
> > variables for interrupt contexts.
> 
> I do recall that we talked about per-CPU printk state bit which would
> start/end "just print it" section. We probably can extend it to "just
> log_store" type of functionality. Doesn't look like a very bad idea.

The problem with per-CPU printk is that we would need to disable
interrupts. It is not always wanted. Also people might not expect
this from a printk() API.


> "This task/context is in trouble, whatever it printk()-s is important".

It might be a minimal loglevel. More important messages would still
be printed() with the higher loglevel.

But yes, this per-code-section loglevel is problematic. The feedback
against the patchset shows that people want it also the other way.
I mean to keep pr_debug() as pr_debug().

A solution might be to use the per-code-section loglevel only instead
of some special loglevel.


> Per-console loglevel also might help sometimes. Slower consoles would
> ->write() only critical messages, faster consoles everything.

This looks like another problem to me. Anyway, this filtering will
work better when the loglevel will be consistent across the related
lines.

> Passing log_level as part of message payload, which printk machinery
> magically hides is not entirely exciting. What we have in the code
> now - printk("%s blah\n", lvl) - is not what we see in the logs.
> Because the leading '%s' becomes special. And printk()/sprintf()
> documentation should reflect that: '%s' prints a string, but sometimes
> it doesn't.

I personally do not see this as a big problem.

The explicitly passed loglevel makes me feel more confident that
all needed printk() calls were updated. But it might be a false
feeling. I do not really have any strong preference.

Best Regards,
Petr
