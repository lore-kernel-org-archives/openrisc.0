From: Eric W. Biederman <ebiederm@xmission.com>
Date: Thu, 21 Oct 2021 08:33:51 -0500
Subject: [OpenRISC] [PATCH 21/20] signal: Replace force_sigsegv(SIGSEGV)
 with force_fatal_sig(SIGSEGV)
In-Reply-To: <CAMuHMdURxrdjsXq7+q-AWTwxVUdmddOj2vvNHv6M=WtsU5nRvg@mail.gmail.com>
 (Geert Uytterhoeven's message of "Thu, 21 Oct 2021 10:09:46 +0200")
References: <87y26nmwkb.fsf@disp2133> <877de7jrev.fsf@disp2133>
 <CAMuHMdURxrdjsXq7+q-AWTwxVUdmddOj2vvNHv6M=WtsU5nRvg@mail.gmail.com>
Message-ID: <87tuhaijsw.fsf@disp2133>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Eric,
>
> Patch 21/20?

In reviewing another part of the patchset Linus asked if force_sigsegv
could go away.  It can't completely but I can get this far.

Given that it is just a cleanup it makes most sense to me as an
additional patch on top of what is already here.


> On Wed, Oct 20, 2021 at 11:52 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Now that force_fatal_sig exists it is unnecessary and a bit confusing
>> to use force_sigsegv in cases where the simpler force_fatal_sig is
>> wanted.  So change every instance we can to make the code clearer.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
>>  arch/m68k/kernel/traps.c        | 2 +-
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you.

Eric
