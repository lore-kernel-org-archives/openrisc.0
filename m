From: Yao Qi <qiyaoltc@gmail.com>
Date: Mon, 12 Jun 2017 10:45:15 +0100
Subject: [OpenRISC] [PATCH v7 1/4] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <20170610081138.GD8558@lianli.shorne-pla.net> (Stafford Horne's
 message of "Sat, 10 Jun 2017 17:11:38 +0900")
References: <cover.1496068645.git.shorne@gmail.com>
 <cover.1496068645.git.shorne@gmail.com>
 <0d86778997b5aebf1301f883ef30833823a7dbd7.1496068645.git.shorne@gmail.com>
 <864lvp5v4y.fsf@gmail.com>
 <20170609130839.GC8558@lianli.shorne-pla.net>
 <20170610081138.GD8558@lianli.shorne-pla.net>
Message-ID: <86lgoxa6ac.fsf@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:

> I tried to look into this, but it looks liek we do need
> set_gdbarch_print_insn ().   If not starting gdb hits this error in
> gdbarch.c verify_gdbarch().
>
> ...
>   if (gdbarch->print_insn == 0)
>     log.puts ("\n\tprint_insn");

These lines were removed by my commit
39503f82427e22ed8e04d986ccdc8562091ec62e (Delegate opcodes to select
disassembler in GDB) on May 24th.

-  if (gdbarch->print_insn == 0)
-    log.puts ("\n\tprint_insn");
+  /* Skip verify of print_insn, invalid_p == 0 */

> ...
>
>   if (!log.empty ())
>     internal_error (__FILE__, __LINE__,
> 		    _("verify_gdbarch: the following are invalid ...%s"),
> 		    log.c_str ());
> ...
>
> Is the automatic selecting of `print_insn` something new?  My patch is
> based on yesterdays master branch of http://sourceware.org/git/binutils-gdb.git.

Looks your gdbarch.c is out of date.

-- 
Yao (齐尧)
