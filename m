From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Date: Mon, 29 Oct 2018 14:28:11 +0000
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181027043702.18414-4-shorne@gmail.com>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
Message-ID: <29809b24-23e5-9981-df88-6550f7f91b4c@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 27/10/18 05:37, Stafford Horne wrote:
> +++ b/gcc/config/or1k/linux.h
> @@ -0,0 +1,44 @@
> +/* Linux Definitions for OpenRISC.
> +   Copyright (C) 2018 Free Software Foundation, Inc.
> +   Contributed by Stafford Horne.
> +
> +   This file is part of GCC.
> +
> +   GCC is free software; you can redistribute it and/or modify it
> +   under the terms of the GNU General Public License as published
> +   by the Free Software Foundation; either version 3, or (at your
> +   option) any later version.
> +
> +   GCC is distributed in the hope that it will be useful, but WITHOUT
> +   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> +   License for more details.
> +
> +   You should have received a copy of the GNU General Public License
> +   along with GCC; see the file COPYING3.  If not see
> +   <http://www.gnu.org/licenses/>.  */
> +
> +#ifndef GCC_OR1K_LINUX_H
> +#define GCC_OR1K_LINUX_H
> +
> +/* elfos.h should have already been included.  Now just override
> +   any conflicting definitions and add any extras.  */
> +
> +#define TARGET_OS_CPP_BUILTINS() \
> +  GNU_USER_TARGET_OS_CPP_BUILTINS ()
> +
> +#define GLIBC_DYNAMIC_LINKER "/lib/ld-linux-or1k.so.1"
> +
> +#undef MUSL_DYNAMIC_LINKER
> +#define MUSL_DYNAMIC_LINKER  "/lib/ld-musl-or1k.so.1"
> +
> +#undef LINK_SPEC
> +#define LINK_SPEC "%{h*}			\
> +   %{static:-Bstatic}				\
> +   %{shared:-shared}				\
> +   %{symbolic:-Bsymbolic}			\
> +   %{!static:					\
> +     %{rdynamic:-export-dynamic}		\
> +     %{!shared:-dynamic-linker " GNU_USER_DYNAMIC_LINKER "}}"
> +
> +#endif /* GCC_OR1K_LINUX_H */

note that because of the -static-pie mess each
target needs a more complicated LINK_SPEC now.

i think there could be a generic LINK_SPEC in
config/linux.h or config/gnu-user.h that works
for simple targets (the start file spec is
already there) so this complex logic is not
repeated everywhere.

or even do the -no-dynamic-linker logic in
LINK_PIE_SPEC in gcc.c for all targets, not
just linux, so backends don't need to do
anything to get static-pie to work.
