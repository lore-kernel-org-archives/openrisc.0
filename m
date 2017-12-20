From: Stafford Horne <shorne@gmail.com>
Date: Wed, 20 Dec 2017 19:40:10 +0900
Subject: [OpenRISC] [PATCH v3 1/4] reggroups: Add test and docs for
 `info reg $reggroup` feature
In-Reply-To: <837etiptz2.fsf@gnu.org>
References: <20171219142257.13402-1-shorne@gmail.com>
 <20171219142257.13402-2-shorne@gmail.com> <837etiptz2.fsf@gnu.org>
Message-ID: <20171220104010.GC32243@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Dec 19, 2017 at 06:23:29PM +0200, Eli Zaretskii wrote:
> > From: Stafford Horne <shorne@gmail.com>
> > Cc: Openrisc <openrisc@lists.librecores.org>,	Stafford Horne <shorne@gmail.com>
> > Date: Tue, 19 Dec 2017 23:22:54 +0900
> > 
> > Until now this feature has existed but was not documented.  Adding docs
> > and tests.
> 
> Thanks!
> 
> > + at item info registers @var{reggroup} @dots{}
> > +Print the name and value of the registers in each of the specified
> > + at var{reggroup}.  The @var{reggoup} can be any of those returned by
> 
> Please use "@var{reggroup}s", with the trailing "s", otherwise this is
> not correct English.

OK.

> > + at code{maint print reggroups}.

OK.

> Please add here a cross-reference to the node where "maint print
> reggroups" is described.
> 
> >    c = add_info ("registers", info_registers_command, _("\
> >  List of integer registers and their contents, for selected stack frame.\n\
> > -Register name as argument means describe only that register."));
> > +Register name as argument means describe only that register.\n\
> > +Register group name as argument means describe the registers in the\n\
> > +named register group."));
> 
> Since this command accepts more than one reggroup, I think the doc
> string should mention that.

OK.

> The documentation parts are okay with these nits fixed.

Thank you.

-Stafford
