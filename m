From: Yao Qi <qiyaoltc@gmail.com>
Date: Fri, 09 Jun 2017 11:10:37 +0100
Subject: [OpenRISC] [PATCH v7 1/4] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <0d86778997b5aebf1301f883ef30833823a7dbd7.1496068645.git.shorne@gmail.com>
 (Stafford Horne's message of "Mon, 29 May 2017 23:48:23 +0900")
References: <cover.1496068645.git.shorne@gmail.com>
 <cover.1496068645.git.shorne@gmail.com>
 <0d86778997b5aebf1301f883ef30833823a7dbd7.1496068645.git.shorne@gmail.com>
Message-ID: <864lvp5v4y.fsf@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:

> diff --git a/gdb/features/or1k.xml b/gdb/features/or1k.xml
> new file mode 100644
> index 0000000..c138a02
> --- /dev/null
> +++ b/gdb/features/or1k.xml
> @@ -0,0 +1,12 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2016 Free Software Foundation, Inc.

2017.

> +
> +  set_gdbarch_print_insn (gdbarch, print_insn_or1k);
> +

Don't need to set gdbarch_print_insn, so remove this line.  GDB will use
the default one, which selects the right disassembler in opcodes.

Otherwise, patch is good to me.

-- 
Yao (齐尧)
