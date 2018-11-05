From: Rich Felker <dalias@libc.org>
Date: Mon, 5 Nov 2018 10:10:22 -0500
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <74dd7edd-ea59-9fd6-6c9b-82ac34574897@arm.com>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <29809b24-23e5-9981-df88-6550f7f91b4c@arm.com>
 <20181104090544.GB16938@lianli.shorne-pla.net>
 <74dd7edd-ea59-9fd6-6c9b-82ac34574897@arm.com>
Message-ID: <20181105151022.GO5150@brightrain.aerifal.cx>
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

For practical purposes, if you want to use static pie, you need a
default-pie toolchain. This is because _every_ static lib you might
link needs to be built with -fPIE (or -fPIC), and ensuring that
happens on a package-by-package basis is largely impractical; at least
it's on the same order of magnitude of difficulty as other systems
integration/packaging tasks.

However from the musl side it might make sense to produce a libc_pic.a
as part of the build process. This would make it easy to replace
libc.a with libc_pic.a if desired, and could also be used as the basis
for linking libc.so and to allow production of a stripped-down libc.so
that only includes symbols a fixed set of binaries depend on. We could
discuss something like this on the musl list.

Rich
