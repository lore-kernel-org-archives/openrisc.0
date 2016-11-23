From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:26 +0900
Subject: [OpenRISC] [PATCH 00/18] gdb: Port for OpenRISC
Message-ID: <1479939044-1341-1-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This is the openrisc port of GDB that has been in openrisc
repositories for a very long time. The main original author
was Jeremy Bennett as can be seen in file copyrights. Other
are willing to do what it takes for FSF copyright assignment.

This along with the sim patches are the last of what has not
made its way upstream. The patches are based on current gdb
git master branch.

I have run the testsuite and results are as follows:

=== gdb Summary ===

# of expected passes            19209
# of unexpected failures        411
# of expected failures          28
# of known failures             57
# of unresolved testcases       34
# of untested testcases         190
# of unsupported tests          264
/home/shorne/work/openrisc/build-gdb/gdb/gdb version 7.12.50.20161122-git

Thanks,
-Stafford

Franck Jullien (8):
  gdb: add or1k and or1knd target support
  gdb: or1k: Add a check for NULL ptr in or1k_skip_prologue
  gdb: or1k: Add or1k_push_dummy_code and use it.
  gdb: add tdesc_find_register functions
  gdb: handle arbitrary strings in tdesc_register_in_reggroup_p
  gdb: or1k: set gdbarch num regs to gpr + spr regs
  gdb: or1k: add target descriptor support
  gdb: or1k: change or1k_push_dummy_code stack alignment

Stafford Horne (5):
  gdb: testsuite: Add or1k l.nop inscruction
  gdb: or1k: Update calling conventions to help pass tests
  gdb: Remove corelow object from or1k linux build
  gdb: or1k: Updates for compiler type checking
  gdb: or1k: Refactor to new bp_kind_from_pc and pb_from_kind

Stefan Kristiansson (2):
  gdb: or1k: Silence gcc warning
  gdb: or1k: Fixes for things that broke after upstream merge

Stefan Wallentowitz (3):
  Add gdb for or1k build
  gdb: or1k: Apply changes of the last two years
  gdb: Add OpenRISC to texinfo menu


