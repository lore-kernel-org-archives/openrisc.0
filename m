From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 14 Feb 2022 09:06:53 -0800
Subject: [OpenRISC] [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
In-Reply-To: <20220214163452.1568807-12-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-12-arnd@kernel.org>
Message-ID: <YgqMLYJs0RMecMck@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

>  void prom_world(int enter)
>  {
> -	if (!enter)
> -		set_fs(get_fs());
> -
>  	__asm__ __volatile__("flushw");
>  }

The enter argument is now unused.
