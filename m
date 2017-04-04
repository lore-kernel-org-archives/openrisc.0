From: Yao Qi <qiyaoltc@gmail.com>
Date: Tue, 04 Apr 2017 22:25:51 +0100
Subject: [OpenRISC] [PATCH v5 2/4] gdb: provide openrisc target
	description XML files.
In-Reply-To: <7504d4eb6312e41dd98b643c486152d9f5331e05.1489728533.git.shorne@gmail.com>
 (Stafford Horne's message of "Fri, 17 Mar 2017 14:43:18 +0900")
References: <cover.1489728533.git.shorne@gmail.com>
 <cover.1489728533.git.shorne@gmail.com>
 <7504d4eb6312e41dd98b643c486152d9f5331e05.1489728533.git.shorne@gmail.com>
Message-ID: <86mvbv6f1c.fsf@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:

> diff --git a/gdb/features/or1k.xml b/gdb/features/or1k.xml
> new file mode 100644
> index 0000000..688b340
> --- /dev/null
> +++ b/gdb/features/or1k.xml
> @@ -0,0 +1,2274 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2016 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE target SYSTEM "gdb-target.dtd">
> +<target>
> +  <architecture>or1k</architecture>
> +  <feature name="org.gnu.gdb.or1k.group0">

11 features are defined, but your patch 1/4 only checks feature group0.
Does it indicate that only group0 is a required feature?  If so, we need
to document it here,
https://sourceware.org/gdb/current/onlinedocs/gdb/Standard-Target-Features.html

Of course, the debugging stub,like OpenOCD, can provide more features
than GDB required.  In GDB, we need only to define required features.

-- 
Yao (齐尧)
