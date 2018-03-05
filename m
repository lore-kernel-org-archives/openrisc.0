From: Wu, Aaron <Aaron.Wu@analog.com>
Date: Mon, 5 Mar 2018 10:57:12 +0000
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <5ef16c51-7cc5-9111-7e54-edfe77f39f4b@metafoo.de>
References: <CAK8P3a2GP8uQWe+DCD=p-JLHxXBUTBpx9nnpNzF_Hz49XA9a8A@mail.gmail.com>
 <5ef16c51-7cc5-9111-7e54-edfe77f39f4b@metafoo.de>
Message-ID: <649EF91064D35D40B9C93A225BF41674ADE252E2@NWD2MBX6.ad.analog.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars at metafoo.de]
> Sent: 2018年3月5日 17:56
> To: Wu, Aaron <Aaron.Wu@analog.com>
> Subject: Fwd: Re: Removing architectures without upstream gcc support
> 
> 
> 
> 
> -------- Forwarded Message --------
> Subject: Re: Removing architectures without upstream gcc support
> Date: Mon, 26 Feb 2018 09:26:57 +0100
> From: Arnd Bergmann <arnd@arndb.de>
> To: Florian Fainelli <f.fainelli@gmail.com>
> CC: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-
> kernel at vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, open
> list:QUALCOMM HEXAGON... <linux-hexagon@vger.kernel.org>, Chen Liqin
> <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao
> <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro
> <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, open
> list:METAG ARCHITECTURE <linux-metag@vger.kernel.org>, Jonas Bonn
> <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
> Stafford Horne <shorne@gmail.com>, openrisc at lists.librecores.org, David
> Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>
> 
> On Sat, Feb 24, 2018 at 1:15 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > On 02/22/2018 07:45 AM, Arnd Bergmann wrote:
> >
> > Add blackfin to that list, there have been no responses from the
> > maintainers last time I posted patches to remove DSA header files, so
> > we had to go these through the networking tree. Have not see a
> > Blackfin pull request since forever, Aaron himself seems to agree this
> > should be
> > removed:
> >
> > http://lkml.iu.edu/hypermail/linux/kernel/1801.1/04345.html
>

I'm sorry to confirm that ADI can no longer provide maintenance for Blackfin in
Kernel community. We will try to provide a patch to remove it.
Apologize... and sincerely thanks to community and all used and contributed to
Blackfin Linux. Looking forward we are working on supporting Linux from the
newer SC5xx mutli-core processors with ARM and SHARC DSPs in it.  

> Peter Zijlstra also mentioned that one on IRC, I didn't have it on my radar before.
> Like Tile, it has only recently been marked as Orphaned in MAINTAINERS, so I'd
> be inclined to wait a little while to give possible users a chance to step up as new
> maintainers.
> 
> My plan for v4.17 is now:
> 
> - remove score, unicore and metag due to lack of toolchain
>   or interest from the maintainers.
> - keep hexagon, and try to build an llvm/clang toolchain
> - remove frv and m32r due to being abandoned for several years
> - mark tile and blackfin for pending removal later this year unless
>   a new maintainer steps up
> - mark mn10300 for pending removal unless it gets updated to
>   support chips that were made in the past 12 years and to build
>   properly.
> 
>        Arnd

Thanks and Best regards,
Aaron Wu
