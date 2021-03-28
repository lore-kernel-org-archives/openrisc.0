From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Sun, 28 Mar 2021 13:14:28 +0200
Subject: [OpenRISC] [PATCH v5 4/7] powerpc/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
In-Reply-To: <1616913028-83376-5-git-send-email-guoren@kernel.org>
References: <1616913028-83376-1-git-send-email-guoren@kernel.org>
 <1616913028-83376-5-git-send-email-guoren@kernel.org>
Message-ID: <e27af5e0-a462-cb75-6311-1b5a6b4ee4f1@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 28/03/2021 à 08:30, guoren at kernel.org a écrit :
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> We don't have native hw xchg16 instruction, so let qspinlock
> generic code to deal with it.

We have lharx/sthcx pair on some versions of powerpc.

See https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20201107032328.2454582-1-npiggin at gmail.com/

Christophe

> 
> Using the full-word atomic xchg instructions implement xchg16 has
> the semantic risk for atomic operations.
> 
> This patch cancels the dependency of on qspinlock generic code on
> architecture's xchg16.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
>   arch/powerpc/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 386ae12d8523..69ec4ade6521 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -151,6 +151,7 @@ config PPC
>   	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
>   	select ARCH_USE_QUEUED_RWLOCKS		if PPC_QUEUED_SPINLOCKS
>   	select ARCH_USE_QUEUED_SPINLOCKS	if PPC_QUEUED_SPINLOCKS
> +	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32	if PPC_QUEUED_SPINLOCKS
>   	select ARCH_WANT_IPC_PARSE_VERSION
>   	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>   	select ARCH_WANT_LD_ORPHAN_WARN
> 
