From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri,  9 Mar 2018 15:02:01 +0100
Subject: [OpenRISC] [RFC PATCH 3/6] mm,
	arm64: untag user addresses in memory syscalls
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
Message-ID: <beea8ac394bfae3c7c949645fb887ceacc3f3bb3.1520600533.git.andreyknvl@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Memory subsystem syscalls accept user addresses as arguments, but don't use
copy_from_user and other similar functions, so we need to handle this case
separately.

Untag user pointers passed to madvise, mbind, get_mempolicy, mincore,
mlock, mlock2, brk, mmap_pgoff, old_mmap, munmap, remap_file_pages,
mprotect, pkey_mprotect, mremap and msync.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/madvise.c   | 2 ++
 mm/mempolicy.c | 6 ++++++
 mm/mincore.c   | 2 ++
 mm/mlock.c     | 5 +++++
 mm/mmap.c      | 9 +++++++++
 mm/mprotect.c  | 2 ++
 mm/mremap.c    | 2 ++
 mm/msync.c     | 3 +++
 8 files changed, 31 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4d3c922ea1a1..909d6ba09031 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -798,6 +798,8 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	size_t len;
 	struct blk_plug plug;
 
+	start = untagged_addr(start);
+
 	if (!madvise_behavior_valid(behavior))
 		return error;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d879f1d8a44a..79d33a570c60 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1344,6 +1344,8 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 	int err;
 	unsigned short mode_flags;
 
+	start = untagged_addr(start);
+
 	mode_flags = mode & MPOL_MODE_FLAGS;
 	mode &= ~MPOL_MODE_FLAGS;
 	if (mode >= MPOL_MAX)
@@ -1479,6 +1481,8 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 	int uninitialized_var(pval);
 	nodemask_t nodes;
 
+	addr = untagged_addr(addr);
+
 	if (nmask != NULL && maxnode < MAX_NUMNODES)
 		return -EINVAL;
 
@@ -1557,6 +1561,8 @@ COMPAT_SYSCALL_DEFINE6(mbind, compat_ulong_t, start, compat_ulong_t, len,
 	unsigned long nr_bits, alloc_size;
 	nodemask_t bm;
 
+	start = untagged_addr(start);
+
 	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
 	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
 
diff --git a/mm/mincore.c b/mm/mincore.c
index fc37afe226e6..b59cf8fa3050 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -228,6 +228,8 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
 	unsigned long pages;
 	unsigned char *tmp;
 
+	start = untagged_addr(start);
+
 	/* Check the start address: needs to be page-aligned.. */
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
diff --git a/mm/mlock.c b/mm/mlock.c
index 74e5a6547c3d..2f456a458cac 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -714,6 +714,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 
 SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
 {
+	start = untagged_addr(start);
 	return do_mlock(start, len, VM_LOCKED);
 }
 
@@ -721,6 +722,8 @@ SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
 {
 	vm_flags_t vm_flags = VM_LOCKED;
 
+	start = untagged_addr(start);
+
 	if (flags & ~MLOCK_ONFAULT)
 		return -EINVAL;
 
@@ -734,6 +737,8 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 {
 	int ret;
 
+	start = untagged_addr(start);
+
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 9efdc021ad22..b63362c45cde 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -189,6 +189,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool populate;
 	LIST_HEAD(uf);
 
+	brk = untagged_addr(brk);
+
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
@@ -1495,6 +1497,8 @@ SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
 	struct file *file = NULL;
 	unsigned long retval;
 
+	addr = untagged_addr(addr);
+
 	if (!(flags & MAP_ANONYMOUS)) {
 		audit_mmap_fd(fd, flags);
 		file = fget(fd);
@@ -1556,6 +1560,8 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
 	if (offset_in_page(a.offset))
 		return -EINVAL;
 
+	a.addr = untagged_addr(a.addr);
+
 	return sys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd,
 			      a.offset >> PAGE_SHIFT);
 }
@@ -2751,6 +2757,7 @@ EXPORT_SYMBOL(vm_munmap);
 
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
+	addr = untagged_addr(addr);
 	profile_munmap(addr);
 	return vm_munmap(addr, len);
 }
@@ -2769,6 +2776,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	unsigned long ret = -EINVAL;
 	struct file *file;
 
+	start = untagged_addr(start);
+
 	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/vm/remap_file_pages.txt.\n",
 		     current->comm, current->pid);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e3309fcf586b..73d2a6befcf9 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -519,6 +519,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot)
 {
+	start = untagged_addr(start);
 	return do_mprotect_pkey(start, len, prot, -1);
 }
 
@@ -527,6 +528,7 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot, int, pkey)
 {
+	start = untagged_addr(start);
 	return do_mprotect_pkey(start, len, prot, pkey);
 }
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 049470aa1e3e..e42863a135de 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -533,6 +533,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
 
+	addr = untagged_addr(addr);
+
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		return ret;
 
diff --git a/mm/msync.c b/mm/msync.c
index ef30a429623a..03a977558f9f 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -37,12 +37,15 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 	int unmapped_error = 0;
 	int error = -EINVAL;
 
+	start = untagged_addr(start);
+
 	if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
 		goto out;
 	if (offset_in_page(start))
 		goto out;
 	if ((flags & MS_ASYNC) && (flags & MS_SYNC))
 		goto out;
+
 	error = -ENOMEM;
 	len = (len + ~PAGE_MASK) & PAGE_MASK;
 	end = start + len;
-- 
2.16.2.395.g2e18187dfd-goog

