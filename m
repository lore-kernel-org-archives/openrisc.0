From: Stafford Horne <shorne@gmail.com>
Date: Wed, 5 Jan 2022 06:36:25 +0900
Subject: [OpenRISC] [PATCH v5 00/13] Glibc OpenRISC port
In-Reply-To: <3b11ca1a-e0c6-9245-d91a-6d987e9e40fd@linaro.org>
References: <20220104031414.2416928-1-shorne@gmail.com>
 <3b11ca1a-e0c6-9245-d91a-6d987e9e40fd@linaro.org>
Message-ID: <YdS92XAL/U+57Qfx@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jan 04, 2022 at 09:34:47AM -0300, Adhemerval Zanella wrote:
> 
> 
> On 04/01/2022 00:14, Stafford Horne via Libc-alpha wrote:
> > This is the OpenRISC port for glibc that I have been working on.
> > 
> > Changes since v4:
> >  - Fix suggestion from Joseph Myers
> >    - Remove libnsl.abilist
> >  - Fixed suggestions from Adhemerval:
> >    - Use Elf32_Addr and Elf32_Sym on link.h and sotruss-lib.c.
> >    - Remove the superflous atomic typedefs on atomic-machine.h.
> >    - Add the _dl_find_object on libc.abilist.
> >    - Update wording for the NEWS entry.
> >  - Other fixes
> >    - Update date to 2022
> >    - Remove uneeded REGSIZE
> >    - Remove trailing newlines in Makefile
> >    - Fix space vs tabs indentation in sysdep.h
> > 
> > Changes since v3:
> >  - Fix suggestion from Paul Eggert
> >    - Fix typo pore/port
> >  - Fixed suggestions from Adhemerval:
> >    - Used ENTRY/END asm macros where missing
> >    - Remove block in dl-machine.h suggesting LD_PROFILE
> >    - Remove jmp_buf-macros.h  macros and use new default.
> >    - Remove tcb-offsets.sym file and Makefile reference.
> >    - Remove tcb-offsets.h include in tls.h.
> >    - Define lib-audit register layout inline with other architectures.
> >    - Fix usage of locally defined register in or1k_get_got.  Also, fixup
> >      indentation when using or1k_get_got.
> >    - Cleanup abilists after rebasing, adding rseq and removing
> >      empty files.
> >    - Remove prctl and other unused entries in the linux Makefile.
> >    - Fix STACK_ALIGN to 4 bytes, from incorrect copy-n-paste 16 bytes.
> >    - Use default pthreadtypes-arch.h.
> >    - Mention only soft-float supported in NEWS.
> >    - Remove sysdeps/unix/sysv/linux/or1k/bits/timesize.h and use new
> >      default.
> > 
> > Changes since v2:
> >  - Fixed suggestions from Joseph Myers:
> >    - Fix comment style, and description on top of each file
> >    - Make sure macros have parentheses when needed,
> >    - Bump required kernel down to 5.4.0 and document
> >    - Regenerate arch-syscall.h
> >  - Fixed suggestions from Adhemerval:
> >    - Remove kernel_stat.h
> >    - Just set MMAP2_PAGE_UNIT to 8K
> >    - Remove ioctl.c and syscall.c files
> >  - Update TCB alignment to 32 bytes
> > 
> > Changes since v1:
> >  - Update api's as suggested by Florian
> >  - Remove hard float support
> >  - Updates to get all tests passing
> >  - Split patch into managable bits similar to recent ARC port
> > 
> > Documentation:
> > 
> >   Architecture / ABI docs:
> >    https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf
> > 
> > Test Results:
> > 
> >   build-many-glibcs.py:
> > 
> >    PASS with mainline ang gcc-11.
> > 
> >   Full test suite:
> > 
> >   This time I ran the test suite with timeout of 300 and with patch for forcing
> >   O_LARGEFILE in open64 [0].  The test has one failure but it seems like flaky
> >   test as it passed after the second run.
> This is already approved, so I take these tests were done against and slight order
> tree (which is fine btw).

Sorry, I forgot to update this bit for v5.  The patch for open64 is already
upstream.

> > 
> >     # results in file: /home/shorne/work/gnu-toolchain/log/test--20211226-162029.log
> >     # test start:    2021-12-26T16:20:29+09:00
> > 
> >     # failures
> >     FAIL: posix/tst-execveat   /* Running second time passes */
> > 
> >     # test finish:   2021-12-29T12:54:08+09:00
> >     # test duration: 2 days 20 hours 33 minutes and 39 seconds
> >     # test for file: tests.sum
> >     # test wrapper:  /home/shorne/work/gnu-toolchain/glibc/scripts/cross-test-ssh.sh --timeoutfactor 300 10.0.0.5
> > 
> >     # summary
> > 	  1 FAIL
> >        4148 PASS
> > 	 31 UNSUPPORTED
> > 	 16 XFAIL
> > 	  2 XPASS
> > 
> >     posix/tst-execveat.out:
> > 	Timed out: killed the child process
> > 	Termination time: 2021-12-29T01:02:42.433964340
> > 	Last write to standard output: 2021-12-28T23:22:40.266363000
> > 
> >     tests.sum: https://gist.github.com/stffrdhrn/88c1fce0c54350258f1f5869068d015a
> > 
> >  [0] https://sourceware.org/pipermail/libc-alpha/2021-December/134634.html
> > 
> 
> I approved the missing patch and I think the patches are ok to go in.  I am
> curious about the posix/tst-execveat issues, but since it does not really 
> have any arch-specific implementation I think it might be related to the
> test environment (it would be good to know exactly what has caused the
> failure so we can improve it).

It fails with what looks like a deadlock but I cannot reproduce it.  When it
fails it times our after several minutes, when I run it again it passes right
away.

The platform I run on loads binaries over NFS.  There may be some kind of race
condition caused when binaries are loading slowly.

I will wait a day or so for comments then push this upstream.  If no objections,
thanks for all your help reviewing.  Note, after pushing up stream I will also
publish all of the updates to the glibc wiki.

-Stafford
