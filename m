From: BAndViG <bandvig@mail.ru>
Date: Thu, 2 May 2019 15:22:56 +0300
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <20190426222242.GH32284@lianli.shorne-pla.net>
References: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
 <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
 <20190412214843.GB32284@lianli.shorne-pla.net>
 <05413d8c-395c-de51-95f6-cdaa85c834dd@twiddle.net>
 <20190413084708.GC32284@lianli.shorne-pla.net>
 <3D70BAC7A5B64C0E977D84EC118F146E@BAndViG>
 <20190425211702.GG32284@lianli.shorne-pla.net>
 <20190426222242.GH32284@lianli.shorne-pla.net>
Message-ID: <9933DA48659E43DFAFC830C56C0699A0@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

> > On Sun, Apr 14, 2019 at 12:41:56PM +0300, BAndViG wrote:
> > > Hi, Stafford, Richard
> > >
> > > > > > I propose:
> > > > > >
> > > > > >   bit-10 - 1 indicates if rd2 is +2
> > > > > >   bit-9  - 1 indicates if ra2 is +2
> > > > > >   bit-8  - 1 indicates if rb2 is +2
> > > > >
> > > > > Thanks.  LGTM.
> >
> > Sorry, it took time, I had visitors at home last week, and I needed to 
> > relearn
> > how cgen worked.
> >
> > This is implemented in binutils now. See my patches here:
> >
> >   - https://github.com/stffrdhrn/binutils-gdb/commits/orfpx64a32-3
> >
> > I have not squashed the commits because it makes it a bit easier for 
> > reviewing
> > what I did to get these flags working.
>
> I have the GCC patches up as well now.
>
>  - https://github.com/stffrdhrn/gcc/commits/or1k-fpu-2
>
> Initial tests look fine.
>
> -Stafford

I've updated mor1kx's FPU stuff with various things. In particular 
OPTION_FTOI_ROUNDING was ported from MAROCCHINO (see description in Readme.md). 
I also created "fp_unordered_cmp" branches in both - mor1kx and 
or1k_marocchino - repos. The branches contain initial implementation of 
unordered comparison as I described in another post of the thread. The 
MAROCCHINO's branch also implements offset for a2, b2 and d2 copied from your 
pull request. I hope verilog models are ready for your upcoming GCC9-spec1.3 
port.

WBR
Andrey 

