From: Jeff Epler <jepler@unpythonic.net>
Date: Thu, 12 Jan 2017 19:04:27 -0600
Subject: [OpenRISC] [PATCH v2 7/7] uapi: export all headers under uapi
	directories
In-Reply-To: <9d68af8a-a609-d7b1-58a9-f1155313b077@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170109125638.GA15506@infradead.org>
 <464a1323-4450-e563-ff59-9e6d57b75959@6wind.com>
 <alpine.LSU.2.20.1701121727180.19188@erq.vanv.qr>
 <9d68af8a-a609-d7b1-58a9-f1155313b077@6wind.com>
Message-ID: <20170113010427.GA22650@unpythonic.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jan 12, 2017 at 05:32:09PM +0100, Nicolas Dichtel wrote:
> What I was trying to say is that I export those directories like other are.
> Removing those files is not related to that series.

Perhaps the correct solution is to only copy files matching "*.h" to
reduce the risk of copying files incidentally created by kbuild but
which shouldn't be installed as uapi headers.

jeff
