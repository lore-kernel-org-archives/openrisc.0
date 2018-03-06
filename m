From: Wu, Aaron <Aaron.Wu@analog.com>
Date: Tue, 6 Mar 2018 10:35:28 +0000
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <CAK8P3a2Jg93i-DCU0jVMUqX6b9tEx3odsEGj8dTBNjSoN-8ZRQ@mail.gmail.com>
References: <CAK8P3a2GP8uQWe+DCD=p-JLHxXBUTBpx9nnpNzF_Hz49XA9a8A@mail.gmail.com>
 <5ef16c51-7cc5-9111-7e54-edfe77f39f4b@metafoo.de>
 <649EF91064D35D40B9C93A225BF41674ADE252E2@NWD2MBX6.ad.analog.com>
 <CAK8P3a2Jg93i-DCU0jVMUqX6b9tEx3odsEGj8dTBNjSoN-8ZRQ@mail.gmail.com>
Message-ID: <649EF91064D35D40B9C93A225BF41674ADE25B7B@NWD2MBX6.ad.analog.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



> -----Original Message-----
> From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On
> Behalf Of Arnd Bergmann
> Sent: 2018年3月6日 17:39
> To: Wu, Aaron <Aaron.Wu@analog.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>; linux-arch at vger.kernel.org; linux-
> <kernel@vger.kernel.org>; linux-hexagon at vger.kernel.org;
> liqin.linux at gmail.com; lennox.wu at gmail.com; gxt at mprc.pku.edu.cn;
> linux at roeck-us.net; viro at zeniv.linux.org.uk; jhogan at kernel.org; linux-
> metag at vger.kernel.org; jonas at southpole.se; stefan.kristiansson at saunalahti.fi;
> shorne at gmail.com; openrisc at lists.librecores.org; dhowells at redhat.com;
> peterz at infradead.org
> Subject: Re: Re: Removing architectures without upstream gcc support
> 
> On Mon, Mar 5, 2018 at 11:57 AM, Wu, Aaron <Aaron.Wu@analog.com> wrote:
> >> -----Original Message-----
> >> -------- Forwarded Message --------
> >> Subject: Re: Removing architectures without upstream gcc support
> >> Date: Mon, 26 Feb 2018 09:26:57 +0100
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> To: Florian Fainelli <f.fainelli@gmail.com>
> >> CC: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing
> >> List <linux- kernel@vger.kernel.org>, Richard Kuo
> >> <rkuo@codeaurora.org>, open list:QUALCOMM HEXAGON...
> >> <linux-hexagon@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>,
> >> Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
> >> Guenter Roeck <linux@roeck-us.net>, Al Viro
> >> <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, open
> >> list:METAG ARCHITECTURE <linux-metag@vger.kernel.org>, Jonas Bonn
> >> <jonas@southpole.se>, Stefan Kristiansson
> >> <stefan.kristiansson@saunalahti.fi>,
> >> Stafford Horne <shorne@gmail.com>, openrisc at lists.librecores.org,
> >> David Howells <dhowells@redhat.com>, Peter Zijlstra
> >> <peterz@infradead.org>
> >>
> >> On Sat, Feb 24, 2018 at 1:15 AM, Florian Fainelli <f.fainelli@gmail.com>
> wrote:
> >> > On 02/22/2018 07:45 AM, Arnd Bergmann wrote:
> >> >
> >> > Add blackfin to that list, there have been no responses from the
> >> > maintainers last time I posted patches to remove DSA header files,
> >> > so we had to go these through the networking tree. Have not see a
> >> > Blackfin pull request since forever, Aaron himself seems to agree
> >> > this should be
> >> > removed:
> >> >
> >> > http://lkml.iu.edu/hypermail/linux/kernel/1801.1/04345.html
> >>
> >
> > I'm sorry to confirm that ADI can no longer provide maintenance for
> > Blackfin in Kernel community. We will try to provide a patch to remove it.
> > Apologize... and sincerely thanks to community and all used and
> > contributed to Blackfin Linux. Looking forward we are working on
> > supporting Linux from the newer SC5xx mutli-core processors with ARM and
> SHARC DSPs in it.
> 
> Thanks a lot for your reply. I already compiled a list for files related to all of the
> architectures under discussion, but it will certainly help to have a patch from you
> as well, then I can see if one of use missed any files.
> 
> I'm looking forward to your patches for the SHARC ARM platform, I was already
> wondering about why we don't already have that platform in Linux.
> Let me know if you need any help getting that port ready for inclusion.

Thanks again, Arnd and the Community.
> 
> One more question: I see that there are a number of drivers that are only used
> on blackfin today. Do you know if any of those are shared with SHARC and still
> needed, or can we remove everything related to blackfin?

Some of them can be shared with the ARM-SHARCs processors, as of now
we may go ahead to remove everything, when merging SHARC we can revert
them back, probably with new file names without "bfin", if this sounds right.
> 
>        Arnd

Thanks
Aaron
