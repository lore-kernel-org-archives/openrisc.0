From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 28 Mar 2018 05:04:40 -0700
Subject: [OpenRISC] [PATCH 01/16] initrd: Add generic code path for
 common initrd unloading logic.
In-Reply-To: <20180324174458.26423-2-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180324174458.26423-2-shea@shealevy.com>
Message-ID: <20180328120440.GB1838@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
> +void free_initrd_mem(unsigned long start, unsigned long end)
> +{
> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
> +}
> +#endif

Given how trivial this is and how many architectures can use it I'd
reverse the polarity and add a CONFIG_HAVE_ARCH_FREE_INITRD_MEM
instead.
