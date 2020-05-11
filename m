From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 May 2020 18:35:04 +0200
Subject: [OpenRISC] sort out the flush_icache_range mess
In-Reply-To: <CAMuHMdU1xAmyWysi5xRoaRL7PFurPncvEL0CcEY0V_sUz3EJPw@mail.gmail.com>
References: <20200510075510.987823-1-hch@lst.de>
 <CAMuHMdXazsBw0mjJd0uFHQud7qbb5-Uw-PTDB3+-M=huRWOfgQ@mail.gmail.com>
 <20200511151356.GB28634@lst.de>
 <CAMuHMdU1xAmyWysi5xRoaRL7PFurPncvEL0CcEY0V_sUz3EJPw@mail.gmail.com>
Message-ID: <20200511163503.GA32228@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, May 11, 2020 at 05:25:45PM +0200, Geert Uytterhoeven wrote:
> > Do you want to drop the:
> >
> >     select HAVE_AOUT if MMU
> >
> > for m68k then?
> 
> If that helps to reduce maintenance, it's fine for me.
> That leaves alpha as the sole user?

Yes.  And for alpha it isn't classic Linux a.out, but the OSF/1 ECOFF
format, which might lead to further cleanups eventually.
