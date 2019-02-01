From: Stafford Horne <shorne@gmail.com>
Date: Sat, 2 Feb 2019 08:06:23 +0900
Subject: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
In-Reply-To: <CAF6YiZ5RrwcEj-Kqk4-MvrqZFK8WWUgU1MVjzmu2M3=90qbPdQ@mail.gmail.com>
References: <CAAfxs76ysqzXWnJH02eDe0vSCLvuqwdwwKNiQoQV7Kfst4_mNw@mail.gmail.com>
 <CAF6YiZ5RrwcEj-Kqk4-MvrqZFK8WWUgU1MVjzmu2M3=90qbPdQ@mail.gmail.com>
Message-ID: <20190201230623.GZ3235@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

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

I have not run it yet as I am still trying to get the basic tests to pass.  Once
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
