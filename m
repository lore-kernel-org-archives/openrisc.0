From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 9 Jan 2017 04:56:38 -0800
Subject: [OpenRISC] [PATCH v2 7/7] uapi: export all headers under uapi
	directories
In-Reply-To: <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <20170109125638.GA15506@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jan 06, 2017 at 10:43:59AM +0100, Nicolas Dichtel wrote:
> Regularly, when a new header is created in include/uapi/, the developer
> forgets to add it in the corresponding Kbuild file. This error is usually
> detected after the release is out.
> 
> In fact, all headers under uapi directories should be exported, thus it's
> useless to have an exhaustive list.
> 
> After this patch, the following files, which were not exported, are now
> exported (with make headers_install_all):

... snip ...

> linux/genwqe/.install
> linux/genwqe/..install.cmd
> linux/cifs/.install
> linux/cifs/..install.cmd

I'm pretty sure these should not be exported!
