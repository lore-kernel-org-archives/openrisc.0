From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 15 Feb 2022 02:47:05 +0000
Subject: [OpenRISC] [PATCH 04/14] x86: use more conventional access_ok()
 definition
In-Reply-To: <Ygq4wy9fikDYmuHU@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org>
 <YgqLFYqIqkIsNC92@infradead.org>
 <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
 <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
 <Ygq4wy9fikDYmuHU@zeniv-ca.linux.org.uk>
Message-ID: <YgsUKcXGR7r4nINj@zeniv-ca.linux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 08:17:07PM +0000, Al Viro wrote:
> On Mon, Feb 14, 2022 at 12:01:05PM -0800, Linus Torvalds wrote:
> > On Mon, Feb 14, 2022 at 11:46 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > As Al pointed out, they turned out to be necessary on sparc64, but the only
> > > definitions are on sparc64 and x86, so it's possible that they serve a similar
> > > purpose here, in which case changing the limit from TASK_SIZE to
> > > TASK_SIZE_MAX is probably wrong as well.
> > 
> > x86-64 has always(*) used TASK_SIZE_MAX for access_ok(), and the
> > get_user() assembler implementation does the same.
> > 
> > I think any __range_not_ok() users that use TASK_SIZE are entirely
> > historical, and should be just fixed.
> 
> IIRC, that was mostly userland stack trace collection in perf.
> I'll try to dig in archives and see what shows up - it's been
> a while ago...

After some digging:

	access_ok() needs only to make sure that MMU won't go anywhere near
the kernel page tables; address limit for 32bit threads is none of its
concern, so TASK_SIZE_MAX is right for it.

	valid_user_frame() in arch/x86/events/core.c: used while walking
the userland call chain.  The reason it's not access_ok() is only that
perf_callchain_user() might've been called from interrupt that came while
we'd been under KERNEL_DS.
	That had been back in 2015 and it had been obsoleted since 2017, commit
88b0193d9418 (perf/callchain: Force USER_DS when invoking perf_callchain_user()).
We had been guaranteed USER_DS ever since.
	IOW, it could've reverted to use of access_ok() at any point after that.
TASK_SIZE vs TASK_SIZE_MAX is pretty much an accident there - might've been
TASK_SIZE_MAX from the very beginning.

	copy_stack_frame() in arch/x86/kernel/stacktrace.c: similar story,
except the commit that made sure callers will have USER_DS - cac9b9a4b083
(stacktrace: Force USER_DS for stack_trace_save_user()) in this case.
Also could've been using access_ok() just fine.  Amusingly, access_ok()
used to be there, until it had been replaced with explicit check on
Jul 22 2019 - 4 days after that had been made useless by fix in the caller...

	copy_from_user_nmi().  That one is a bit more interesting.
We have a call chain from perf_output_sample_ustack() (covered by
force_uaccess_begin() these days, not that it mattered for x86 now),
there's something odd in dumpstack.c:copy_code() (with explicit check
for TASK_SIZE_MAX in the caller) and there's a couple of callers in
Intel PMU code.
	AFAICS, there's no reason whatsoever to use TASK_SIZE
in that one - the point is to prevent copyin from the kernel
memory, and in that respect TASK_SIZE_MAX isn't any worse.
The check in copy_code() probably should go.

	So all of those guys should be simply switched to access_ok().
Might be worth making that a preliminary patch - it's independent
from everything else and there's no point folding it into any of the
patches in the series.
