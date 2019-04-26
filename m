From: Stafford Horne <shorne@gmail.com>
Date: Sat, 27 Apr 2019 07:22:42 +0900
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <20190425211702.GG32284@lianli.shorne-pla.net>
References: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
 <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
 <20190412214843.GB32284@lianli.shorne-pla.net>
 <05413d8c-395c-de51-95f6-cdaa85c834dd@twiddle.net>
 <20190413084708.GC32284@lianli.shorne-pla.net>
 <3D70BAC7A5B64C0E977D84EC118F146E@BAndViG>
 <20190425211702.GG32284@lianli.shorne-pla.net>
Message-ID: <20190426222242.GH32284@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Apr 26, 2019 at 06:17:02AM +0900, Stafford Horne wrote:
> Hello,
> 
> On Sun, Apr 14, 2019 at 12:41:56PM +0300, BAndViG wrote:
> > Hi, Stafford, Richard
> > 
> > > > > I propose:
> > > > >
> > > > >   bit-10 - 1 indicates if rd2 is +2
> > > > >   bit-9  - 1 indicates if ra2 is +2
> > > > >   bit-8  - 1 indicates if rb2 is +2
> > > >
> > > > Thanks.  LGTM.
> 
> Sorry, it took time, I had visitors at home last week, and I needed to relearn
> how cgen worked.
> 
> This is implemented in binutils now. See my patches here:
> 
>   - https://github.com/stffrdhrn/binutils-gdb/commits/orfpx64a32-3
> 
> I have not squashed the commits because it makes it a bit easier for reviewing
> what I did to get these flags working.

I have the GCC patches up as well now.

 - https://github.com/stffrdhrn/gcc/commits/or1k-fpu-2

Initial tests look fine.

-Stafford
