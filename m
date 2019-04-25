From: Stafford Horne <shorne@gmail.com>
Date: Fri, 26 Apr 2019 06:17:02 +0900
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <3D70BAC7A5B64C0E977D84EC118F146E@BAndViG>
References: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
 <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
 <20190412214843.GB32284@lianli.shorne-pla.net>
 <05413d8c-395c-de51-95f6-cdaa85c834dd@twiddle.net>
 <20190413084708.GC32284@lianli.shorne-pla.net>
 <3D70BAC7A5B64C0E977D84EC118F146E@BAndViG>
Message-ID: <20190425211702.GG32284@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hello,

On Sun, Apr 14, 2019 at 12:41:56PM +0300, BAndViG wrote:
> Hi, Stafford, Richard
> 
> > > > I propose:
> > > >
> > > >   bit-10 - 1 indicates if rd2 is +2
> > > >   bit-9  - 1 indicates if ra2 is +2
> > > >   bit-8  - 1 indicates if rb2 is +2
> > >
> > > Thanks.  LGTM.

Sorry, it took time, I had visitors at home last week, and I needed to relearn
how cgen worked.

This is implemented in binutils now. See my patches here:

  - https://github.com/stffrdhrn/binutils-gdb/commits/orfpx64a32-3

I have not squashed the commits because it makes it a bit easier for reviewing
what I did to get these flags working.

> > I was thinking, do you think these orfpx64a32 instructions should have
> > different
> > opcodes to distinguish between true 64-bit and 32-bit double instructions?
> > Otherwise we would not really be able to run these orfpx64a32 32-bit
> > binaries on
> > 64-bit CPU's if 64-bit cpus ever get implemented.
> 
> Is it assumed that 64-bit and 32-bit OpenRISC CPUs should be binary compatible?
> If not, I think it is should be normal that:
> - assembler instructions lf.*.d look different
> - 64-bit CPU just ignores bits [10:8]

The only concern I have with '64-bit CPU just ignores bits [10:8]' is when we
have 32-bit code that expects output in a 32-bit pair.  i.e.

  l.ftoi.d  r13,r14, r15,r16
  l.sfne    r14, r0
  ...

In 64-bit it would translate to:

  l.ftoi.d  r13, r15
  l.sfne    r14, r0
  ...

Which would make no sense as r14 would not ever be touched.  This kind of code
would not work on a 64-bit cpu.

> Also, let me remember here that I made initial implementation for unordered
> comparison (for MAROCCHINO pipe currently). The verilog sources are in
> branch
> https://github.com/openrisc/or1k_marocchino/tree/fp_unordered_cmp
> To keep full backward compatibility with current opcodes the proposed
> variant differs from Richard's P11 and looks as following:
> 
> lf.sfueq.s rA,rB (opc: 0x28)
> lf.sfueq.d rA,rB (opc: 0x38)
> lf.sfune.s rA,rB (opc: 0x29)
> lf.sfune.d rA,rB (opc: 0x39)
> lf.sfugt.s rA,rB (opc: 0x2A)
> lf.sfugt.d rA,rB (opc: 0x3A)
> lf.sfuge.s rA,rB (opc: 0x2B)
> lf.sfuge.d rA,rB (opc: 0x3B)
> lf.sfult.s rA,rB (opc: 0x2C)
> lf.sfult.d rA,rB (opc: 0x3C)
> lf.sfule.s rA,rB (opc: 0x2D)
> lf.sfule.d rA,rB (opc: 0x3D)
> lf.sfun.s rA,rB (opc: 0x2E)
> lf.sfun.d rA,rB (opc: 0x3E)
> 
> OPC's bit [5] indicates that comparison is unordered and bit [4] that
> operands are doubles.
> Additionally I’ve added fp_comparisons_table.odt document into doc/readme/
> folder with description of all implemented FP comparison instructions and
> their relation to IEEE standard.
> I haven’t tested them yet as there is no tool now.
> 
> Of course, as Staffor wrote "Its not too late if its before silicon ;)"

Right, let me look to add these to binutils then GCC in a second series of
patches.

> WBR
> Andrey
> 
