From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Nov 2019 11:10:59 +0100
Subject: [OpenRISC] [PATCH 17/21] lib: provide a simple generic ioremap
 implementation
In-Reply-To: <20191029064834.23438-18-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
 <20191029064834.23438-18-hch@lst.de>
Message-ID: <CAK8P3a0zfmup8DYQQnT3GNCkgcv9cWxejj2QAr+FmYWs46ZuHQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Oct 29, 2019 at 7:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> A lot of architectures reuse the same simple ioremap implementation, so
> start lifting the most simple variant to lib/ioremap.c.  It provides
> ioremap_prot and iounmap, plus a default ioremap that uses prot_noncached,
> although that can be overridden by asm/io.h.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
