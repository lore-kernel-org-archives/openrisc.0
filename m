From: Stafford Horne <shorne@gmail.com>
Date: Sat,  3 Nov 2018 07:00:02 +0900
Subject: [OpenRISC] [PATCH] newlib/configure.host: Set have_init_fini to no
	for OpenRISC
Message-ID: <20181102220002.29760-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The new GCC port for OpenRISC will use the init_fini_array only and not
provide the init() and fini() functions.  Disable the function usage by
default as its no longer needed.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 newlib/configure.host | 1 +
 1 file changed, 1 insertion(+)

diff --git a/newlib/configure.host b/newlib/configure.host
index 27bce36a1..6c49cb750 100644
--- a/newlib/configure.host
+++ b/newlib/configure.host
@@ -279,6 +279,7 @@ case "${host_cpu}" in
 	;;
   or1k*|or1knd*)
 	machine_dir=or1k
+	have_init_fini=no
 	;;
   powerpc*)
 	machine_dir=powerpc
-- 
2.17.2

