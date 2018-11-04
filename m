From: Stafford Horne <shorne@gmail.com>
Date: Sun, 4 Nov 2018 18:05:44 +0900
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <29809b24-23e5-9981-df88-6550f7f91b4c@arm.com>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <29809b24-23e5-9981-df88-6550f7f91b4c@arm.com>
Message-ID: <20181104090544.GB16938@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Oct 29, 2018 at 02:28:11PM +0000, Szabolcs Nagy wrote:
> On 27/10/18 05:37, Stafford Horne wrote:
> > +++ b/gcc/config/or1k/linux.h
> > @@ -0,0 +1,44 @@
> > +/* Linux Definitions for OpenRISC.
> > +   Copyright (C) 2018 Free Software Foundation, Inc.
> > +   Contributed by Stafford Horne.
> > +
> > +   This file is part of GCC.
> > +
> > +   GCC is free software; you can redistribute it and/or modify it
> > +   under the terms of the GNU General Public License as published
> > +   by the Free Software Foundation; either version 3, or (at your
> > +   option) any later version.
> > +
> > +   GCC is distributed in the hope that it will be useful, but WITHOUT
> > +   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> > +   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > +   License for more details.
> > +
> > +   You should have received a copy of the GNU General Public License
> > +   along with GCC; see the file COPYING3.  If not see
> > +   <http://www.gnu.org/licenses/>.  */
> > +
> > +#ifndef GCC_OR1K_LINUX_H
> > +#define GCC_OR1K_LINUX_H
> > +
> > +/* elfos.h should have already been included.  Now just override
> > +   any conflicting definitions and add any extras.  */
> > +
> > +#define TARGET_OS_CPP_BUILTINS() \
> > +  GNU_USER_TARGET_OS_CPP_BUILTINS ()
> > +
> > +#define GLIBC_DYNAMIC_LINKER "/lib/ld-linux-or1k.so.1"
> > +
> > +#undef MUSL_DYNAMIC_LINKER
> > +#define MUSL_DYNAMIC_LINKER  "/lib/ld-musl-or1k.so.1"
> > +
> > +#undef LINK_SPEC
> > +#define LINK_SPEC "%{h*}			\
> > +   %{static:-Bstatic}				\
> > +   %{shared:-shared}				\
> > +   %{symbolic:-Bsymbolic}			\
> > +   %{!static:					\
> > +     %{rdynamic:-export-dynamic}		\
> > +     %{!shared:-dynamic-linker " GNU_USER_DYNAMIC_LINKER "}}"
> > +
> > +#endif /* GCC_OR1K_LINUX_H */
> 
> note that because of the -static-pie mess each
> target needs a more complicated LINK_SPEC now.

Hello,

Does something like this look better?

--- a/gcc/config/or1k/linux.h
+++ b/gcc/config/or1k/linux.h
@@ -37,8 +37,9 @@
    %{static:-Bstatic}                          \
    %{shared:-shared}                           \
    %{symbolic:-Bsymbolic}                      \
-   %{!static:                                  \
+   %{!static:%{!static-pie:                    \
      %{rdynamic:-export-dynamic}               \
-     %{!shared:-dynamic-linker " GNU_USER_DYNAMIC_LINKER "}}"
+     %{!shared:-dynamic-linker " GNU_USER_DYNAMIC_LINKER "}}} \
+   %{static-pie:-Bstatic -pie --no-dynamic-linker -z text}"
 
 #endif /* GCC_OR1K_LINUX_H */

I have tested this out with or1k-linux-musl, but I get some LD complaints i.e.

.../or1k-linux-musl/bin/ld: .../or1k-linux-musl/lib/libc.a(exit.o): non-pic relocation against symbol __fini_array_end
.../or1k-linux-musl/bin/ld: .../or1k-linux-musl/lib/libc.a(exit.o): non-pic relocation against symbol __fini_array_start

Those are some warnings we recently added to LD, perhaps I need to rebuild the
libc.a with PIE as well.  I will try it out, but if anyone has some suggestions
that would be helpful.

> i think there could be a generic LINK_SPEC in
> config/linux.h or config/gnu-user.h that works
> for simple targets (the start file spec is
> already there) so this complex logic is not
> repeated everywhere.
> 
> or even do the -no-dynamic-linker logic in
> LINK_PIE_SPEC in gcc.c for all targets, not
> just linux, so backends don't need to do
> anything to get static-pie to work.

I see, yeah, it seems this could be made generic.  I would defer myself working
on making this generic until after or1k port is in.  Sorry, I dont have much
time to make sure it doesnt break everything/anything.  Also, To tell you the
truth I haven't heard of anyone ever running OpenRISC with pie, it has always
been something on my todo list though.  I have had some inqueries into helping
bootstrap some linux nommu machines.

-Stafford
