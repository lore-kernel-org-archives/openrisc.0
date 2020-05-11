From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 May 2020 17:13:56 +0200
Subject: [OpenRISC] sort out the flush_icache_range mess
In-Reply-To: <CAMuHMdXazsBw0mjJd0uFHQud7qbb5-Uw-PTDB3+-M=huRWOfgQ@mail.gmail.com>
References: <20200510075510.987823-1-hch@lst.de>
 <CAMuHMdXazsBw0mjJd0uFHQud7qbb5-Uw-PTDB3+-M=huRWOfgQ@mail.gmail.com>
Message-ID: <20200511151356.GB28634@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, May 11, 2020 at 09:46:17AM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Sun, May 10, 2020 at 9:55 AM Christoph Hellwig <hch@lst.de> wrote:
> > none of which really are used by a typical MMU enabled kernel, as a.out can
> > only be build for alpha and m68k to start with.
> 
> Quoting myself:
> "I think it's safe to assume no one still runs a.out binaries on m68k."
> http://lore.kernel.org/r/CAMuHMdW+m0Q+j3rsQdMXnrEPm+XB5Y2AQrxW5sD1mZAKgmEqoA at mail.gmail.com

Do you want to drop the:

    select HAVE_AOUT if MMU

for m68k then?

Note that we'll still need flush_icache_user_range for m68k with mmu,
as it also allows binfmt_flat for mmu configs.
