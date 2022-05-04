From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Wed, 4 May 2022 13:10:04 +0200
Subject: [PATCH v2] hw/openrisc: use right OMPIC size variable
In-Reply-To: <YnGPDumfp1+6DUQG@antec>
References: <20220502232800.259036-1-Jason@zx2c4.com>
 <20220503094533.402157-1-Jason@zx2c4.com> <YnGPDumfp1+6DUQG@antec>
Message-ID: <CAHmME9prmCzpg6h-j3o7zUiYzePuegqJOAGSH167H4L-DH=QMg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 3, 2022 at 10:22 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On Tue, May 03, 2022 at 11:45:33AM +0200, Jason A. Donenfeld wrote:
> > This appears to be a copy and paste error. The UART size was used
> > instead of the much smaller OMPIC size. But actually that smaller OMPIC
> > size is wrong too and doesn't allow the IPI to work in Linux. So set it
> > to the old value.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  hw/openrisc/openrisc_sim.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> > index 99b14940f4..3218db6656 100644
> > --- a/hw/openrisc/openrisc_sim.c
> > +++ b/hw/openrisc/openrisc_sim.c
> > @@ -78,7 +78,7 @@ static const struct MemmapEntry {
> >      [OR1KSIM_DRAM] =      { 0x00000000,          0 },
> >      [OR1KSIM_UART] =      { 0x90000000,      0x100 },
> >      [OR1KSIM_ETHOC] =     { 0x92000000,      0x800 },
> > -    [OR1KSIM_OMPIC] =     { 0x98000000,         16 },
> > +    [OR1KSIM_OMPIC] =     { 0x98000000,      0x100 },
>
> Right, I missed this as part of my series.  OMPIC will allocate 2 32-bit
> registers per CPU.  I documented this here:
>
>   - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-ompic.c
>
> I think what we will want here is something like:
>
> [OR1KSIM_OMPIC] =     { 0x98000000, 8 * OR1KSIM_CPUS_MAX },

Do you want a v3 or are you going to fix it up yourself?

Jason
