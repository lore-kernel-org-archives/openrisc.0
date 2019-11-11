From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Nov 2019 11:15:31 +0100
Subject: [OpenRISC] [PATCH 10/21] asm-generic: ioremap_uc should behave
 the same with and without MMU
In-Reply-To: <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com>
References: <20191029064834.23438-1-hch@lst.de>
 <20191029064834.23438-11-hch@lst.de>
 <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com>
Message-ID: <20191111101531.GA12294@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Nov 11, 2019 at 11:09:05AM +0100, Arnd Bergmann wrote:
> Maybe we could move the definition into the atyfb driver itself?
> 
> As I understand it, the difference between ioremap()/ioremap_nocache()
> and ioremap_uc() only exists on pre-PAT x86-32 systems (i.e. 486, P5,
> Ppro, PII, K6, VIA C3), while on more modern systems (all non-x86,
> PentiumIII, Athlon, VIA C7)  those three are meant to be synonyms
> anyway.

That's not how I understood it.  Based on the code and the UC-
explanation ioremap_uc always overrides the MTRR, which can still
be present on more modern x86 systems.  In fact I remember a patch
floating around very recently adding another ioremap_uc caller in
some Atom platform device driver that works around buggy MTRR
tables.  Also this series actually adds a new override and a few
callers for ia64 platform code, which works very similar to x86
based on the comments in the code.  That being said I'm not sure
the callers in ia64 are really required, but it was the safest thing
to do as part of this cleanup.
