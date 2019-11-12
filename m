From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Tue, 12 Nov 2019 11:17:47 +0900
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
Message-ID: <20191112021747.GA68506@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On (19/11/11 19:47), Dmitry Safonov wrote:
[..]
> I don't see how bits on task_struct or in per-cpu are easier than
> supplying a log level parameter down the stack.
> How would it work if sysrq_handle_crash() called by key-press?
> How would that interact with deferred printing?
> How would it make visible prints from current context, but not from
> something that preempted it?

[..]

per-context log_level works pretty much the same way as per-message
log_level.

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
static DEFINE_PER_CPU(int, cpu_loglevels[4]); // @INITME.. LOGLEVEL_DEBUG + 1?

static int __printing_context(void)
{
	unsigned int preempt = preempt_count();

	if (!(preempt & (NMI_MASK | HARDIRQ_MASK | SOFITRQ_OFFSET)))
		return 0;
	if (preempt & SOFITRQ_OFFSET)
		return 1;
	if (preempt & HARDIRQ_MASK)
		return 2;
	return 3;
}

static int adj_context_loglevel(int level)
{
	int ctx = __printing_context();
	int cpu_level = this_cpu_read(cpu_loglevels[ctx]);

	// this one is important
	if (level == LOGLEVEL_SCHED)
		return level;
	// we are not in emergency context
	if (cpu_level == LOGLEVEL_DEBUG + 1)
		return level;
	// we better not override these
	if (LOGLEVEL_EMERG <= level && level <= LOGLEVEL_ERR)
		return level;
	return cpu_level;
}

void printk_emergency_enter(int log_level)
{
	int ctx;

	preempt_disable();
	ctx = __printing_context();
	this_cpu_write(cpu_loglevels[ctx], log_level);
}

void printk_emergency_exit(void)
{
	int ctx = __printing_context();

	this_cpu_write(cpu_loglevels[ctx], LOGLEVEL_DEBUG + 1);
	preempt_enable();
}

void vprintk_emit(...)
{
	level = adj_context_loglevel(level);
}
//
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
//
static void __show_stack(struct task_struct *task, unsigned long *sp)
{
	printk();
	...
	printk();
}

void show_stack(struct task_struct *task, unsigned long *sp, int log_level)
{
	printk_emergency_enter(log_level);
	__show_stack(task, sp);
	printk_emergency_exit();
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //

show_stack() never schedules, disabling preemption around it should
not change anything. Should it be interrupted, we will handle it via
preempt count.

printk_emergency_enter(log_level) handles every printk() that
__show_stack() and friends do. Not worse than printk("%s Stack", lvl);
all over the place.

> What I'm going to do - is to fix all build and reported issues, I'll
> send v2 this week and feel free to NAK it, I will forget about those
> patches and won't be offended.

Lovely.
And - no, I'm not going to NAK platform specific changes. Just so you know.

*All* I'm talking about is an alternative, less "go and touch a ton of
platform code" approach. The argument "I patched so many files that I'm
not even going to discuss anything now" is not productive, to say the
least. Hope this clarifies.

	-ss
