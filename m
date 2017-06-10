From: Stafford Horne <shorne@gmail.com>
Date: Sat, 10 Jun 2017 17:11:38 +0900
Subject: [OpenRISC] [PATCH v7 1/4] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <20170609130839.GC8558@lianli.shorne-pla.net>
References: <cover.1496068645.git.shorne@gmail.com>
 <cover.1496068645.git.shorne@gmail.com>
 <0d86778997b5aebf1301f883ef30833823a7dbd7.1496068645.git.shorne@gmail.com>
 <864lvp5v4y.fsf@gmail.com>
 <20170609130839.GC8558@lianli.shorne-pla.net>
Message-ID: <20170610081138.GD8558@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jun 09, 2017 at 10:08:39PM +0900, Stafford Horne wrote:
> On Fri, Jun 09, 2017 at 11:10:37AM +0100, Yao Qi wrote:
> > Stafford Horne <shorne@gmail.com> writes:
> > 
> > > +  set_gdbarch_print_insn (gdbarch, print_insn_or1k);
> > > +
> > 
> > Don't need to set gdbarch_print_insn, so remove this line.  GDB will use
> > the default one, which selects the right disassembler in opcodes.
> 
> I removed it, but all tests start failing after that.  I will look into it
> a bit more.

I tried to look into this, but it looks liek we do need
set_gdbarch_print_insn ().   If not starting gdb hits this error in
gdbarch.c verify_gdbarch().

...
  if (gdbarch->print_insn == 0)
    log.puts ("\n\tprint_insn");
...

  if (!log.empty ())
    internal_error (__FILE__, __LINE__,
		    _("verify_gdbarch: the following are invalid ...%s"),
		    log.c_str ());
...

Is the automatic selecting of `print_insn` something new?  My patch is
based on yesterdays master branch of http://sourceware.org/git/binutils-gdb.git.

-Stafford
