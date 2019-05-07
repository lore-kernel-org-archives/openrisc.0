From: Stafford Horne <shorne@gmail.com>
Date: Wed, 8 May 2019 06:12:54 +0900
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <e441bb74-5cea-6002-c33e-4822f082265b@twiddle.net>
References: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
 <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
 <20190412214843.GB32284@lianli.shorne-pla.net>
 <05413d8c-395c-de51-95f6-cdaa85c834dd@twiddle.net>
 <20190413084708.GC32284@lianli.shorne-pla.net>
 <3D70BAC7A5B64C0E977D84EC118F146E@BAndViG>
 <20190425211702.GG32284@lianli.shorne-pla.net>
 <e441bb74-5cea-6002-c33e-4822f082265b@twiddle.net>
Message-ID: <20190507211254.GD11006@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 07, 2019 at 08:28:45AM -0700, Richard Henderson wrote:
> On 4/25/19 2:17 PM, Stafford Horne wrote:
> > This is implemented in binutils now. See my patches here:
> > 
> >   - https://github.com/stffrdhrn/binutils-gdb/commits/orfpx64a32-3
> > 
> > I have not squashed the commits because it makes it a bit easier for reviewing
> > what I did to get these flags working.
> 
> I've implemented this for qemu,
> 
>   https://github.com/rth7680/qemu/commits/tgt-or1k
> 
> although untested so far.  I need to regenerate my
> cross-testing environment for or1k...

This looks good, I like how you do (rD1 + rD1Offset + 1) instead of what I was
doing (rD1 + (rD1Offset ? 2 : 1 )).  I will fix my matches to use your method.

Also, just a reminder, the latest patches for GCC FPU support are up here.  I
have rebased to the 9.1.0 release.  Also, added a new REG CLASS for REG PAIRS to
fix an issue for when (rD1 + rD1Offset + 1) overflows.

  https://github.com/stffrdhrn/gcc/commits/or1k-fpu-2

-Stafford
