From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Wed, 13 Nov 2019 11:51:50 +0900
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <d828cb62-aeea-4d67-33ba-b3a93ea10a3d@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
 <20191112021747.GA68506@google.com>
 <25cb9647-007a-9c18-4784-49c0aef4f54b@arista.com>
 <20191112042546.GA119579@google.com>
 <d828cb62-aeea-4d67-33ba-b3a93ea10a3d@arista.com>
Message-ID: <20191113025150.GA101113@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On (19/11/13 02:41), Dmitry Safonov wrote:
[..]
> 
> I don't strongly disagree, but if you look at those results:
> git grep 'printk("%s.*", \(lvl\|level\)'
> 
> it seems to be used in quite a few places.

Yes, you are right, it is used in some places. That's why I said
that I'd prefer to keep that number low (minimize it). But it's
not 0 (that ship has sailed).

	-ss
