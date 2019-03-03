From: Stafford Horne <shorne@gmail.com>
Date: Mon, 4 Mar 2019 00:29:39 +0900
Subject: [OpenRISC] trap exception handling in linux kernel
In-Reply-To: <5C3243CB.9010606@vr5.epicgamer.org>
References: <5C3243CB.9010606@vr5.epicgamer.org>
Message-ID: <CAAfxs74fdH=AnRi=MZq7G_e-09nuupOfT930fk_c7HcbZaYYRg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Did you ever get a response for this?  I believe this is to allow
jumping over the openrisc l.trap instruction.  But, as you say
GDB/debuggers will replace that instruction with the real instruction,
so it shouldn't be needed.

Have you noticed an issue or are you just auditing this?   We don't
usually run GDB from within openrisc linux, I haven't run into this
issue before.

-Stafford

On Mon, Jan 7, 2019 at 3:07 AM Vad Rulezz <vad@vr5.epicgamer.org> wrote:
>
> Hello
>
> In arch/openrisc/kernel/traps.c we have a function:
>
> asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
> {
>         force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)address, current);
>
>         regs->pc += 4;
> }
>
> Is there a reason for regs->pc increment?
>
> I think typically debuggers wants to resume program execution from the same address which caused a trap (after disabling a breakpoint, and it's a sw breakpoint after replacing an instruction at this address).
>
>
>
> Vad Rulezz
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
