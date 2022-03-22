From: Stafford Horne <shorne@gmail.com>
Date: Tue, 22 Mar 2022 13:10:08 +0900
Subject: [OpenRISC] [PATCH 3/5] openrisc: Move to ticket-spinlock
In-Reply-To: <CAJF2gTSFh0NKLys7kr=UdQWHDyYgg3XmgTJtVaL37Re7QdZ8uw@mail.gmail.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-4-palmer@rivosinc.com>
 <YjjuOZMzQlnqfLDJ@antec>
 <CAJF2gTSFh0NKLys7kr=UdQWHDyYgg3XmgTJtVaL37Re7QdZ8uw@mail.gmail.com>
Message-ID: <YjlMIGKgYaLLpp5T@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Mar 22, 2022 at 11:29:13AM +0800, Guo Ren wrote:
> On Tue, Mar 22, 2022 at 7:23 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Wed, Mar 16, 2022 at 04:25:58PM -0700, Palmer Dabbelt wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > We have no indications that openrisc meets the qspinlock requirements,
> > > so move to ticket-spinlock as that is more likey to be correct.
> > >
> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > >
> > > ---
> > >
> > > I have specifically not included Peter's SOB on this, as he sent his
> > > original patch
> > > <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> > > without one.
> > > ---
> > >  arch/openrisc/Kconfig                      | 1 -
> > >  arch/openrisc/include/asm/Kbuild           | 5 ++---
> > >  arch/openrisc/include/asm/spinlock.h       | 3 +--
> > >  arch/openrisc/include/asm/spinlock_types.h | 2 +-
> > >  4 files changed, 4 insertions(+), 7 deletions(-)
> >
> > Hello,
> >
> > This series breaks SMP support on OpenRISC.  I haven't traced it down yet, it
> > seems trivial but I have a few places to check.
> >
> > I replied to this on a kbuild warning thread, but also going to reply here with
> > more information.
> >
> >  https://lore.kernel.org/lkml/YjeY7CfaFKjr8IUc at antec/#R
> >
> > So far this is what I see:
> >
> >   * ticket_lock is stuck trying to lock console_sem
> >   * it is stuck on atomic_cond_read_acquire
> >     reading lock value: returns 0    (*lock is 0x10000)
> >     ticket value: is 1
> >   * possible issues:
> >     - OpenRISC is big endian, that seems to impact ticket_unlock, it looks
> All csky & riscv are little-endian, it seems the series has a bug with
> big-endian. Is that all right for qemu? (If qemu was all right, but
> real hardware failed.)

Hi Guo Ren,

OpenRISC real hardware and QEMU are both big-endian.  It fails on both.

I replied on patch 1/5 with a suggested patch which fixes the issue for me.
Please have a look.

BTW. now I can look into the sparse warnings.

-Stafford

