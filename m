From: Palmer Dabbelt <palmer@sifive.com>
Date: Wed, 21 Nov 2018 07:47:07 -0800 (PST)
Subject: [OpenRISC] [PATCH v2 16/15] syscall_get_arch: add "struct
	task_struct *" argument
In-Reply-To: <20181121004422.GA29053@altlinux.org>
Message-ID: <mhng-c75e14b8-b36c-46c2-8ffc-914312ed0cef@palmer-si-x1c4>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, 20 Nov 2018 16:44:22 PST (-0800), ldv at altlinux.org wrote:
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>
> Cc: linux-alpha at vger.kernel.org
> Cc: linux-arch at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-audit at redhat.com
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

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
