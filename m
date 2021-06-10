From: Alan Modra <amodra@gmail.com>
Date: Thu, 10 Jun 2021 22:36:28 +0930
Subject: [OpenRISC] [PATCH v2] bfd/elf32-or1k: fix building with gcc
 version < 5
In-Reply-To: <3ef9acac-9f1a-2aab-1c9e-a0d4aaae6ccd@benettiengineering.com>
References: <YME2SzQdpj/AVz/2@antec>
 <20210609215233.1611478-1-giulio.benetti@benettiengineering.com>
 <YMFosi4vsWnxf9Sj@bubble.grove.modra.org>
 <3ef9acac-9f1a-2aab-1c9e-a0d4aaae6ccd@benettiengineering.com>
Message-ID: <YMIOVK3h+AooX4DR@bubble.grove.modra.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jun 10, 2021 at 11:07:13AM +0200, Giulio Benetti wrote:
> Hello Alan, All,
> 
> On 6/10/21 3:19 AM, Alan Modra wrote:
> > On Wed, Jun 09, 2021 at 11:52:33PM +0200, Giulio Benetti wrote:
> > > Gcc version >= 5 has standard C mode not set to -std=gnu11, so if we use
> > > an old compiler(i.e. gcc 4.9) build fails on:
> > > ```
> > > elf32-or1k.c:2251:3: error: 'for' loop initial declarations are only allowed in
> > > C99 or C11 mode
> > >      for (size_t i = 0; i < insn_count; i++)
> > >      ^
> > > ```
> > 
> > Did you find this problem on current mainline binutils?  The configure
> > machinery is supposed to supply the appropriate -std=c99 or -std=gnu99
> > when using older compilers.  That happens for me when I build with
> > gcc-4.9.  I don't think any patch is needed for mainline.
> > 
> 
> On Buildroot they don't pass -std=c99/g99 and this is the result:
> https://gitlab.com/bootlin/toolchains-builder/-/jobs/1325646298

That appears to be building binutils 2.35.2

> This patch seems to follow all the rest code style of binutils

True, we've only just switched over to requiring C99.

> since no
> other part of it fails and this happens only after patch [1] has been
> upstreamed.
> 
> Here [2] you can see all the other toolchains built succesfully and only
> Openrisc fails after the patch provided by Stafford([1]).
> 
> [1]: http://patches-tcwg.linaro.org/patch/53151/
> [2]: https://gitlab.com/bootlin/toolchains-builder/-/jobs

OK, so the real problem is in a backport.  It isn't current mainline
binutils configure, which is what I was worried about.

BTW, thank you for posting a fix here, even if it isn't strictly
necessary for mainline.  Please note that I'm not advocating against
your patch.  If target maintainers want to keep their code compatible
with C89 that's fine by me.

-- 
Alan Modra
Australia Development Lab, IBM
