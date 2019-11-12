From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Tue, 12 Nov 2019 19:12:29 +0900
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
 <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
Message-ID: <20191112101229.GA201294@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On (19/11/12 09:35), Petr Mladek wrote:
[..]
> This is getting too complicated. It would introduce too many
> hidden rules. While the explicitly passed loglevel parameter
> is straightforward and clear.

If loglevel is DEFAULT or NOTICE or INFO then we can overwrite it
(either downgrade or upgrade). That's one rule, basically. Not too
complicated, I guess.

> I am getting more inclined to the solution introduced by this
> patchset. It looks reasonable for the different use-cases.

No pressure from my side. Up to arch maintainers.

	-ss
