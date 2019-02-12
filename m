From: BAndViG <bandvig@mail.ru>
Date: Tue, 12 Feb 2019 21:42:34 +0300
Subject: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
In-Reply-To: <20190201230623.GZ3235@lianli.shorne-pla.net>
References: <CAAfxs76ysqzXWnJH02eDe0vSCLvuqwdwwKNiQoQV7Kfst4_mNw@mail.gmail.com>
 <CAF6YiZ5RrwcEj-Kqk4-MvrqZFK8WWUgU1MVjzmu2M3=90qbPdQ@mail.gmail.com>
 <20190201230623.GZ3235@lianli.shorne-pla.net>
Message-ID: <A59731DF0E4944CB92FE9319B31812B2@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Thanks for good words, Stafford.

Before speaking about performance I should make two notes.

First, I had to to add additional stages in IFETCH and LSU and remove 
forwarding multiplexors at execution units inputs to achieve 100 MHz CPU clock 
on Spartan-6 LX45 (Atlys board). Additionally, pseudo clock domain crossing 
synchronizations were added between CPU and Wishbone clock domains. As a 
result, MAROCCHINO demonstrates higher "Iterations/Sec" with higher CPU clocks 
and lower "Iterations/1-million-clocks" ((Iterations/Sec)/CPU_clock_MHz).

Second. Initially, I implemented GPRs as set of four RAM-blocks to provide 
{rX,rX+1} access to 64-bit operands for ORFPX64A32 extension. However, to meet 
GCC9 ABI ({rX,rX+2} access for 64-bit operands) I had to replace RAM-blocks by 
set of Flip-Flop based register. MAROCCHINO had become much larger and only 75 
MHz CPU clock could be achieved now. The included 100 MHz Coremark results were 
measured on previous MAROCCHINO version (with RAM-based GPRs). Of course, 
particular GPRs implementation itself doesn't affect Coremark digits.

The Coremark results (CAPPUCCINO and MAROCCINO both configured with pipelined 
multiplier, serial divider, l.cmov, l.sra, l.ror and l.ffl1 enabled; toolchain 
is GCC-5.4.0 based, NewLIB compiled with support of all enabled hardware 
feature) are:

Iterations       : 2000

Compiler flags 
  : -O2 -funroll-loops -fgcse-sm -mboard=atlys -flto -DPERFORMANCE_RUN=1 -flto

                    Iterations/Sec    Iterations/1M-clocks
CAPPUCCINO  50MHz:     123.915737              2.47
MAROCCHINO  50MHz:      81.833061              1.63
MAROCCHINO  75MHz:     122.174706              1.62
MAROCCHINO 100MHz:     160.000000              1.60


Compiler flags   : -O2 -mboard=atlys -flto -DVALIDATION_RUN=1 -flto

                    Iterations/Sec    Iterations/1M-clocks
CAPPUCCINO  50MHz:     109.051254              2.18
MAROCCHINO  50MHz:      72.254333              1.44
MAROCCHINO  75MHz:     107.991356              1.43
MAROCCHINO 100MHz:     142.247513              1.42

Andrey


From: Stafford Horne
Sent: Saturday, February 02, 2019 2:06 AM
To: Julius Baxter
Cc: Philipp Wagner ; Openrisc ; BAndViG ; Stefan Wallentowitz
Subject: Re: [OpenRISC] [RFC] Splitting out Marocchino to new Repo

Hi julius

On Fri, Feb 01, 2019 at 11:51:26AM +0100, Julius Baxter wrote:
> On Sun, 27 Jan 2019 at 11:11, Stafford Horne <shorne@gmail.com> wrote:
...
> > ## Marocchino Pipeline ##
> >
> > Which brings us to Marocchino.  Andrey has been working on the
> > Marocchino implementation for a while.  This is a fork of the mor1kx
> > cappuccino pipeline that adds many advanced features like: out of
> > order instruction execution, simplify by reducing parameter options,
> > separate Wishbone and CPU clocks and 64-bit FPU operations via the
> > ORFPX64A32 (https://openrisc.io/proposals/orfpx64a32) specification.
> > In the end this has turned into a very different internal
> > architecture.
> >
> > Currently the work is all stored in the marocchino_devel branch of mor1kx.
> >
>
> This sounds great! Does CoreMark run on it yet? How much of a speedup have
> you achieved so far?

I have not run it yet as I am still trying to get the basic tests to pass. 
Once
that is working ill move onto the bigger tests like coremark and testfloat.

Andrey might have some results.

> >
> > ## Proposal to Split Marocchino to new Repo ##
> >
> > As we discussed in a recent PR
> > (https://github.com/openrisc/mor1kx/pull/72) marocchino doesn't really
> > share any code with the rest of mor1kx and even now has a separate top
> > level module (mor1kx_top_marocchino).
> >
> > Andrey and I have proposed moving the code to a new repo
> > openrisc/mor1kx_marocchino.  Though it's not really exactly a mor1kx
> > pipeline swap any longer the name might be controversial.
> >
> > Does anyone have a objection / suggestion for this?
> >
>
> I don't mind. If it's not intended to share any of the components with the
> other pipelines then by all means do what's best for the development of
> that core.
>
> Looking forward to seeing where this goes!

Me too, this OOO core code quality and design is very nice and it will be good
to give it the proper exposure it deserves.

-Stafford
_______________________________________________
OpenRISC mailing list
OpenRISC at lists.librecores.org
https://lists.librecores.org/listinfo/openrisc

WBR
Andrey 

