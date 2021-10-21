From: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Oct 2021 10:32:10 +0200
Subject: [OpenRISC] [PATCH 21/20] signal: Replace force_sigsegv(SIGSEGV)
 with force_fatal_sig(SIGSEGV)
In-Reply-To: <877de7jrev.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133> <877de7jrev.fsf@disp2133>
Message-ID: <CAAdtpL5+bjpy93DY5gf1ZM4k3BtP+JNJAUSSmvt8cq3shsJR4A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openrisc@lists.librecores.org

On Wed, Oct 20, 2021 at 11:52 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
>
> Now that force_fatal_sig exists it is unnecessary and a bit confusing
> to use force_sigsegv in cases where the simpler force_fatal_sig is
> wanted.  So change every instance we can to make the code clearer.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/arc/kernel/process.c       | 2 +-
>  arch/m68k/kernel/traps.c        | 2 +-
>  arch/powerpc/kernel/signal_32.c | 2 +-
>  arch/powerpc/kernel/signal_64.c | 4 ++--
>  arch/s390/kernel/traps.c        | 2 +-
>  arch/um/kernel/trap.c           | 2 +-
>  arch/x86/kernel/vm86_32.c       | 2 +-
>  fs/exec.c                       | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
