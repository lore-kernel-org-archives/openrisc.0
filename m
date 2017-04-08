From: Stafford Horne <shorne@gmail.com>
Date: Sat, 8 Apr 2017 18:38:01 +0900
Subject: [OpenRISC] [PATCH v5 2/4] gdb: provide openrisc target
 description XML files.
In-Reply-To: <86mvbv6f1c.fsf@gmail.com>
References: <cover.1489728533.git.shorne@gmail.com>
 <cover.1489728533.git.shorne@gmail.com>
 <7504d4eb6312e41dd98b643c486152d9f5331e05.1489728533.git.shorne@gmail.com>
 <86mvbv6f1c.fsf@gmail.com>
Message-ID: <20170408093801.GD2194@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Tue, Apr 04, 2017 at 10:25:51PM +0100, Yao Qi wrote:
> Stafford Horne <shorne@gmail.com> writes:
> 
> > diff --git a/gdb/features/or1k.xml b/gdb/features/or1k.xml
> > new file mode 100644
> > index 0000000..688b340
> > --- /dev/null
> > +++ b/gdb/features/or1k.xml
> > @@ -0,0 +1,2274 @@
> > +<?xml version="1.0"?>
> > +<!-- Copyright (C) 2016 Free Software Foundation, Inc.
> > +
> > +     Copying and distribution of this file, with or without modification,
> > +     are permitted in any medium without royalty provided the copyright
> > +     notice and this notice are preserved.  -->
> > +
> > +<!DOCTYPE target SYSTEM "gdb-target.dtd">
> > +<target>
> > +  <architecture>or1k</architecture>
> > +  <feature name="org.gnu.gdb.or1k.group0">
> 
> 11 features are defined, but your patch 1/4 only checks feature group0.
> Does it indicate that only group0 is a required feature?  If so, we need
> to document it here,
> https://sourceware.org/gdb/current/onlinedocs/gdb/Standard-Target-Features.html
> 
> Of course, the debugging stub,like OpenOCD, can provide more features
> than GDB required.  In GDB, we need only to define required features.

I have removed these 11 features and just left the 1.  I think its
better that the targets provide all the extras.

Also, I documented it.  I will send the patches.

> -- 
> Yao (齐尧)
