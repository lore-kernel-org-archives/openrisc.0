From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 15 Feb 2022 10:12:40 +0100
Subject: [OpenRISC] [PATCH 08/14] arm64: simplify access_ok()
In-Reply-To: <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
Message-ID: <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Feb 15, 2022 at 9:17 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Mon, 14 Feb 2022 at 17:37, Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
>
> With set_fs() out of the picture, wouldn't it be sufficient to check
> that bit #55 is clear? (the bit that selects between TTBR0 and TTBR1)
> That would also remove the need to strip the tag from the address.
>
> Something like
>
>     asm goto("tbnz  %0, #55, %2     \n"
>              "tbnz  %1, #55, %2     \n"
>              :: "r"(addr), "r"(addr + size - 1) :: notok);
>     return 1;
> notok:
>     return 0;
>
> with an additional sanity check on the size which the compiler could
> eliminate for compile-time constant values.

That should work, but I don't see it as a clear enough advantage to
have a custom implementation. For the constant-size case, it probably
isn't better than a compiler-scheduled comparison against a
constant limit, but it does hurt maintainability when the next person
wants to change the behavior of access_ok() globally.

If we want to get into micro-optimizing uaccess, I think a better target
would be a CONFIG_CC_HAS_ASM_GOTO_OUTPUT version
of __get_user()/__put_user as we have on x86 and powerpc.

         Arnd
