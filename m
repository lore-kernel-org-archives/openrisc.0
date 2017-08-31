From: Stafford Horne <shorne@gmail.com>
Date: Fri, 1 Sep 2017 06:58:28 +0900
Subject: [OpenRISC] [PATCH v4 0/5] sim port for OpenRISC
In-Reply-To: <c233c8b2bda3a47b4ca169571300df95@polymtl.ca>
References: <cover.1496066478.git.shorne@gmail.com>
 <20170613101549.GG6190@lianli.shorne-pla.net>
 <20170810132212.GC3031@lianli.shorne-pla.net>
 <20170823062847.GB2587@lianli.shorne-pla.net>
 <c233c8b2bda3a47b4ca169571300df95@polymtl.ca>
Message-ID: <20170831215828.GD2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Aug 31, 2017 at 09:56:46PM +0200, Simon Marchi wrote:
> On 2017-08-23 08:28, Stafford Horne wrote:
> > Hello Global Maintainers,
> > 
> > Its been about a week since I sent the last ping Mike.  It looks like he
> > hasnt been active on the list since April.  This is my patch series for
> > the
> > OpenRISC sim implementation needed to test and verify gdb.  If possible
> > I
> > would like to have it reviewed so I commit this and gdb to upstream.
> > 
> > At the moment it appears Mike may not be about to continue with the
> > review.
> > 
> > If someone knows more details please let us know.
> > 
> > -Stafford
> 
> Hi Stafford,
> 
> I'll start getting familiar with the patch series and the previous versions.
> However, it seems like patch 4/5, "sim: or1k: Add generated files.", didn't
> go through.  I don't see it in the archive either:
> 
>   https://sourceware.org/ml/gdb-patches/2017-05/threads.html#00594
> 
> Is it possible that it was too big and bounced?  If so, is it possible to
> split it?  If not, we'll need to find some other way, maybe you can compress
> it and send it as an attachment?

Hello,

Thanks for having a look at this.

That is right this one file was too large to make it through the list
filters.  I had mentioned that on the v3 series but not here, sorry.

One way to have a look is via my git repo the signed tag here:

~~~
The following changes since commit dbb2bcd0059f8d91de5a792f8684c8908c316720:

  Revert "[AArch64] Allow COPY relocation elimination" (2017-06-09 12:04:44 +0100)

are available in the git repository at:

  https://github.com/stffrdhrn/binutils-gdb.git tags/for-upstream

for you to fetch changes up to c30a4b8ddf8f133d556a4ce5486b9a95e0544720:

  sim: testsuite: add testsuite for or1k sim (2017-06-13 19:17:58 +0900)
~~~

Otherwise, Please find attached as well.

-Stafford
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-sim-or1k-Add-generated-files.patch.bz2
Type: application/x-bzip2
Size: 124467 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170901/55af987d/attachment-0001.bin>
