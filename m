From: Dmitry Safonov <dima@arista.com>
Date: Mon, 11 Nov 2019 19:47:25 +0000
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191111012336.GA85185@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
Message-ID: <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Sergey, Petr,

On 11/11/19 1:23 AM, Sergey Senozhatsky wrote:
> On (19/11/08 14:04), Petr Mladek wrote:
> [..]
>> I agree that it is complicated to pass the loglevel as
>> a parameter. It would be better define the default
>> log level for a given code section. It might be stored
>> in task_struct for the normal context and in per-CPU
>> variables for interrupt contexts.
> 
> I do recall that we talked about per-CPU printk state bit which would
> start/end "just print it" section. We probably can extend it to "just
> log_store" type of functionality. Doesn't look like a very bad idea.
> "This task/context is in trouble, whatever it printk()-s is important".

I don't see how bits on task_struct or in per-cpu are easier than
supplying a log level parameter down the stack.
How would it work if sysrq_handle_crash() called by key-press?
How would that interact with deferred printing?
How would it make visible prints from current context, but not from
something that preempted it?

Furthermore, what problems are you trying to solve with this design?
Only sysrq driver? Kdb?
In my perspective it sounds too complicated and over-engineered for
something that has two-three users.
Also I've tried to point that I need to print backtrace sometimes with
KERN_DEBUG loglevel to use it in production for early notices those
needs to go only to log files and currently each architecture decides
which log level it prefers.

And what's so complicated about this patches set? I see only side of the
testing, but the build-testing is covered with 0day bot and cost nothing
and any visible regression may be found during -next period.
While introducing those printk-sections may subtly break things.

I mean, I definitely know less about printk() and its internals than you
- so my points may be a no-sense.

What I'm going to do - is to fix all build and reported issues, I'll
send v2 this week and feel free to NAK it, I will forget about those
patches and won't be offended.
I don't see many people those are "hey, we'll benefit from this".
And doing this patches set was neither quite fun (dirty business), nor
something I can be later proud of (hey, I've introduced the log level
parameter to printing functions!).

Thanks,
          Dima
