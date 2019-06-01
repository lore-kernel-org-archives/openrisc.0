From: Stafford Horne <shorne@gmail.com>
Date: Sat,  1 Jun 2019 16:26:27 +0900
Subject: [OpenRISC] [PATCH 0/2] CGEN unordered fpu compares + fixes
Message-ID: <20190601072629.4070-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

As I am working on openrisc which uses cgen in binutils I have needed to make
these changes.

The Unordered compares is needed for FPU unordered (NaN detecting) comparisons.
These have been implemented and tested in OpenRISC (both simulation and
assembler (running on FPGA hardware)).

The gen-doc changes come from me noticing the docs [0] on the cgen website are
very much out of date.

Does anyone know the process to get the regenerated docs posted?  I think they
are beneficial and with some more updates they could be really good.

[0] https://sourceware.org/cgen/gen-doc/

Stafford Horne (2):
  cgen: Add unordered compare operation
  gen-doc: Updates for latest cpu definitions

 gen-all-doc   | 46 ++++++++++++++++++++++++++++++++--------------
 html.scm      |  2 +-
 rtl-c.scm     |  4 ++++
 rtx-funcs.scm |  7 +++++++
 4 files changed, 44 insertions(+), 15 deletions(-)
 mode change 100644 => 100755 gen-all-doc

-- 
2.21.0

