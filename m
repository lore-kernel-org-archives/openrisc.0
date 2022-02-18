From: Christoph Hellwig <hch@lst.de>
Date: Fri, 18 Feb 2022 07:28:51 +0100
Subject: [OpenRISC] [PATCH v2 05/18] x86: remove __range_not_ok()
In-Reply-To: <20220216131332.1489939-6-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-6-arnd@kernel.org>
Message-ID: <20220218062851.GC22576@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 16, 2022 at 02:13:19PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The __range_not_ok() helper is an x86 (and sparc64) specific interface
> that does roughly the same thing as __access_ok(), but with different
> calling conventions.
> 
> Change this to use the normal interface in order for consistency as we
> clean up all access_ok() implementations.
> 
> This changes the limit from TASK_SIZE to TASK_SIZE_MAX, which Al points
> out is the right thing do do here anyway.
> 
> The callers have to use __access_ok() instead of the normal access_ok()
> though, because on x86 that contains a WARN_ON_IN_IRQ() check that cannot
> be used inside of NMI context while tracing.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Link: https://lore.kernel.org/lkml/YgsUKcXGR7r4nINj at zeniv-ca.linux.org.uk/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/events/core.c         |  2 +-
>  arch/x86/include/asm/uaccess.h | 10 ++++++----
>  arch/x86/kernel/dumpstack.c    |  2 +-
>  arch/x86/kernel/stacktrace.c   |  2 +-
>  arch/x86/lib/usercopy.c        |  2 +-
>  5 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index e686c5e0537b..eef816fc216d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2794,7 +2794,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  static inline int
>  valid_user_frame(const void __user *fp, unsigned long size)
>  {
> -	return (__range_not_ok(fp, size, TASK_SIZE) == 0);
> +	return __access_ok(fp, size);
>  }

valid_user_frame just need to go away and the following __get_user calls
replaced with normal get_user ones.

> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 53de044e5654..da534fb7b5c6 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -85,7 +85,7 @@ static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
>  	 * Make sure userspace isn't trying to trick us into dumping kernel
>  	 * memory by pointing the userspace instruction pointer at it.
>  	 */
> -	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
> +	if (!__access_ok((void __user *)src, nbytes))
>  		return -EINVAL;

This one is not needed at all as copy_from_user_nmi already checks the
access range.

> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index 15b058eefc4e..ee117fcf46ed 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -90,7 +90,7 @@ copy_stack_frame(const struct stack_frame_user __user *fp,
>  {
>  	int ret;
>  
> -	if (__range_not_ok(fp, sizeof(*frame), TASK_SIZE))
> +	if (!__access_ok(fp, sizeof(*frame)))
>  		return 0;

Just switch the __get_user calls below to get_user instead.
