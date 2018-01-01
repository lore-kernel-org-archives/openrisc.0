From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Mon, 1 Jan 2018 13:03:26 +0000
Subject: [OpenRISC] OpenRISC GCC upstream plan
In-Reply-To: <20180101125546.GH32243@lianli.shorne-pla.net>
References: <20180101125546.GH32243@lianli.shorne-pla.net>
Message-ID: <3c9eb5ba-fb29-f343-058e-2d291be48046@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Stafford,

It might be worth seeking Joern Rennecke's views on what of the old
material remains significant. I don't know how much he ended up
rewriting for the TechEdSat project.

HTH,


Jeremy

On 01/01/18 12:55, Stafford Horne wrote:
> Hello,
> 
> Last year Richard sent his work on gcc7 for openrisc.
> 
> You can find it here:
> 
> git://github.com/rth7680/binutils-gdb.git or1k-3 
> git://github.com/rth7680/gcc.git or1k-7-1
> 
> which includes the additional relocations both for unmodified or1k,
> as well as implementing the l.adrp proposal from
> 
> http://openrisc.io/proposals/ladrp
> 
> Now that gdb and most of the kernel patches are upstream I have
> started to look at these.  (sorry for the long delay).  The
> improvements are great, but I would like to discuss upstream plans
> for GCC.
> 
> From what we know GCC cannot go upstream due to early patches from
> Matjaz, and he has not assigned his FSF copyright.
> 
> Options;
> 
> 1.  Continue to keep Or1k GCC out of upstream. 2.  Clean-room
> rewrite. 3.  Determine if Matjaz's contributions can be deem
> trivial and upstream the current gcc. 4.  Convince Matjaz to do FSF
> copyright assignment.
> 
> ## GCC development History ##
> 
> From CVS, SVN and Git history I have been able to track the
> following:
> 
> 2001 - [simons, lampret] Initial development on gcc port in CVS 
> 2002-2003 - [phoenix, simons, mohor] development on gcc-3.1 port
> CVS 2005 - [phoenix] imported gcc-3.4.4 patches stating (major
> optimizations for or32 target) SVN [1] 2009-2010 [Jeremy Bennett,
> Jungsook] work on gcc 4.2.2 SVN [2] - floating point support -
> dwarf support 2010-2012 [Jeremy Bennett, Joern Rennecke] work on
> gcc 4.5.1 SVN [3] - nested functions - support for c++ 2012-2015
> [pgavin, julius, stekern, bluecmd] work on gcc-4 and gcc-5 [4] -
> rename or32 to or1k - support PIC - support TLS - support Atomics 
> 2016-207 [rth] work on gcc7 [5] - major optimizations and cleanups 
> - support for tailcalls - fix delayslot - new relocations
> 
> Notes: - phoenix is Matjaz. - from 2001 to 2005 we have no history,
> the original import of gcc with history is Matjaz's in 2005
> 
> If anyone has some more input on the history or an old repo copy it
> would be helpful.
> 
> From what I can gather Matjaz did a bit of work on gcc-3, but I
> cannot really determine what.  The bulk of the work seems to be the
> initial bootstrap from Damjan the work from Jeremy's team and the
> work from 2012 on.
> 
> ## Option 3 (Derived works) ##
> 
> From previous discussions I have heard that even if we can
> determine that Matjaz's code has been removed/overwritten we cannot
> upstream the work. That being because all work since his
> contributions are derived works.
> 
> I have a new argument, that his work is not significant.  But its
> hard to determine if its trivial compared to the main development.
> 
> ## Option 2 (Rewrite) ##
> 
> If we cannot go ahead with the current code base I would like to
> start a cleanroom rewrite.   I have looked at the code enough to
> understand current features but not enough to be influenced if I
> start writing from scratch.
> 
> Since big chucks of the work are independent works can we reuse
> them in the rewrite?  For example: - PIC support - TLS support -
> Floating Point - Atomics - Tail Call optimization
> 
> Anyone want to help?
> 
> ## Next Steps ##
> 
> - Create a toolchain release of Richards 7.x branch (I have rebased
> on 7.2.0) - Gather feedback on Upstreaming/rewrite
> 
> -Stafford
> 
> [0]
> ftp://ftp.gwdg.de/pub/misc/opencores/ml-archive/archives/cvs-checkins/0212/maillist.html#00015
> - ftp.gwdg.de cvs-checkin mails [1]
> https://opencores.org/websvn,log?repname=or1k&path=%2For1k%2Ftrunk%2Fgcc%2Fgcc-3.4.4%2Fgcc%2Fconfig%2For32%2F&rev=0&isdir=1
> - web svn or1k/trunk/gcc/gcc/3.4.4 [2]
> https://opencores.org/websvn,log?repname=openrisc&path=%2Fopenrisc%2Ftrunk%2Fgnu-old%2Fgcc-4.2.2%2Fgcc%2F&rev=0&isdir=1
>
> 
[3]
https://opencores.org/websvn,log?repname=openrisc&path=%2Fopenrisc%2Ftrunk%2Fgnu-stable%2Fgcc-4.5.1%2Fgcc%2F&rev=0&isdir=1
> [4]
> https://github.com/openrisc/or1k-gcc/commits/or1k-5.4.0?before=9310fdc97ee9bd21bcc73a02ff10c8b9ecdf066f+35&path%5B%5D=gcc&path%5B%5D=config&path%5B%5D=or1k
>
> 
[5] https://github.com/rth7680/gcc/commits/or1k-7-2
> _______________________________________________ OpenRISC mailing
> list OpenRISC at lists.librecores.org 
> https://lists.librecores.org/listinfo/openrisc
> 

- -- 
Tel:     +44 (1590) 610184
Cell:    +44 (7970) 676050
SkypeID: jeremybennett
Twitter: @jeremypbennett
Email:   jeremy.bennett at embecosm.com
Web:     www.embecosm.com
PGP key: 1024D/BEF58172FB4754E1 2009-03-20
-----BEGIN PGP SIGNATURE-----

iGMEARECACMFAlpKMZ4cHGplcmVteS5iZW5uZXR0QGVtYmVjb3NtLmNvbQAKCRC+
9YFy+0dU4auJAJwIwnad1kvnmMbuQSrsnKtlSTQS6ACdFbVO19Cx4QOnr8MsXM4o
vsQqw4Y=
=2iWR
-----END PGP SIGNATURE-----
