From: Joseph Myers <joseph@codesourcery.com>
Date: Fri, 22 May 2020 20:56:08 +0000
Subject: [OpenRISC] [PATCH 1/1] Initial support for OpenRISC
In-Reply-To: <20200522113633.209664-2-shorne@gmail.com>
References: <20200522113633.209664-1-shorne@gmail.com>
 <20200522113633.209664-2-shorne@gmail.com>
Message-ID: <alpine.DEB.2.21.2005222027180.10437@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, 22 May 2020, Stafford Horne via Libc-alpha wrote:

> This patch includes the OpenRISC glibc support for linux.

This is missing a build-many-glibcs.py update.  You always need to include 
such an update with a new port, which must build at least one 
configuration for each ABI supported by the port (and may build any major 
non-ABI variants that seem relevant).  build-many-glibcs.py results for 
the port must be clean (i.e. no failures in the compilation part of the 
testsuite), at least when building with GCC and binutils master (it's OK 
if you need features or bug fixes not in the most recent release branches, 
although distributors might prefer such fixes to be backported).  
Similarly, there should be NEWS and README updates.

New 32-bit ports should preferably be set up to support only 64-bit time 
and 64-bit offsets (see ARC and RV32 patch postings for examples).

> diff --git a/sysdeps/or1k/bits/atomic.h b/sysdeps/or1k/bits/atomic.h

There should be no such file.  bits/ is only for installed headers, not 
internal ones.  See commit de071d199a8578055edf2722114788ae749823aa ("Move 
bits/atomic.h to atomic-machine.h (bug 14912).", 11 Sep 2015).

> diff --git a/sysdeps/or1k/nptl/bits/semaphore.h b/sysdeps/or1k/nptl/bits/semaphore.h

Do you really need this file?  See commit 
1270fbaaeebe642db335fccaaf98c82e6647cc0d ("semaphore: consolidate arch 
headers into a generic one", 5 May 2020).

> +  # Needed for relro detection
> +  libc_commonpagesize=0x2000
> +  libc_relro_required=yes

See commit cb403c34c6f6e1cce5018864485958cfc2e28906 ("Remove relro 
configure test.", 27 Jun 2014).

When you have an old out-of-tree port, it's a good idea to go through 
cross-architecture commits from when the port was first created onwards to 
identify such global changes that need to be applied to that port.

> diff --git a/sysdeps/unix/sysv/linux/or1k/bits/mman.h b/sysdeps/unix/sysv/linux/or1k/bits/mman.h

You shouldn't have this file.  See the comment in 
sysdeps/unix/sysv/linux/bits/mman.h (and commit 
d3a43e49f342c4663af0fff9d95000cfe26867c3, "Unify many bits/mman.h 
headers.", 18 Sep 2018, and commit 
61d8b5feeed36e242a043befe9b11f7f8c294f58, "Share MAP_* flags between more 
architectures.", 26 Sep 2018):

/* These definitions are appropriate for architectures that, in the
   Linux kernel, either have no uapi/asm/mman.h, or have one that
   includes asm-generic/mman.h without any changes or additions
   relevant to glibc.  If there are additions relevant to glibc, an
   architecture-specific bits/mman.h is needed.  */

> diff --git a/sysdeps/unix/sysv/linux/or1k/configure.ac b/sysdeps/unix/sysv/linux/or1k/configure.ac
> new file mode 100644
> index 0000000000..505530d5c3
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/configure.ac
> @@ -0,0 +1,4 @@
> +GLIBC_PROVIDES dnl See aclocal.m4 in the top level source directory.
> +# Local configure fragment for sysdeps/unix/sysv/linux/or1k.
> +
> +arch_minimum_kernel=3.4.0

You'll probably need a newer minimum kernel when requiring 64-bit time 
support, until all the fallback for 64-bit time on 32-bit kernels without 
the 64-bit-time syscalls is implemented.

> +#undef __ASSUME_SET_ROBUST_LIST

Are you sure this is never supported on this architecture?  
arch/openrisc/include/asm/futex.h appears to have gained 
futex_atomic_cmpxchg_inatomic in 4.11, so I'd expect the #undef only to be 
for kernels older than that.

> diff --git a/sysdeps/unix/sysv/linux/or1k/sys/procfs.h b/sysdeps/unix/sysv/linux/or1k/sys/procfs.h

See commit d62f9ec0cce26a275ec68f4564814041a33395b1 ("Complete 
sys/procfs.h unification.", 25 Sep 2018).  You shouldn't have an 
architecture-specific version of this file; add whatever bits/ headers are 
needed instead.

In general, each architecture-specific file needs a justification that 
either no generic version exists or the generic one is unsuitable or 
suboptimal for this architecture; the default is that we want to use 
unified implementations of as many files as possible.

-- 
Joseph S. Myers
joseph at codesourcery.com
