From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 May 2022 13:09:46 +0200
Subject: [PATCH v4 0/7] Generic Ticket Spinlocks
In-Reply-To: <20220430153626.30660-1-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com>
Message-ID: <CAK8P3a1VjunJE5zAm96pkQX7EvVDcN6VGT8usedeO709KQnB_g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Apr 30, 2022 at 5:36 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Comments on the v3 looked pretty straight-forward, essentially just that
> RCsc issue I'd missed from the v2 and some cleanups.  A part of the
> discussion some additional possible cleanups came up related to the
> qrwlock headers, but I hadn't looked at those yet and I had already
> handled everything else.  This went on the back burner, but given that
> LoongArch appears to want to use it for their new port I think it's best
> to just run with this and defer the other cleanups until later.
>
> I've placed the whole patch set at palmer/tspinlock-v4, and also tagged
> the asm-generic bits as generic-ticket-spinlocks-v4.  Ideally I'd like
> to take that, along with the RISC-V patches, into my tree as there's
> some RISC-V specific testing before things land in linux-next.  This
> passes all my testing, but I'll hold off until merging things anywhere
> else to make sure everyone has time to look.  There's no rush on my end
> for this one, but I don't want to block LoongArch so I'll try to stay a
> bit more on top of this one.

I took another look as well and everything seems fine. I had expected
that I would merge it into the asm-generic tree first and did not bother
sending a separate Reviewed-by tag, but I agree that it's best if you
create the branch.

Can you add 'Reviewed-by: Arnd Bergmann <arnd@arndb.de>'
to each patch and send me a pull request for a v5 tag so we can
merge that into both the riscv and the asm-generic trees?

       Arnd
