From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:14:17 +0900
Subject: [OpenRISC] [PATCH 03/18] sim: cgen: allow suffix on generated
	arch.[ch] and cpuall.h
In-Reply-To: <1479939272-1754-1-git-send-email-shorne@gmail.com>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939272-1754-4-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

sim/ChangeLog:

	* Make-common.in: pass $(SUFFIX) to cgen.sh in cgen-arch target
	* cgen.sh: append suffix to names of arch.[ch] and cpuall.h
---
 sim/common/Make-common.in | 2 +-
 sim/common/cgen.sh        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sim/common/Make-common.in b/sim/common/Make-common.in
index 3d99f62..a78255c 100644
--- a/sim/common/Make-common.in
+++ b/sim/common/Make-common.in
@@ -566,7 +566,7 @@ CGEN_FLAGS_TO_PASS = \
 cgen-arch: force
 	$(SHELL) $(srccom)/cgen.sh arch $(srcdir) \
 		$(CGEN) $(CGENDIR) "$(CGENFLAGS)" \
-		$(arch) "$(FLAGS)" ignored "$(isa)" $(mach) ignored \
+		$(arch) "$(FLAGS)" ignored "$(isa)" $(mach) "$(SUFFIX)" \
 		$(archfile) ignored
 
 cgen-cpu: force
diff --git a/sim/common/cgen.sh b/sim/common/cgen.sh
index 394ef2d..c03a4a7 100755
--- a/sim/common/cgen.sh
+++ b/sim/common/cgen.sh
@@ -70,11 +70,11 @@ arch)
 		-B ${tmp}-arch.c1 \
 		-N ${tmp}-all.h1
 	sed $sedscript < ${tmp}-arch.h1 > ${tmp}-arch.h
-	${rootdir}/move-if-change ${tmp}-arch.h ${srcdir}/arch.h
+	${rootdir}/move-if-change ${tmp}-arch.h ${srcdir}/arch${suffix}.h
 	sed $sedscript < ${tmp}-arch.c1 > ${tmp}-arch.c
-	${rootdir}/move-if-change ${tmp}-arch.c ${srcdir}/arch.c
+	${rootdir}/move-if-change ${tmp}-arch.c ${srcdir}/arch${suffix}.c
 	sed $sedscript < ${tmp}-all.h1 > ${tmp}-all.h
-	${rootdir}/move-if-change ${tmp}-all.h ${srcdir}/cpuall.h
+	${rootdir}/move-if-change ${tmp}-all.h ${srcdir}/cpuall${suffix}.h
 
 	rm -f ${tmp}-arch.h1 ${tmp}-arch.c1 ${tmp}-all.h1
 	;;
-- 
2.7.4


