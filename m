From: Stafford Horne <shorne@gmail.com>
Date: Fri, 9 Jun 2017 22:08:39 +0900
Subject: [OpenRISC] [PATCH v7 1/4] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <864lvp5v4y.fsf@gmail.com>
References: <cover.1496068645.git.shorne@gmail.com>
 <cover.1496068645.git.shorne@gmail.com>
 <0d86778997b5aebf1301f883ef30833823a7dbd7.1496068645.git.shorne@gmail.com>
 <864lvp5v4y.fsf@gmail.com>
Message-ID: <20170609130839.GC8558@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Fri, Jun 09, 2017 at 11:10:37AM +0100, Yao Qi wrote:
> Stafford Horne <shorne@gmail.com> writes:
> 
> > diff --git a/gdb/features/or1k.xml b/gdb/features/or1k.xml
> > new file mode 100644
> > index 0000000..c138a02
> > --- /dev/null
> > +++ b/gdb/features/or1k.xml
> > @@ -0,0 +1,12 @@
> > +<?xml version="1.0"?>
> > +<!-- Copyright (C) 2016 Free Software Foundation, Inc.
> 
> 2017.

Ah, right, will fix.

> > +
> > +  set_gdbarch_print_insn (gdbarch, print_insn_or1k);
> > +
> 
> Don't need to set gdbarch_print_insn, so remove this line.  GDB will use
> the default one, which selects the right disassembler in opcodes.

I removed it, but all tests start failing after that.  I will look into it
a bit more.

> Otherwise, patch is good to me.
> 
> -- 
> Yao (齐尧)
