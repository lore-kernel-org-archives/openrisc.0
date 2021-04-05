From: Kees Cook <keescook@chromium.org>
Date: Mon, 5 Apr 2021 10:16:35 -0700
Subject: [OpenRISC] [PATCH RFC 1/3] drivers/char: remove /dev/kmem for
 good
In-Reply-To: <20210319143452.25948-2-david@redhat.com>
References: <20210319143452.25948-1-david@redhat.com>
 <20210319143452.25948-2-david@redhat.com>
Message-ID: <202104051013.F432CAC4@keescook>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 19, 2021 at 03:34:50PM +0100, David Hildenbrand wrote:
> Exploring /dev/kmem and /dev/mem in the context of memory hot(un)plug and
> memory ballooning, I started questioning the existance of /dev/kmem.
> 
> Comparing it with the /proc/kcore implementation, it does not seem to be
> able to deal with things like
> a) Pages unmapped from the direct mapping (e.g., to be used by secretmem)
>   -> kern_addr_valid(). virt_addr_valid() is not sufficient.
> b) Special cases like gart aperture memory that is not to be touched
>   -> mem_pfn_is_ram()
> Unless I am missing something, it's at least broken in some cases and might
> fault/crash the machine.
> 
> Looks like its existance has been questioned before in 2005 and 2010
> [1], after ~11 additional years, it might make sense to revive the
> discussion.
> 
> CONFIG_DEVKMEM is only enabled in a single defconfig (on purpose or by
> mistake?). All distributions I looked at disable it.
> 
> 1) /dev/kmem was popular for rootkits [2] before it got disabled
>    basically everywhere. Ubuntu documents [3] "There is no modern user of
>    /dev/kmem any more beyond attackers using it to load kernel rootkits.".
>    RHEL documents in a BZ [5] "it served no practical purpose other than to
>    serve as a potential security problem or to enable binary module drivers
>    to access structures/functions they shouldn't be touching"
> 
> 2) /proc/kcore is a decent interface to have a controlled way to read
>    kernel memory for debugging puposes. (will need some extensions to
>    deal with memory offlining/unplug, memory ballooning, and poisoned
>    pages, though)
> 
> 3) It might be useful for corner case debugging [1]. KDB/KGDB might be a
>    better fit, especially, to write random memory; harder to shoot
>    yourself into the foot.
> 
> 4) "Kernel Memory Editor" hasn't seen any updates since 2000 and seems
>    to be incompatible with 64bit [1]. For educational purposes,
>    /proc/kcore might be used to monitor value updates -- or older
>    kernels can be used.
> 
> 5) It's broken on arm64, and therefore, completely disabled there.
> 
> Looks like it's essentially unused and has been replaced by better
> suited interfaces for individual tasks (/proc/kcore, KDB/KGDB). Let's
> just remove it.
> 
> [1] https://lwn.net/Articles/147901/
> [2] https://www.linuxjournal.com/article/10505
> [3] https://wiki.ubuntu.com/Security/Features#A.2Fdev.2Fkmem_disabled
> [4] https://sourceforge.net/projects/kme/
> [5] https://bugzilla.redhat.com/show_bug.cgi?id=154796
> 
> [...]
> Cc: Linux API <linux-api@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Yes please! As James Troup pointed out already, this was turned off in
Ubuntu in 2008. I don't remember a single complaint from anyone who
wasn't a rootkit author. ;)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
