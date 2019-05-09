From: Stafford Horne <shorne@gmail.com>
Date: Fri, 10 May 2019 05:29:34 +0900
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <6CFC558D2E0643BAA8C0CFCB1AEE95BB@BAndViG>
References: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
 <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
 <20190412214843.GB32284@lianli.shorne-pla.net>
 <05413d8c-395c-de51-95f6-cdaa85c834dd@twiddle.net>
 <20190413084708.GC32284@lianli.shorne-pla.net>
 <3D70BAC7A5B64C0E977D84EC118F146E@BAndViG>
 <20190425211702.GG32284@lianli.shorne-pla.net>
 <e441bb74-5cea-6002-c33e-4822f082265b@twiddle.net>
 <20190507211254.GD11006@lianli.shorne-pla.net>
 <6CFC558D2E0643BAA8C0CFCB1AEE95BB@BAndViG>
Message-ID: <20190509202934.GF11006@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, May 08, 2019 at 09:05:58PM +0300, BAndViG wrote:
> > From: Stafford Horne
> > Sent: Wednesday, May 08, 2019 12:12 AM
> > To: Richard Henderson
> > Cc: BAndViG ; Openrisc
> > Subject: Re: [OpenRISC] OpenRISC 1.3 spec
> 
> > On Tue, May 07, 2019 at 08:28:45AM -0700, Richard Henderson wrote:
> > > On 4/25/19 2:17 PM, Stafford Horne wrote:
> > > > This is implemented in binutils now. See my patches here:
> > > >
> > > >   - https://github.com/stffrdhrn/binutils-gdb/commits/orfpx64a32-3
> > > >
> > > > I have not squashed the commits because it makes it a bit easier for
> > > > reviewing
> > > > what I did to get these flags working.
> > >
> > > I've implemented this for qemu,
> > >
> > >   https://github.com/rth7680/qemu/commits/tgt-or1k
> > >
> > > although untested so far.  I need to regenerate my
> > > cross-testing environment for or1k...
> 
> > This looks good, I like how you do (rD1 + rD1Offset + 1) instead of what
> > I was
> > doing (rD1 + (rD1Offset ? 2 : 1 )).  I will fix my matches to use your
> > method.
> 
> Ah, I implemented similar approach in MAROCCHINO independently :), see
> latest commit to fp_unordered_cmp branch:
> https://github.com/openrisc/or1k_marocchino/commit/313b256875c8b619f5b16db47d915e5dfaedfff7

Nice.

> > Also, just a reminder, the latest patches for GCC FPU support are up here.  I
> > have rebased to the 9.1.0 release.  Also, added a new REG CLASS for REG
> > PAIRS to
> > fix an issue for when (rD1 + rD1Offset + 1) overflows.
> 
> >   https://github.com/stffrdhrn/gcc/commits/or1k-fpu-2
> 
> Btw, earlier you wrote "... on one end 64-bit openrisc doesn't looks to even
> be coming ...". Actually I think it wouldn't be a very difficult for me to
> create 64-bit OpeRISC by some re-factoring of MAROCCHINO's modules. At the
> same time is anybody interested in it?
> 
> Additionally, is anybody interested in little endian support? I've been
> thinking to implement it as a parameter, like OPTION_ENDIAN =
> "BIG"/"LITTLE". With the approach SR[LEE]:
>  - should be set at compile time in according with OPTION_ENDIAN value
>  - couldn't be changed by writing into SR

I think its possible, it requires work to be done on binutils, simulators and
gcc.  There has been a start to this work before but I didn't continue as per
simplicity.

BTW,

I have finished the first version of implementing unordered comparisons in
binutils.  Please have a look here:

  https://github.com/stffrdhrn/binutils-gdb/commits/orfpx64a32-3a

-Stafford
