From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 16 Feb 2022 14:06:25 +0100
Subject: [OpenRISC] [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
In-Reply-To: <YgqMLYJs0RMecMck@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-12-arnd@kernel.org>
 <YgqMLYJs0RMecMck@infradead.org>
Message-ID: <CAK8P3a0PwjB+KE+j3_sknZuiuY-kUe_J76nYac-mx82dccA3Rw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 6:06 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> >  void prom_world(int enter)
> >  {
> > -     if (!enter)
> > -             set_fs(get_fs());
> > -
> >       __asm__ __volatile__("flushw");
> >  }
>
> The enter argument is now unused.

Right, good point. I'll add a comment, but I think I will leave that
as this seems
too hard to change the callers in assembly code for this. If any
sparc64 developer
wants to clean that up, I'm happy to integrate the cleanup patch in my series.

         Arnd
