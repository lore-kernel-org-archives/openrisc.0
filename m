From: Stafford Horne <shorne@gmail.com>
Date: Mon, 31 Jan 2022 22:38:13 +0900
Subject: [OpenRISC] [PATCH] gcc: define _REENTRANT for OpenRISC when
 -pthread is passed
Message-ID: <20220131133813.1142801-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Bernd Kuhls <bernd.kuhls@t-online.de>

The detection of pthread support fails on OpenRISC unless _REENTRANT
is defined. Added the CPP_SPEC definition to correct this.

gcc/ChangeLog:

	PR target/94372
	* config/or1k/linux.h (CPP_SPEC): Define.

Signed-off-by: Bernd Kuhls <bernd.kuhls@t-online.de>
---
This was brought up on the buildroot list and somehow I missed it.  Sending it
now.  I plan to commit soon.

 gcc/config/or1k/linux.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gcc/config/or1k/linux.h b/gcc/config/or1k/linux.h
index 52909af41a6..80f77c72232 100644
--- a/gcc/config/or1k/linux.h
+++ b/gcc/config/or1k/linux.h
@@ -32,6 +32,8 @@
 #undef MUSL_DYNAMIC_LINKER
 #define MUSL_DYNAMIC_LINKER  "/lib/ld-musl-or1k.so.1"
 
+#define CPP_SPEC "%{pthread:-D_REENTRANT}"
+
 #undef LINK_SPEC
 #define LINK_SPEC "%{h*}			\
    %{static:-Bstatic}				\
-- 
2.31.1

