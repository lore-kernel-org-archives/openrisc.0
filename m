From: Stafford Horne <shorne@gmail.com>
Date: Sat, 18 Dec 2021 00:03:09 +0900
Subject: [OpenRISC] [PATCH v3 06/13] or1k: Atomics and Locking primitives
In-Reply-To: <3facf07d-85b9-7ccc-eee5-78be8dc69f45@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-7-shorne@gmail.com>
 <39803fe3-ab39-524a-c678-1b74d092c436@linaro.org>
 <3facf07d-85b9-7ccc-eee5-78be8dc69f45@linaro.org>
Message-ID: <YbymrS8yMR6OQ36d@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Dec 16, 2021 at 04:43:52PM -0300, Adhemerval Zanella wrote:
> 
> 
> On 16/12/2021 09:52, Adhemerval Zanella wrote:
> > LGTM, thanks.
> > 
> > On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> >> ---
> >>  sysdeps/or1k/atomic-machine.h | 79 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 79 insertions(+)
> >>  create mode 100644 sysdeps/or1k/atomic-machine.h
> >>
> >> diff --git a/sysdeps/or1k/atomic-machine.h b/sysdeps/or1k/atomic-machine.h
> >> new file mode 100644
> >> index 0000000000..1e306ae4ef
> >> --- /dev/null
> >> +++ b/sysdeps/or1k/atomic-machine.h
> >> @@ -0,0 +1,79 @@
> >> +/* Atomic operations.  OpenRISC version.
> >> +   Copyright (C) 2021 Free Software Foundation, Inc.
> >> +   This file is part of the GNU C Library.
> >> +
> >> +   The GNU C Library is free software; you can redistribute it and/or
> >> +   modify it under the terms of the GNU Lesser General Public
> >> +   License as published by the Free Software Foundation; either
> >> +   version 2.1 of the License, or (at your option) any later version.
> >> +
> >> +   The GNU C Library is distributed in the hope that it will be useful,
> >> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >> +   Lesser General Public License for more details.
> >> +
> >> +   You should have received a copy of the GNU Lesser General Public
> >> +   License along with the GNU C Library.  If not, see
> >> +   <https://www.gnu.org/licenses/>.  */
> >> +
> >> +#ifndef __OR1K_ATOMIC_H_
> >> +#define __OR1K_ATOMIC_H_
> >> +
> >> +#include <stdint.h>
> >> +
> >> +typedef int32_t atomic32_t;
> >> +typedef uint32_t uatomic32_t;
> >> +
> >> +typedef intptr_t atomicptr_t;
> >> +typedef uintptr_t uatomicptr_t;
> >> +typedef intmax_t atomic_max_t;
> >> +typedef uintmax_t uatomic_max_t;
> > 
> > Sigh, these definition are used solely in only file, memusage.c.  Another thing
> > I will cleanup.
> 
> I just send a patchset that aims to simplify this boilerplate [1].  It should
> also simplify other parts of OpenRISC submission.
> 
> [1] https://sourceware.org/pipermail/libc-alpha/2021-December/134285.html

Thanks, I have seen it.
