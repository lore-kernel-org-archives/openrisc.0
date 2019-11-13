From: Dmitry Safonov <dima@arista.com>
Date: Wed, 13 Nov 2019 02:25:15 +0000
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191113012337.GA70781@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com> <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
 <20191112101229.GA201294@google.com> <20191113012337.GA70781@google.com>
Message-ID: <25ff45f0-6420-f660-55a8-637f11ab5ab4@arista.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 11/13/19 1:23 AM, Sergey Senozhatsky wrote:
> On (19/11/12 19:12), Sergey Senozhatsky wrote:
>> On (19/11/12 09:35), Petr Mladek wrote:
>> [..]
>>> This is getting too complicated. It would introduce too many
>>> hidden rules. While the explicitly passed loglevel parameter
>>> is straightforward and clear.
>>
>> If loglevel is DEFAULT or NOTICE or INFO then we can overwrite it
>> (either downgrade or upgrade). That's one rule, basically. Not too
>> complicated, I guess.
> 
> Can be taken even a bit further than
> 
> 	show_stack(NULL, NULL, LOGLEVEL_DEBUG);
> or
> 	show_stack(NULL, NULL, LOGLEVEL_ERR);
> 
> For instance,
> 
> 	spin_lock_irqsave(&rq->lock, flags);
> 	printk_emergency_enter(LOGLEVEL_SCHED);
> 		...
> 		show_stack(...);
> 		printk();
> 		printk();
> 		...
> 	spin_unlock_irqrestore(&rq->lock, flags);
> 
> or
> 
> 	spin_lock_irqsave(&uart_port->lock, flags);
> 	printk_emergency_enter(LOGLEVEL_SCHED);
> 		...
> 		printk();
> 		printk();
> 		...

Yeah, that makes sense.

I believe it's up to you, Petr and Steven to decide what's better for
printk(). I mean, after all you care for all this code.

I guess I've pointed that in my point of view price for one-time testing
code is cheaper than adding a new printk feature to swap log levels on
the fly. But again, it's just how I see it - if we fix those printing
problems, than in half year we will forget they ever existed, but in
your proposal, there will still be some clever printk code.

On the other side, also worth to note that current patches set fix
problems for kdb (and for my hung task printing patch), but it's
incomplete for sysrq driver. I've gone through functions used by sysrq
driver and the same changes introducing log level parameter would be
needed for: sched_show_task(), debug_show_all_locks(), show_regs(),
show_state(), show_mem(). Some of them don't need any platform changes,
but at least show_regs() needs.
So, you also need to have that in mind making the decision.

Thanks,
          Dmitry
