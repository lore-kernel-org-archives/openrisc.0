From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 15 Feb 2022 10:37:15 +0000
Subject: [OpenRISC] [PATCH 08/14] arm64: simplify access_ok()
In-Reply-To: <CAMj1kXGkG0KMD2rnKAJc3V7X9LP1grbcHTNYMnj_q4GiYfG2pQ@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
 <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
 <CAMj1kXGkG0KMD2rnKAJc3V7X9LP1grbcHTNYMnj_q4GiYfG2pQ@mail.gmail.com>
Message-ID: <YguB5BeLoRc4dL7P@FVFF77S0Q05N>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Feb 15, 2022 at 10:21:16AM +0100, Ard Biesheuvel wrote:
> On Tue, 15 Feb 2022 at 10:13, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Feb 15, 2022 at 9:17 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Mon, 14 Feb 2022 at 17:37, Arnd Bergmann <arnd@kernel.org> wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > >
> > > With set_fs() out of the picture, wouldn't it be sufficient to check
> > > that bit #55 is clear? (the bit that selects between TTBR0 and TTBR1)
> > > That would also remove the need to strip the tag from the address.
> > >
> > > Something like
> > >
> > >     asm goto("tbnz  %0, #55, %2     \n"
> > >              "tbnz  %1, #55, %2     \n"
> > >              :: "r"(addr), "r"(addr + size - 1) :: notok);
> > >     return 1;
> > > notok:
> > >     return 0;
> > >
> > > with an additional sanity check on the size which the compiler could
> > > eliminate for compile-time constant values.
> >
> > That should work, but I don't see it as a clear enough advantage to
> > have a custom implementation. For the constant-size case, it probably
> > isn't better than a compiler-scheduled comparison against a
> > constant limit, but it does hurt maintainability when the next person
> > wants to change the behavior of access_ok() globally.
> >
> 
> arm64 also has this leading up to the range check, and I think we'd no
> longer need it:
> 
>     if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
>         (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
>             addr = untagged_addr(addr);
> 

ABI-wise, we aim to *reject* tagged pointers unless the task is using the
tagged addr ABI, so we need to retain both the untagging logic and the full
pointer check (to actually check the tag bits) unless we relax that ABI
decision generally (or go context-switch the TCR_EL1.TBI* bits).

Since that has subtle ABI implications, I don't think we should change that
within this series.

If we *did* relax things, we could just check bit 55 here, and unconditionally
clear that in uaccess_mask_ptr(), since LDTR/STTR should fault on kernel memory.
On parts with meltdown those might not fault until committed, and so we need
masking to avoid speculative access to a kernel pointer, and that requires the
prior explciit check.

Thanks,
Mark.
