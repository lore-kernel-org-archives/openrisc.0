From: Stafford Horne <shorne@gmail.com>
Date: Sat, 23 May 2020 06:01:54 +0900
Subject: [OpenRISC] [PATCH 0/1] OpenRISC port
In-Reply-To: <alpine.DEB.2.21.2005221846590.10437@digraph.polyomino.org.uk>
References: <20200522113633.209664-1-shorne@gmail.com>
 <alpine.DEB.2.21.2005221846590.10437@digraph.polyomino.org.uk>
Message-ID: <20200522210154.GA75760@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, May 22, 2020 at 06:52:20PM +0000, Joseph Myers wrote:
> On Fri, 22 May 2020, Stafford Horne via Libc-alpha wrote:
> 
> > Hi All,
> > 
> > This is the patch for the OpenRISC port of glibc.
> 
> Please see <https://sourceware.org/glibc/wiki/NewPorts> for information to 
> include in a new port submission.  That includes pointing to architecture 
> and ABI manuals.

Thank you for the pointers, I will include this in v2.  But the architecture
manual is here:

 - Page: https://openrisc.io/architecture
 - PDF: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf

 - Architecture Revision Required for Full Hard Float support:
  - https://openrisc.io/proposals/p17-user-mode-fpcsr

> > The original patch was put together by Christian Scensson a few years ago.  I
> > have taken the patch and finished all of the TODO items and run and fixed all of
> > the test failures.
> 
> Do you mean Christian Svensson?  (There's a copyright assignment from 
> Christian Svensson for GCC GLIBC BINUTILS from 2014.)

Yes Christian Svensson, sorry for the typo.  He is listed in the changelog on
the patch.

> 
> > TEST RESULTS
> > 
> > Pretty much all tests are passing however there are several math (fpu) tests
> > which are failing due to issues with setting underflow/overflow flags.  These
> 
> There should not be any such failures with a correct port and architecture 
> implementation.

OK, I will look into it again.  The last I remember there was somethign strange
happening with underflow exception not being set in the GCC FPU emulation code.

Note, the OpenRISC implementation I tested with has only 32-bit FPU hard
support.  This meant that C API for log/cos/sin etc which internally are defined
to use 64-bit double's all end up using emulation.

> > I can provide more details.
> 
> Full test results should be provided (see the above mentioned wiki page).

I will do with the next round of patches.  This is all very helpful.

-Stafford
