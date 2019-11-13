From: Dmitry Safonov <dima@arista.com>
Date: Wed, 13 Nov 2019 02:41:50 +0000
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191112042546.GA119579@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
 <20191112021747.GA68506@google.com>
 <25cb9647-007a-9c18-4784-49c0aef4f54b@arista.com>
 <20191112042546.GA119579@google.com>
Message-ID: <d828cb62-aeea-4d67-33ba-b3a93ea10a3d@arista.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 11/12/19 4:25 AM, Sergey Senozhatsky wrote:
> On (19/11/12 02:40), Dmitry Safonov wrote:
> [..]
>> In my point of view the cost of one-time [mostly build] testing every
>> architecture is cheaper than introducing some new smart code that will
>> live forever.
> 
> Well, there may be the need to pass loglevel deeper due to "hey __show_stack()
> on that arch invokes bar(), which invokes foo() and now foo() does printk(),
> but we don't see it". The context which decided to backtaraces decided
> to do so for a reason, probably, so I guess we can look at it as "a special
> error reporting code block".
> 
> The proposed patch set passes loglevel via slightly unusual channel -
> via sprintf(). We probably can do it, but I would prefer to minimize
> the number of such printk-s in the kernel. The code snippet which I
> posted also does pretty unusual thing w.r.t loglevel. Both approaches
> are "non-standard" from that POV.

I don't strongly disagree, but if you look at those results:
git grep 'printk("%s.*", \(lvl\|level\)'

it seems to be used in quite a few places.

Thanks,
          Dmitry
