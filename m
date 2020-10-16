From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 16 Oct 2020 11:06:38 +0200
Subject: [OpenRISC] [linux-stable-rc:linux-5.4.y 665/2391]
 drivers/android/binder.c:3776: Error: unrecognized keyword/register name
 `l.lwz
In-Reply-To: <CAAfxs77_h-DHOMFCJBWMuj1H5Rj8OiqC_U1Trs3A8gNCiPvo7w@mail.gmail.com>
References: <202010160523.r8yMbvrW-lkp@intel.com>
 <CAG48ez3VixjDrMnz6+7JjGW_ZLZCD4+dTYWUD_tNOcfEfpu1Bg@mail.gmail.com>
 <CAAfxs77_h-DHOMFCJBWMuj1H5Rj8OiqC_U1Trs3A8gNCiPvo7w@mail.gmail.com>
Message-ID: <20201016090638.GA1749385@kroah.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Oct 16, 2020 at 08:05:17AM +0900, Stafford Horne wrote:
> On Fri, Oct 16, 2020, 6:46 AM Jann Horn <jannh@google.com> wrote:
> 
> > +openrisc folks
> >
> > On Thu, Oct 15, 2020 at 11:28 PM kernel test robot <lkp@intel.com> wrote:
> > > tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > linux-5.4.y
> > > head:   85b0841aab15c12948af951d477183ab3df7de14
> > > commit: c5665cafbedd2e2a523fe933e452391a02d3adb3 [665/2391] binder:
> > Prevent context manager from incrementing ref 0
> > > config: openrisc-randconfig-r002-20201014 (attached as .config)
> > > compiler: or1k-linux-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         #
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=c5665cafbedd2e2a523fe933e452391a02d3adb3
> > >         git remote add linux-stable-rc
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > >         git fetch --no-tags linux-stable-rc linux-5.4.y
> > >         git checkout c5665cafbedd2e2a523fe933e452391a02d3adb3
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross
> > ARCH=openrisc
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    drivers/android/binder.c: Assembler messages:
> > > >> drivers/android/binder.c:3776: Error: unrecognized keyword/register
> > name `l.lwz ?ap,4(r25)'
> > >    drivers/android/binder.c:3781: Error: unrecognized keyword/register
> > name `l.addi ?ap,r0,0'
> >
> > binder is basically doing this:
> >
> > u64 data_ptr;
> > if (get_user(data_ptr, (u64 __user *)ptr))
> >   return -EFAULT;
> >
> > and GCC complains that that doesn't turn into valid assembly on
> > openrisc, where get_user() of size 8 expands into this:
> >
> > #define __get_user_asm2(x, addr, err)                   \
> > {                                                       \
> >         unsigned long long __gu_tmp;                    \
> >         __asm__ __volatile__(                           \
> >                 "1:     l.lwz %1,0(%2)\n"               \
> >                 "2:     l.lwz %H1,4(%2)\n"              \
> >                 "3:\n"                                  \
> >                 ".section .fixup,\"ax\"\n"              \
> >                 "4:     l.addi %0,r0,%3\n"              \
> >                 "       l.addi %1,r0,0\n"               \
> >                 "       l.addi %H1,r0,0\n"              \
> >                 "       l.j 3b\n"                       \
> >                 "       l.nop\n"                        \
> >                 ".previous\n"                           \
> >                 ".section __ex_table,\"a\"\n"           \
> >                 "       .align 2\n"                     \
> >                 "       .long 1b,4b\n"                  \
> >                 "       .long 2b,4b\n"                  \
> >                 ".previous"                             \
> >                 : "=r"(err), "=&r"(__gu_tmp)            \
> >                 : "r"(addr), "i"(-EFAULT), "0"(err));   \
> >         (x) = (__typeof__(*(addr)))(                    \
> >                 (__typeof__((x)-(x)))__gu_tmp);         \
> > }
> >
> > and apparently the "l.lwz %H1,4(%2)" and "l.addi %H1,r0,0" don't turn
> > into valid assembly when %H1 expands to "?ap"?
> >
> > I don't know anything about OpenRISC, but this seems like it's
> > probably an issue in the get_user() implementation.
> >
> 
> This is fixed in 5.9.  I think the patch can be cherry picked by itself.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/openrisc?h=v5.9&id=d877322bc1adcab9850732275670409e8bcca4c4

Does not apply cleanly to 5.8.y or 5.4.y, can someone please properly
backport it and send it to stable at vger.kernel.org?

thanks,

greg k-h
