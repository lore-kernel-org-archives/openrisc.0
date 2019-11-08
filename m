From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 8 Nov 2019 15:52:48 +1100
Subject: [OpenRISC] generic-iomap tree for linux-next
In-Reply-To: <20191108132000.3e7bd5b8@canb.auug.org.au>
References: <20191029064834.23438-1-hch@lst.de> <20191107204743.GA22863@lst.de>
 <20191108132000.3e7bd5b8@canb.auug.org.au>
Message-ID: <20191108155248.0a32a03a@canb.auug.org.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Christoph,

On Fri, 8 Nov 2019 13:20:00 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Thu, 7 Nov 2019 21:47:43 +0100 Christoph Hellwig <hch@lst.de> wrote:
> >
> > can you add the generic-ioremap tree:
> > 
> >    git://git.infradead.org/users/hch/ioremap.git
> > 
> > to linux-next?   
> 
> I assume you mean the for-next branch?

With that assumption, added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20191108/a20d3957/attachment-0001.sig>
