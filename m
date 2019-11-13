From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Wed, 13 Nov 2019 10:23:37 +0900
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191112101229.GA201294@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
 <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
 <20191112101229.GA201294@google.com>
Message-ID: <20191113012337.GA70781@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On (19/11/12 19:12), Sergey Senozhatsky wrote:
> On (19/11/12 09:35), Petr Mladek wrote:
> [..]
> > This is getting too complicated. It would introduce too many
> > hidden rules. While the explicitly passed loglevel parameter
> > is straightforward and clear.
>
> If loglevel is DEFAULT or NOTICE or INFO then we can overwrite it
> (either downgrade or upgrade). That's one rule, basically. Not too
> complicated, I guess.

Can be taken even a bit further than

	show_stack(NULL, NULL, LOGLEVEL_DEBUG);
or
	show_stack(NULL, NULL, LOGLEVEL_ERR);

For instance,

	spin_lock_irqsave(&rq->lock, flags);
	printk_emergency_enter(LOGLEVEL_SCHED);
		...
		show_stack(...);
		printk();
		printk();
		...
	spin_unlock_irqrestore(&rq->lock, flags);

or

	spin_lock_irqsave(&uart_port->lock, flags);
	printk_emergency_enter(LOGLEVEL_SCHED);
		...
		printk();
		printk();
		...

and so on.

	-ss
