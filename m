From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Wed, 14 Apr 2021 17:38:32 +0800
Subject: [OpenRISC] [PATCH] init: consolidate trap_init()
In-Reply-To: <20210414172757.3ebfaa4c@xhacker.debian>
References: <20210414165808.458a3d11@xhacker.debian>
 <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
 <20210414172757.3ebfaa4c@xhacker.debian>
Message-ID: <20210414173832.52bc3ddb@xhacker.debian>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Wed, 14 Apr 2021 17:27:57 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Wed, 14 Apr 2021 11:10:42 +0200
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
> >
> > Le 14/04/2021 à 10:58, Jisheng Zhang a écrit :  
> > > Many architectures implement the trap_init() as NOP, since there is
> > > no such default for trap_init(), this empty stub is duplicated among
> > > these architectures. Provide a generic but weak NOP implementation
> > > to drop the empty stubs of trap_init() in these architectures.  
> >
> > You define the weak function in the __init section.
> >
> > Most but not all architectures had it in __init section.
> >
> > And the remaining ones may not be defined in __init section. For instance look at the one in alpha
> > architecture.
> >
> > Have you checked that it is not a problem ? It would be good to say something about it in the commit
> > description.  
> 
> For those non-nop platforms, I can only test x86/arm64/, but both has
> __init mark. I'm not sure whether this is a problem for alpha etc. Maybe
> I can check which section the trap_init() sits. Or to avoid any possible
> regression, I can add __init mark to those remaining ones without it in
> preparation patches.
> 

Hi,

I found only three platforms don't have the __init marker for trap_init(), I
will add the __init marker in three preparation patches in new version.

thanks
