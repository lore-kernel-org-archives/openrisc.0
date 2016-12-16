From: Stafford Horne <shorne@gmail.com>
Date: Sat, 17 Dec 2016 01:02:50 +0900
Subject: [OpenRISC] [PATCH 0/5] Openrisc gdb patches after yao's comments
Message-ID: <cover.1481903617.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All, 

I wanted to circulate these patches on the openrisc list first. These are in 
response to Yao's gdb patch review.

 - The first patch is baiscally format and comment updates as per gnu style. 
 - The second removes the unimplemented pseudo register functions
 - Next is the BIG one it removes the handling of target-description parsing
   and intercepting.  But this is as per the recommended way. May what is 
   questionable is how I hard code the reggroups.
 - Next removes the special spr commands.  I think or1ksim would need to be
   updated to work with the target-descriptor xml.
 - Last is just a cleanup.

The plan would be to squash all of these into the previous patch set I sent. 

Test results look ok.  Also I tested against openocd and I can reed sprs with
commands like `info reg upr` as expected.

                === gdb Summary ===

# of expected passes            19241
# of unexpected failures        406
# of expected failures          29
# of known failures             57
# of unresolved testcases       2
# of untested testcases         190
# of unsupported tests          264
/home/shorne/work/openrisc/build-gdb/gdb/gdb version  7.12.50.20161122-git 

-Stafford

Stafford Horne (5):
  gdb: or1k: Updates suggested by yao in gdb review
  gdb: or1k: Remove pseudo registers
  or1k: gdb: Simplify handling of tdesc
  or1k: gdb: Remove spr commands
  gdb: or1k: Just have one number of registers

 gdb/configure.tgt         |   14 -
 gdb/or1k-tdep.c           | 2931 +++++++++------------------------------------
 gdb/or1k-tdep.h           |  389 +-----
 gdb/target-descriptions.c |   34 -
 gdb/target-descriptions.h |   12 -
 5 files changed, 549 insertions(+), 2831 deletions(-)

-- 
2.7.4


