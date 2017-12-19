From: Stafford Horne <shorne@gmail.com>
Date: Tue, 19 Dec 2017 23:22:53 +0900
Subject: [OpenRISC] [PATCH v3 0/4] Support for arbitrary reggroups
Message-ID: <20171219142257.13402-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

(Its been some time since v2, but now that openrisc is upstream I can focus on
this

There were not many concerns raised with v2.  One possible issue with v3 is that
the reggroups struct uses 'char *' for strings.  We now compare std::string vs
'char *' which is a bit clumsy,  but I didnt think it calls for converting
reggroups strings to 'std::string' yet.)

Onto the change:

Traditionally registers have been limited to names like "vector",
"general", "system" which are hard coded in the gdbarch.  This patch allows
additional reggroups to be defined by the xml target description.

This is necessary for architectures like OpenRISC which have many
registers.

This series also adds documentation on tests for the feature of listing
register groups via the "info reg $reggroup" command.

-Stafford

--

Changes since v2
 * Fixed NEWS entry XML/descriptions typo seggested by Petro
 * Rebased on latest upstream/master.

Changes since v1
 * On 'info reg $reggroup' test and docs patch
  - Suggested by Eli - Fix changelog
  - Suggested by Simon
    > Added help text in 'help info registers'
    > Fixed 'register' typos
    > Fixed style of test program
    > Fixed copyright '2017'
    > Fixed code styles in expect
 * On 'arbitrary strings' patch
  - Suggested by Simon
    > Allow for freeing reggroups
  - Suggested by Eli
    > Add documentation for this feature

Stafford Horne (4):
  reggroups: Add test and docs for `info reg $reggroup` feature
  reggroups: Convert reggroups from post_init to pre_init
  reggroups: Create reggroup_gdbarch_new for dynamic reggroups
  tdesc: handle arbitrary strings in tdesc_register_in_reggroup_p

 gdb/NEWS                             |  7 ++++
 gdb/doc/gdb.texinfo                  | 14 +++++--
 gdb/infcmd.c                         |  8 +++-
 gdb/reggroups.c                      | 27 +++++++------
 gdb/reggroups.h                      |  4 ++
 gdb/target-descriptions.c            | 74 ++++++++++++++++++------------------
 gdb/testsuite/gdb.base/reggroups.c   |  5 +++
 gdb/testsuite/gdb.base/reggroups.exp | 63 ++++++++++++++++++++++++++++++
 gdb/testsuite/gdb.xml/extra-regs.xml |  1 +
 gdb/testsuite/gdb.xml/tdesc-regs.exp |  3 ++
 10 files changed, 152 insertions(+), 54 deletions(-)
 create mode 100644 gdb/testsuite/gdb.base/reggroups.c
 create mode 100644 gdb/testsuite/gdb.base/reggroups.exp

-- 
2.13.6

