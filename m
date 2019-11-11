From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Nov 2019 11:29:23 +0100
Subject: [OpenRISC] [PATCH 10/21] asm-generic: ioremap_uc should behave
 the same with and without MMU
In-Reply-To: <CAK8P3a0rTvfPP2LUMw8EC0xz5gfZP5+NUkoaZBJrtYYfr6YRig@mail.gmail.com>
References: <20191029064834.23438-1-hch@lst.de>
 <20191029064834.23438-11-hch@lst.de>
 <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com>
 <20191111101531.GA12294@lst.de>
 <CAK8P3a0rTvfPP2LUMw8EC0xz5gfZP5+NUkoaZBJrtYYfr6YRig@mail.gmail.com>
Message-ID: <20191111102923.GA12974@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Nov 11, 2019 at 11:27:27AM +0100, Arnd Bergmann wrote:
> Ok, fair enough. Let's just go with your version for now, if only to not
> hold your series up more. I'd still suggest we change atyfb to only
> use ioremap_uc() on i386 and maybe ia64. I can send a patch for that.

I don't think we even need it on ia64.  But lets kick off a dicussion
with the atyfb, x86 and ia64 maintainers after this series is in.
Which was kinda my plan anyway.
