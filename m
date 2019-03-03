From: Vad Rulezz <vad@vr5.epicgamer.org>
Date: Sun, 03 Mar 2019 22:37:18 +0300
Subject: [OpenRISC] trap exception handling in linux kernel
In-Reply-To: <CAAfxs74fdH=AnRi=MZq7G_e-09nuupOfT930fk_c7HcbZaYYRg@mail.gmail.com>
References: <5C3243CB.9010606@vr5.epicgamer.org>
 <CAAfxs74fdH=AnRi=MZq7G_e-09nuupOfT930fk_c7HcbZaYYRg@mail.gmail.com>
Message-ID: <5C7C2CEE.60903@vr5.epicgamer.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

I have actually discovered it in a native debugger, ofc it was not hard to remove the line in my copy of kernel and everything ran well after that,
but I still decided to ask because I thought that maybe there is a software that depends on existing behavior.

As noone except you replied I think it's safe to remove the increment in the mainline. It likely will simplify things for native GDB too.


Vad Rulezz

On 03.03.2019 18:29, Stafford Horne wrote:
> Did you ever get a response for this?  I believe this is to allow
> jumping over the openrisc l.trap instruction.  But, as you say
> GDB/debuggers will replace that instruction with the real instruction,
> so it shouldn't be needed.
> 
> Have you noticed an issue or are you just auditing this?   We don't
> usually run GDB from within openrisc linux, I haven't run into this
> issue before.
> 
> -Stafford
> 
> On Mon, Jan 7, 2019 at 3:07 AM Vad Rulezz <vad@vr5.epicgamer.org> wrote:
>>
>> Hello
>>
>> In arch/openrisc/kernel/traps.c we have a function:
>>
>> asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
>> {
>>         force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)address, current);
>>
>>         regs->pc += 4;
>> }
>>
>> Is there a reason for regs->pc increment?
>>
>> I think typically debuggers wants to resume program execution from the same address which caused a trap (after disabling a breakpoint, and it's a sw breakpoint after replacing an instruction at this address).
>>
>>
>>
>> Vad Rulezz
>> _______________________________________________
>> OpenRISC mailing list
>> OpenRISC at lists.librecores.org
>> https://lists.librecores.org/listinfo/openrisc
> 

