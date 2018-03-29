From: Marc Zyngier <marc.zyngier@arm.com>
Date: Thu, 29 Mar 2018 18:53:43 +0100
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <20180329173247.GF16141@n2100.armlinux.org.uk>
References: <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
 <20180329152749.GC16141@n2100.armlinux.org.uk>
 <CAMuHMdXAckNiUQKT2WU6xaJjbECrifmH6fg_mET+h3iXf_RgDQ@mail.gmail.com>
 <20180329155827.GD16141@n2100.armlinux.org.uk>
 <86zi2qrfgl.wl-marc.zyngier@arm.com>
 <20180329173247.GF16141@n2100.armlinux.org.uk>
Message-ID: <86y3iarcns.wl-marc.zyngier@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, 29 Mar 2018 18:32:47 +0100,
Russell King - ARM Linux wrote:
> 
> On Thu, Mar 29, 2018 at 05:53:14PM +0100, Marc Zyngier wrote:
> > On Thu, 29 Mar 2018 16:58:27 +0100,
> > Russell King - ARM Linux wrote:

[...]

> > > I'm not aware of there being an emulated UART in the guest's address
> > > space, so serial based stuff doesn't work.
> > 
> > "earlycon=uart,mmio,0x3f8" is what you're looking for:
> 
> Does that also mean that we have a RTC at the standard PC IO addresses
> as well, but in mmio space?

There is one, together with an i8042. Not exposed in the DT though.

	M.

-- 
Jazz is not dead, it just smell funny.
