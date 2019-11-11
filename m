From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Nov 2019 11:36:22 +0100
Subject: [OpenRISC] [PATCH 03/21] ia64: rename ioremap_nocache to
 ioremap_uc
In-Reply-To: <20191029064834.23438-4-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
 <20191029064834.23438-4-hch@lst.de>
Message-ID: <CAK8P3a3k2KRyhCy4OWJkToNBiw_mw0e_A=Ta6UANMMF3EXnhmA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Oct 29, 2019 at 7:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On ia64 ioremap_nocache fails if attributes don't match.  Not other
> architectures does this, and we plan to get rid of ioremap_nocache.
> So get rid of the special semantics and define ioremap_nocache in
> terms of ioremap as no portable driver could rely on the behavior
> anyway.
>
> However x86 implements ioremap_uc in a similar way as the ia64
> version of ioremap_nocache, in that it ignores the firmware tables.
> Switch ia64 to override ioremap_uc instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Good idea,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
