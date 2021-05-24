From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date: Tue, 25 May 2021 01:03:37 +0200
Subject: [OpenRISC] Maybe another or1k bug
In-Reply-To: <CAAfxs77Y1qOzex=Bkn5c_4Zxt6nzZP2cpG6qJ85eXnrAm18FgA@mail.gmail.com>
References: <dbcce22d-b288-2451-4a8d-681f802c6f49@benettiengineering.com>
 <CAAfxs77Y1qOzex=Bkn5c_4Zxt6nzZP2cpG6qJ85eXnrAm18FgA@mail.gmail.com>
Message-ID: <6bc67759-18c2-bca5-bdb2-c637e873b8ab@benettiengineering.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 5/25/21 12:34 AM, Stafford Horne wrote:
> I'm cc'ing the list so there is a record, and other experts could come 
> in if they like.

Ah yes, pardon

> Ok, I'll take a look.
> 
> Thanks,  these are always fun for me.

That's great :-)

> Also I forgot to respond about nios2 bugs. I could help if the bug 
> looked the same. But to me it looked different.  So I'll hold off for now.

Ok, no problem. Thank you for fixing he OpenRisc ones.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

> On Tue, May 25, 2021, 7:10 AM Giulio Benetti 
> <giulio.benetti@benettiengineering.com 
> <mailto:giulio.benetti@benettiengineering.com>> wrote:
> 
>     Hi Stafford,
> 
>     I think I've found another or1k ld bug. Here is the build failure log:
>     http://autobuild.buildroot.net/results/ca3/ca3281294392da1a5ea84dbb9cc4c5bfea0c4ccf/build-end.log
>     <http://autobuild.buildroot.net/results/ca3/ca3281294392da1a5ea84dbb9cc4c5bfea0c4ccf/build-end.log>
> 
>     It complains about:
>     pc-relative relocation against dynamic symbol
> 
>     there is an archive of some files(libcommon.a) compiled in the
>     beginning
>     that gets linked with the rest of .o files. Every file is compiled with
>     -fPIC option so this should allow to link a .o with .a but it throws
>     that error.
> 
>     I only see that error in or1k and alpha. Maybe I'm missing something.
>     When you have time and if you want, can you help me with that?
> 
>     If you want to reproduce it it's the same procedure of previous bugs
>     but
>     you need to specify ca3281294392da1a5ea84dbb9cc4c5bfea0c4ccf to
>     br-reproduce-build.
> 
>     Thanks in advance
>     and
>     Best regards
>     -- 
>     Giulio Benetti
>     Benetti Engineering sas
> 

