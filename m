From: Vad Rulezz <vad@vr5.epicgamer.org>
Date: Sun, 06 Jan 2019 21:07:07 +0300
Subject: [OpenRISC] trap exception handling in linux kernel
Message-ID: <5C3243CB.9010606@vr5.epicgamer.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello

In arch/openrisc/kernel/traps.c we have a function:

asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
{
	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)address, current);

	regs->pc += 4;
}

Is there a reason for regs->pc increment?

I think typically debuggers wants to resume program execution from the same address which caused a trap (after disabling a breakpoint, and it's a sw breakpoint after replacing an instruction at this address).



Vad Rulezz
