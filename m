From: Paul Burton <paul.burton@mips.com>
Date: Wed, 21 Nov 2018 19:45:51 +0000
Subject: [OpenRISC] [PATCH v2 16/15 v2] syscall_get_arch: add "struct
 task_struct *" argument
In-Reply-To: <20181121193512.GA11297@altlinux.org>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
 <20181121184004.jro532jopnbmru2m@pburton-laptop>
 <20181121190009.GA10301@altlinux.org> <20181121193512.GA11297@altlinux.org>
Message-ID: <20181121194549.4glznckje73z2uxk@pburton-laptop>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Dmitry,

On Wed, Nov 21, 2018 at 10:35:12PM +0300, Dmitry V. Levin wrote:
> This argument is required to extend the generic ptrace API with
> PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
> 
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-audit at redhat.com
> Cc: linux-alpha at vger.kernel.org
> Cc: linux-arch at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-c6x-dev at linux-c6x.org
> Cc: linux-hexagon at vger.kernel.org
> Cc: linux-ia64 at vger.kernel.org
> Cc: linux-m68k at lists.linux-m68k.org
> Cc: linux-mips at linux-mips.org
> Cc: linux-parisc at vger.kernel.org
> Cc: linux-riscv at lists.infradead.org
> Cc: linux-s390 at vger.kernel.org
> Cc: linux-sh at vger.kernel.org
> Cc: linux-snps-arc at lists.infradead.org
> Cc: linux-um at lists.infradead.org
> Cc: linux-xtensa at linux-xtensa.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: nios2-dev at lists.rocketboards.org
> Cc: openrisc at lists.librecores.org
> Cc: sparclinux at vger.kernel.org
> Cc: uclinux-h8-devel at lists.sourceforge.jp
> Cc: x86 at kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> 
> v2: cleaned up mips part, added Reviewed-by

I thought the last one was v2? :)

Anyway, this looks fine to me now:

    Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul
