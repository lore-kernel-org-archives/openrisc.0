From: Stafford Horne <shorne@gmail.com>
Date: Sun, 26 Dec 2021 07:44:28 +0900
Subject: [OpenRISC] [PATCH v3 00/13] Glibc OpenRISC port
In-Reply-To: <CAAfxs75QcK2VkXOtbR70y9SjcNnqvNtTMq0bt+8M1az3A_LVPg@mail.gmail.com>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <cedcb34e-36e3-3bb8-07b7-8412c052b81d@linaro.org>
 <Ybl/E2BWBGRMwF0G@antec> <YcSZ0iyC6STzh9uP@antec>
 <87pmpnnwjf.fsf@igel.home> <YcTpmhHaqS5KaFTG@antec>
 <CAAfxs75QcK2VkXOtbR70y9SjcNnqvNtTMq0bt+8M1az3A_LVPg@mail.gmail.com>
Message-ID: <YceezKrlAWqcnpS0@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Dec 25, 2021 at 04:24:35PM +0900, Stafford Horne wrote:
> On Fri, Dec 24, 2021, 6:26 AM Stafford Horne <shorne@gmail.com> wrote:
> 
> > On Thu, Dec 23, 2021 at 04:57:56PM +0100, Andreas Schwab wrote:
> > > On Dez 24 2021, Stafford Horne via Libc-alpha wrote:
> > >
> > > > It seems the write to the tmp file was failing due the re-open not
> > passing
> > > > O_LARGEFILE.
> > >
> > > open64 implies O_LARGEFILE, so if that is making a difference, then your
> > > open64 is broken.
> >
> > Right, that is what the docs say.  This architecuture is 32-bits.
> >
> > And the open64 path is generic.
> >
> > Possibly this bit removing O_LARGEFILE is wrong?
> >
> > In sysdeps/unix/sysv/linux/open64.c:
> >
> >   27 #ifdef __OFF_T_MATCHES_OFF64_T
> >   28 # define EXTRA_OPEN_FLAGS 0
> >   29 #else
> >   30 # define EXTRA_OPEN_FLAGS O_LARGEFILE
> >   31 #endif
> >
> > Otherwise there is something is wrong on linux.  It is explicitly checking
> > for the precense of O_LARGEFILE.
> >
> > in fs/read_write.c in generic_write_check_limits:
> >
> >         if (!(file->f_flags & O_LARGEFILE))
> >                 max_size = MAX_NON_LFS;
> >
> 
> There's something wrong with __OFF_T_MATCHES_OFF64_T in this port.  We have
> 32-bit off_t in Linux.  So __OFF_T_MATCHES_OFF64_T should be undefined I
> think.  I'll look into.

So, __OFF_T_MATCHES_OFF64_T if defined if TIMESIZE==64 && WORDSIZE==32, and it's
correct from glibc's perspective as off_t is 64-bits in the user API.  However,
it is not correct for use for setting O_LARGEFILE.

In linux the O_LARGEFILE flag is forced based on architecture configuration
ARCH_32BIT_OFF_T.

    #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))

Then it is used in syscalls:

    SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags,
		    umode_t, mode)
    {
	    if (force_o_largefile())
		    flags |= O_LARGEFILE;
	    return do_sys_open(dfd, filename, flags, mode);
    }

On most 32-bit architectures ARCH_32BIT_OFF_T is configured.  SO I think there
is something wrong with how we are setting up EXTRA_OPEN_FLAGS based on
__OFF_T_MATCHES_OFF64_T only.  Maybe it should be changed to WORDSIZE==32 or a
combination.  I will send a separate patch to discuss.

-Stafford
