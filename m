From: Stafford Horne <shorne@gmail.com>
Date: Mon, 20 Dec 2021 20:53:45 +0900
Subject: [OpenRISC] [PATCH v3 08/13] or1k: Linux Syscall Interface
In-Reply-To: <58c906a6-76b0-e4e1-bc17-5338b10e25f0@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-9-shorne@gmail.com>
 <a4105fcc-1844-b022-f378-3d5474ecaf56@linaro.org>
 <YbymWIYUxR/ndzWb@antec>
 <58c906a6-76b0-e4e1-bc17-5338b10e25f0@linaro.org>
Message-ID: <YcBuya9mU0UM2LrA@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Dec 17, 2021 at 02:41:20PM -0300, Adhemerval Zanella wrote:
> 
> 
> On 17/12/2021 12:01, Stafford Horne wrote:
> > On Thu, Dec 16, 2021 at 06:17:45PM -0300, Adhemerval Zanella wrote:
> >>> diff --git a/sysdeps/unix/sysv/linux/or1k/bits/timesize.h b/sysdeps/unix/sysv/linux/or1k/bits/timesize.h
> >>> new file mode 100644
> >>> index 0000000000..3ab388da7f
> >>> --- /dev/null
> >>> +++ b/sysdeps/unix/sysv/linux/or1k/bits/timesize.h
> >>> @@ -0,0 +1,19 @@
> >>> +/* Bit size of the time_t type at glibc build time, OpenRISC version.
> >>> +   Copyright (C) 2021 Free Software Foundation, Inc.
> >>> +   This file is part of the GNU C Library.
> >>> +
> >>> +   The GNU C Library is free software; you can redistribute it and/or
> >>> +   modify it under the terms of the GNU Lesser General Public
> >>> +   License as published by the Free Software Foundation; either
> >>> +   version 2.1 of the License, or (at your option) any later version.
> >>> +
> >>> +   The GNU C Library is distributed in the hope that it will be useful,
> >>> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >>> +   Lesser General Public License for more details.
> >>> +
> >>> +   You should have received a copy of the GNU Lesser General Public
> >>> +   License along with the GNU C Library; if not, see
> >>> +   <https://www.gnu.org/licenses/>.  */
> >>> +
> >>> +#define __TIMESIZE	64
> >>
> >> Ok, although I think we should flip the default to 64 bits make
> >> old ports to override to 32.
> > 
> > It makes sense.  It might be a bit tricky as currently __TIMESIZE default is
> > __WORDSIZE.  I see a few old ports which have __WORDSIZE 32 and 64 like sparc.
> 
> I will fix this upstream, it is just a matter to override to 32 for older ports.
> 
> >>
> >> Ok, I take that implementing it solely on __or1k_clone is more complex than
> >> using a C wrapper.
> > 
> > I am not to clear what you mean here, I take you are asking why we keep
> > __or1k_clone in assembly rather than implement __or1k_clone in C too.
> > 
> > There are some stack setup bits in __or1k_clone which require assembly.
> > 
> 
> I meant otherwise in fact, why not implement clone for or1k purely in assembly.

I see, it could be done but I think it's easier to maintain with the va_arg
parsing and generic set_errno handling being in C.

-Staffford
