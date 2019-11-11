From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Mon, 11 Nov 2019 10:23:36 +0900
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
Message-ID: <20191111012336.GA85185@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On (19/11/08 14:04), Petr Mladek wrote:
[..]
> I agree that it is complicated to pass the loglevel as
> a parameter. It would be better define the default
> log level for a given code section. It might be stored
> in task_struct for the normal context and in per-CPU
> variables for interrupt contexts.

I do recall that we talked about per-CPU printk state bit which would
start/end "just print it" section. We probably can extend it to "just
log_store" type of functionality. Doesn't look like a very bad idea.
"This task/context is in trouble, whatever it printk()-s is important".

Per-console loglevel also might help sometimes. Slower consoles would
->write() only critical messages, faster consoles everything.

Passing log_level as part of message payload, which printk machinery
magically hides is not entirely exciting. What we have in the code
now - printk("%s blah\n", lvl) - is not what we see in the logs.
Because the leading '%s' becomes special. And printk()/sprintf()
documentation should reflect that: '%s' prints a string, but sometimes
it doesn't.

	-ss
