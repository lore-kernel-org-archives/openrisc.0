From: Stafford Horne <shorne@gmail.com>
Date: Tue, 6 Nov 2018 05:52:40 +0900
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <74dd7edd-ea59-9fd6-6c9b-82ac34574897@arm.com>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <29809b24-23e5-9981-df88-6550f7f91b4c@arm.com>
 <20181104090544.GB16938@lianli.shorne-pla.net>
 <74dd7edd-ea59-9fd6-6c9b-82ac34574897@arm.com>
Message-ID: <20181105205240.GD16938@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Nov 05, 2018 at 11:13:53AM +0000, Szabolcs Nagy wrote:
> On 04/11/18 09:05, Stafford Horne wrote:
> > On Mon, Oct 29, 2018 at 02:28:11PM +0000, Szabolcs Nagy wrote:
> >> On 27/10/18 05:37, Stafford Horne wrote:
> ...
> >>> +#undef LINK_SPEC
> >>> +#define LINK_SPEC "%{h*}			\
> >>> +   %{static:-Bstatic}				\
> >>> +   %{shared:-shared}				\
> >>> +   %{symbolic:-Bsymbolic}			\
> >>> +   %{!static:					\
> >>> +     %{rdynamic:-export-dynamic}		\
> >>> +     %{!shared:-dynamic-linker " GNU_USER_DYNAMIC_LINKER "}}"
> >>> +
> >>> +#endif /* GCC_OR1K_LINUX_H */
> >>
> >> note that because of the -static-pie mess each
> >> target needs a more complicated LINK_SPEC now.
> > 
> > Hello,
> > 
> > Does something like this look better?
> > 
> > --- a/gcc/config/or1k/linux.h
> > +++ b/gcc/config/or1k/linux.h
> > @@ -37,8 +37,9 @@
> >     %{static:-Bstatic}                          \
> >     %{shared:-shared}                           \
> >     %{symbolic:-Bsymbolic}                      \
> > -   %{!static:                                  \
> > +   %{!static:%{!static-pie:                    \
> >       %{rdynamic:-export-dynamic}               \
> > -     %{!shared:-dynamic-linker " GNU_USER_DYNAMIC_LINKER "}}"
> > +     %{!shared:-dynamic-linker " GNU_USER_DYNAMIC_LINKER "}}} \
> > +   %{static-pie:-Bstatic -pie --no-dynamic-linker -z text}"
> >  
> >  #endif /* GCC_OR1K_LINUX_H */
> 
> looks ok.
> 
> > I have tested this out with or1k-linux-musl, but I get some LD complaints i.e.
> > 
> > .../or1k-linux-musl/bin/ld: .../or1k-linux-musl/lib/libc.a(exit.o): non-pic relocation against symbol __fini_array_end
> > .../or1k-linux-musl/bin/ld: .../or1k-linux-musl/lib/libc.a(exit.o): non-pic relocation against symbol __fini_array_start
> > 
> > Those are some warnings we recently added to LD, perhaps I need to rebuild the
> > libc.a with PIE as well.  I will try it out, but if anyone has some suggestions
> > that would be helpful.
> 
> yes, musl does not build libc.a with pic by default,
> either use a gcc configured with --enable-default-pie
> or CC='gcc -fPIC' when building musl.
> 
> after that -static-pie linking should work.
> 
> (maybe musl should have an --enable-static-pie config
> option to make this simpler)

Thank's for confirming.  I tested this out with your tips and it works.

I use musl-cross-make [0] to build musl, all you really need to do is add
'GCC_CONFIG += --enable-default-pie' to your config.mak file.

-Stafford

[0] https://github.com/richfelker/musl-cross-make
