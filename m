From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 30 Nov 2020 15:36:47 -0000
Subject: [OpenRISC] [PATCH 0/6] Add documentation for Documentation/features
 at the built docs
Message-ID: <cover.1606748711.git.mchehab+huawei@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Jon,

This series got already submitted last year:

   https://lore.kernel.org/lkml/cover.1561222784.git.mchehab+samsung at kernel.org/

Yet, on that time, there were too many other patches related to ReST
conversion floating around. So, at the end, I guess this one got missed.

So, I did a rebase on the top of upstream, and added a few new changes.

Patch 1 contains the original implementation back then. It adds a
get_feat.pl script that parses the contents of Documentation/features.

Patch 2 is new: it re-implements the output of the full contents of the
features table as a set of per-subsystem tables. 

Patch 3 replaces the existing Documentation/features/list-arch.sh
by a call to the new script, in order to avoid having two scripts
doing the same thing.

Patch 4 is a sphinx extension to allow generating features output
via a meta-tag.

Patch 5 adds a complete feature list covering all archs at the
admin guide.

Patch 6 adds a per-arch feature list on each architecture book.

-

The scripts/get_feat.pl supports several types of output:

- $ scripts/get_feat.pl current

  Outputs the supported feadures by the architecture of the
  running Kernel, as an ASCII table;

- $  scripts/get_feat.pl list

  Outputs the supported features on an easy to be parsed
  format. By default, it uses the current architecture as well;

- $  scripts/get_feat.pl rest --feature jump-labels

  Output what architecture supports a given feature
  (on the above example, "jump-labels" feature)

- $ scripts/get_feat.pl rest --arch um

  Outputs the features support for an specific architecture
  (on the above example, for "um" architecture.

- $ scripts/get_feat.pl rest

  Outputs a text file with ASCII tables (ReST compatible)
  with all features, grouped per subsystem.

  E. g. something like:
	
        ===================================
        Feature status on all architectures
        ===================================
        
        Subsystem: core
        ===============
        
        +---------------------+---------------------------------+-------------------------------------------------------------------------+------------+------+
        |Feature              |Kconfig                          |Description                                                              |Architecture|Status|
        +=====================+=================================+=========================================================================+============+======+
        |cBPF-JIT             |HAVE_CBPF_JIT                    |arch supports cBPF JIT optimizations                                     |alpha       |TODO  |
        |                     |                                 |                                                                         +------------+------+
        |                     |                                 |                                                                         |arc         |TODO  |
        |                     |                                 |                                                                         +------------+------+
        |                     |                                 |                                                                         |arm         |TODO  |
        |                     |                                 |                                                                         +------------+------+
        |                     |                                 |                                                                         |arm64       |TODO  |
        |                     |                                 |                                                                         +------------+------+
        |                     |                                 |                                                                         |c6x         |TODO  |
        |                     |                                 |                                                                         +------------+------+
        |                     |                                 |                                                                         |csky        |TODO  |
        |                     |                                 |                                                                         +------------+------+
        |                     |                                 |                                                                         |h8300       |TODO  |
        |                     |                                 |                                                                         +------------+------+
        |                     |                                 |                                                                         |hexagon     |TODO  |
...

Adding those patchsets will basically place the contents of all
files under Documentation/features (currently, 45 files) at the
Kernel documentation, which is, IMO, a good thing to do.

Regards,
Mauro

Mauro Carvalho Chehab (6):
  scripts: get_feat.pl: add a script to handle Documentation/features
  scripts: get_feat.pl: improve matrix output
  scripts: get_feat.pl: use its implementation for list-arch.sh
  sphinx: kernel_feat.py: add a script to parse feature files
  docs: admin-guide: add a features list
  docs: archis: add a per-architecture features list

 Documentation/admin-guide/features.rst |   3 +
 Documentation/admin-guide/index.rst    |   1 +
 Documentation/arm/features.rst         |   3 +
 Documentation/arm/index.rst            |   2 +
 Documentation/arm64/features.rst       |   3 +
 Documentation/arm64/index.rst          |   2 +
 Documentation/conf.py                  |   2 +-
 Documentation/features/list-arch.sh    |  17 +-
 Documentation/ia64/features.rst        |   3 +
 Documentation/ia64/index.rst           |   2 +
 Documentation/index.rst                |   2 +-
 Documentation/m68k/features.rst        |   3 +
 Documentation/m68k/index.rst           |   2 +
 Documentation/mips/features.rst        |   3 +
 Documentation/mips/index.rst           |   2 +
 Documentation/nios2/index.rst          |  12 +
 Documentation/openrisc/features.rst    |   3 +
 Documentation/openrisc/index.rst       |   2 +
 Documentation/parisc/features.rst      |   3 +
 Documentation/parisc/index.rst         |   2 +
 Documentation/powerpc/features.rst     |   3 +
 Documentation/powerpc/index.rst        |   2 +
 Documentation/riscv/features.rst       |   3 +
 Documentation/riscv/index.rst          |   2 +
 Documentation/s390/features.rst        |   3 +
 Documentation/s390/index.rst           |   2 +
 Documentation/sh/features.rst          |   3 +
 Documentation/sh/index.rst             |   2 +
 Documentation/sparc/features.rst       |   3 +
 Documentation/sparc/index.rst          |   2 +
 Documentation/sphinx/kernel_feat.py    | 169 ++++++++
 Documentation/x86/features.rst         |   3 +
 Documentation/x86/index.rst            |   1 +
 Documentation/xtensa/features.rst      |   3 +
 Documentation/xtensa/index.rst         |   2 +
 scripts/get_feat.pl                    | 552 +++++++++++++++++++++++++
 36 files changed, 810 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/admin-guide/features.rst
 create mode 100644 Documentation/arm/features.rst
 create mode 100644 Documentation/arm64/features.rst
 create mode 100644 Documentation/ia64/features.rst
 create mode 100644 Documentation/m68k/features.rst
 create mode 100644 Documentation/mips/features.rst
 create mode 100644 Documentation/nios2/index.rst
 create mode 100644 Documentation/openrisc/features.rst
 create mode 100644 Documentation/parisc/features.rst
 create mode 100644 Documentation/powerpc/features.rst
 create mode 100644 Documentation/riscv/features.rst
 create mode 100644 Documentation/s390/features.rst
 create mode 100644 Documentation/sh/features.rst
 create mode 100644 Documentation/sparc/features.rst
 create mode 100644 Documentation/sphinx/kernel_feat.py
 create mode 100644 Documentation/x86/features.rst
 create mode 100644 Documentation/xtensa/features.rst
 create mode 100755 scripts/get_feat.pl

-- 
2.28.0


