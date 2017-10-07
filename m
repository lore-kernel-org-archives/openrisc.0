From: Stafford Horne <shorne@gmail.com>
Date: Sat, 7 Oct 2017 09:21:44 +0900
Subject: [OpenRISC] [PATCH 0/5] OpenRISC SMP Support
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
Message-ID: <CAAfxs76NSQFnQ0D23yUcbGzcY9a_VHOH7SyBiBHJk4YdR7V7sw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Any takers on this?  If not Ill consider sending a pull request
if/when the merge window is open.

-Stafford

On Wed, Aug 23, 2017 at 2:57 PM, Stafford Horne <shorne@gmail.com> wrote:
> Hello,
>
> This series adds SMP support for OpenRISC.  The platform is based on the
> work that Stefan Kristiansson did around 2012 implemented in Verilog and
> run on FPGAs.  I have been working to upstream this work, these are my QEMU
> patches I have been used to help with testing.
>
> I have documented the platform in the OpenRISC 1.2 specification proposal
> available here:
>   https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
>
> My latest kernel patches are available here:
>   https://github.com/stffrdhrn/linux.git openrisc-4.13-smp-qspinlock
>
> Stafford Horne (5):
>   openrisc/ompic: Add OpenRISC Multicore PIC (OMPIC)
>   target/openrisc: Make coreid and numcores configurable in state
>   openrisc/cputimer: Perparation for Multicore
>   openrisc: Initial SMP support
>   openrisc: Only kick cpu on timeout, not on update
>
>  default-configs/or1k-softmmu.mak |   1 +
>  hw/intc/Makefile.objs            |   1 +
>  hw/intc/ompic.c                  | 179 +++++++++++++++++++++++++++++++++++++++
>  hw/openrisc/cputimer.c           |  64 ++++++++++----
>  hw/openrisc/openrisc_sim.c       |  87 ++++++++++++++-----
>  target/openrisc/cpu.c            |   1 -
>  target/openrisc/cpu.h            |   7 +-
>  target/openrisc/machine.c        |   8 +-
>  target/openrisc/sys_helper.c     |   8 +-
>  9 files changed, 308 insertions(+), 48 deletions(-)
>  create mode 100644 hw/intc/ompic.c
>
> --
> 2.13.5
>
