From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Dec 2021 06:26:50 +0900
Subject: [OpenRISC] [PATCH v3 00/13] Glibc OpenRISC port
In-Reply-To: <87pmpnnwjf.fsf@igel.home>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <cedcb34e-36e3-3bb8-07b7-8412c052b81d@linaro.org>
 <Ybl/E2BWBGRMwF0G@antec> <YcSZ0iyC6STzh9uP@antec>
 <87pmpnnwjf.fsf@igel.home>
Message-ID: <YcTpmhHaqS5KaFTG@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Dec 23, 2021 at 04:57:56PM +0100, Andreas Schwab wrote:
> On Dez 24 2021, Stafford Horne via Libc-alpha wrote:
> 
> > It seems the write to the tmp file was failing due the re-open not passing
> > O_LARGEFILE.
> 
> open64 implies O_LARGEFILE, so if that is making a difference, then your
> open64 is broken.

Right, that is what the docs say.  This architecuture is 32-bits.

And the open64 path is generic.

Possibly this bit removing O_LARGEFILE is wrong?

In sysdeps/unix/sysv/linux/open64.c:

  27 #ifdef __OFF_T_MATCHES_OFF64_T
  28 # define EXTRA_OPEN_FLAGS 0
  29 #else
  30 # define EXTRA_OPEN_FLAGS O_LARGEFILE
  31 #endif

Otherwise there is something is wrong on linux.  It is explicitly checking
for the precense of O_LARGEFILE.

in fs/read_write.c in generic_write_check_limits:

        if (!(file->f_flags & O_LARGEFILE))
                max_size = MAX_NON_LFS;

> -- 
> Andreas Schwab, schwab at linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
