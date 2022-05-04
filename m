From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Thu, 5 May 2022 01:19:57 +0200
Subject: [PATCH] openrisc: remove bogus nops and shutdowns
In-Reply-To: <YnL9MuVLtiGWD2EV@antec>
References: <20220504110911.283525-1-Jason@zx2c4.com> <YnL9MuVLtiGWD2EV@antec>
Message-ID: <YnMKHdRy/GkAB+9e@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, May 05, 2022 at 07:24:50AM +0900, Stafford Horne wrote:
> On Wed, May 04, 2022 at 01:09:11PM +0200, Jason A. Donenfeld wrote:
> > Nop 42 is some leftover debugging thing by the looks of it. Nop 1 will
> > shut down the simulator, which isn't what we want, since it makes it
> > possible to handle errors.
> 
> Do you mean impossible to handler errors?

Whoops, yes.

> 
> > Cc: Stafford Horne <shorne@gmail.com>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> This looks good to me, I didn't add these debug's I think we can remove them.
> 

