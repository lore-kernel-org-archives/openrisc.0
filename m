From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 13 Nov 2019 10:32:14 -0500
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191112044447.GA121272@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
Message-ID: <20191113103214.1585923c@gandalf.local.home>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, 12 Nov 2019 13:44:47 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > > I do recall that we talked about per-CPU printk state bit which would
> > > start/end "just print it" section. We probably can extend it to "just
> > > log_store" type of functionality. Doesn't look like a very bad idea.  
> > 
> > The problem with per-CPU printk is that we would need to disable
> > interrupts.  
> 
> Or disable preemption and have loglevel per-CPU and per-context.
> preempt_count can navigate us to the right context loglevel on
> particular CPU. I'm talking here only about backtrace (error)
> reporting contexts. Those can be atomic perfectly fine.

With my real-time hat on, I'm totally against disabling of preemption
for this purpose.

-- Steve
