From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Tue, 12 Nov 2019 13:44:47 +0900
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
Message-ID: <20191112044447.GA121272@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On (19/11/11 10:12), Petr Mladek wrote:
[..]
> > I do recall that we talked about per-CPU printk state bit which would
> > start/end "just print it" section. We probably can extend it to "just
> > log_store" type of functionality. Doesn't look like a very bad idea.
> 
> The problem with per-CPU printk is that we would need to disable
> interrupts.

Or disable preemption and have loglevel per-CPU and per-context.
preempt_count can navigate us to the right context loglevel on
particular CPU. I'm talking here only about backtrace (error)
reporting contexts. Those can be atomic perfectly fine.

I posted a silly code snippet.

[..]
> But yes, this per-code-section loglevel is problematic. The feedback
> against the patchset shows that people want it also the other way.
> I mean to keep pr_debug() as pr_debug().

Hmm. Right.

> A solution might be to use the per-code-section loglevel only instead
> of some special loglevel.

So maybe we can "overwrite" only KERN_DEFAULT loglevels?
We certainly should not mess with SCHED or with anything in between
EMERG and ERR.

> The explicitly passed loglevel makes me feel more confident that
> all needed printk() calls were updated. But it might be a false
> feeling. I do not really have any strong preference.

I'm not like really objecting, just trying to explore some other
options.

	-ss
