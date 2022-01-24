From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Jan 2022 09:45:43 +0900
Subject: [OpenRISC] [PATCH] openrisc/boot: Remove unnecessary
 initialisation in memcpy().
In-Reply-To: <20220124000249.4295-1-kuniyu@amazon.co.jp>
References: <Ye3keps4aHhkbYzr@antec>
 <20220124000249.4295-1-kuniyu@amazon.co.jp>
Message-ID: <Ye32t5ZccUwfa+ag@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jan 24, 2022 at 09:02:49AM +0900, Kuniyuki Iwashima wrote:
> From:   Stafford Horne <shorne@gmail.com>
> Date:   Mon, 24 Jan 2022 08:27:54 +0900
> > On Sun, Jan 23, 2022 at 11:01:00AM +0900, Kuniyuki Iwashima wrote:
> > > 'd' and 's' are initialised later with 'dest_w' and 'src_w', so we need not
> > > initialise them before that.
> > > 
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> > 
> > This looks fine to me.  I will queue this for the next release.
> 
> Thank you.
> 
> 
> > 
> > Just curious why are you working on OpenRISC?
> 
> While reading memcpy() variants, I found a nit to fix in x86 boot-time
> memcpy() [0].  While I'm at it, I just started reading all arch ones ;)
> 
> [0]: https://lore.kernel.org/lkml/20220123015807.45005-1-kuniyu at amazon.co.jp/

Got it.

Thanks again!
