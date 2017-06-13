From: Stafford Horne <shorne@gmail.com>
Date: Tue, 13 Jun 2017 19:14:31 +0900
Subject: [OpenRISC] [PATCH v7 1/4] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <86lgoxa6ac.fsf@gmail.com>
References: <cover.1496068645.git.shorne@gmail.com>
 <cover.1496068645.git.shorne@gmail.com>
 <0d86778997b5aebf1301f883ef30833823a7dbd7.1496068645.git.shorne@gmail.com>
 <864lvp5v4y.fsf@gmail.com>
 <20170609130839.GC8558@lianli.shorne-pla.net>
 <20170610081138.GD8558@lianli.shorne-pla.net>
 <86lgoxa6ac.fsf@gmail.com>
Message-ID: <20170613101431.GF6190@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jun 12, 2017 at 10:45:15AM +0100, Yao Qi wrote:
> Stafford Horne <shorne@gmail.com> writes:
> 
> > I tried to look into this, but it looks liek we do need
> > set_gdbarch_print_insn ().   If not starting gdb hits this error in
> > gdbarch.c verify_gdbarch().
> >
> > ...
> >   if (gdbarch->print_insn == 0)
> >     log.puts ("\n\tprint_insn");
> 
> These lines were removed by my commit
> 39503f82427e22ed8e04d986ccdc8562091ec62e (Delegate opcodes to select
> disassembler in GDB) on May 24th.
> 
> -  if (gdbarch->print_insn == 0)
> -    log.puts ("\n\tprint_insn");
> +  /* Skip verify of print_insn, invalid_p == 0 */
> 
> > ...
> >
> >   if (!log.empty ())
> >     internal_error (__FILE__, __LINE__,
> > 		    _("verify_gdbarch: the following are invalid ...%s"),
> > 		    log.c_str ());
> > ...
> >
> > Is the automatic selecting of `print_insn` something new?  My patch is
> > based on yesterdays master branch of http://sourceware.org/git/binutils-gdb.git.
> 
> Looks your gdbarch.c is out of date.

Thanks, I see it now.

-Stafford
