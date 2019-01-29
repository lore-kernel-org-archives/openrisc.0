From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 29 Jan 2019 20:52:17 +1100
Subject: [OpenRISC] [PATCH v2 02/21] powerpc: use memblock functions
	returning virtual address
In-Reply-To: <1548057848-15136-3-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-3-git-send-email-rppt@linux.ibm.com>
Message-ID: <871s4vssdq.fsf@concordia.ellerman.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Mike Rapoport <rppt@linux.ibm.com> writes:

> From: Christophe Leroy <christophe.leroy@c-s.fr>
>
> Since only the virtual address of allocated blocks is used,
> lets use functions returning directly virtual address.
>
> Those functions have the advantage of also zeroing the block.
>
> [ MR:
>  - updated error message in alloc_stack() to be more verbose
>  - convereted several additional call sites ]
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/powerpc/kernel/dt_cpu_ftrs.c |  3 +--
>  arch/powerpc/kernel/irq.c         |  5 -----
>  arch/powerpc/kernel/paca.c        |  6 +++++-
>  arch/powerpc/kernel/prom.c        |  5 ++++-
>  arch/powerpc/kernel/setup_32.c    | 26 ++++++++++++++++----------
>  5 files changed, 26 insertions(+), 19 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
