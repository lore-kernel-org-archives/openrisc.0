From: Petr Mladek <pmladek@suse.com>
Date: Fri, 8 Nov 2019 14:04:47 +0100
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191108103719.GB175344@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
Message-ID: <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri 2019-11-08 19:37:19, Sergey Senozhatsky wrote:
> On (19/11/06 09:35), Petr Mladek wrote:
> > I agree with all the other justification.
> > 
> > I would add. The backtrace is really useful for debugging. It should
> > be possible to print it even in less critical situations.
> 
> Hmm, I don't know.
> Do we really need debug/info level backtraces?

debug is exactly the loglevel where registry content and backtrace
might be very useful. It is not always important to reach the console.


> May be all backtraces can be converted to something more severe
> (so we can stop playing games with loglvl) and then we can
> clean up "(ab)users"?

IMHO, we should distinguish warning, error, crit, alert, emerg
situations. Backtraces and any related messages should be
filtered the same way. Any information might be useless without
the context.

I agree that it is complicated to pass the loglevel as
a parameter. It would be better define the default
log level for a given code section. It might be stored
in task_struct for the normal context and in per-CPU
variables for interrupt contexts.

Best Regards,
Petr
