From: Alexander A. Klimov <grandmaster@al2klimov.de>
Date: Fri, 10 Jul 2020 08:20:19 +0200
Subject: [OpenRISC] [PATCH] OPENRISC ARCHITECTURE: Replace HTTP links with
 HTTPS ones
Message-ID: <20200710062019.28755-1-grandmaster@al2klimov.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 Documentation/openrisc/openrisc_port.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
index 4b2c437942a0..657ac4af7be6 100644
--- a/Documentation/openrisc/openrisc_port.rst
+++ b/Documentation/openrisc/openrisc_port.rst
@@ -8,7 +8,7 @@ target architecture, specifically, is the 32-bit OpenRISC 1000 family (or1k).
 For information about OpenRISC processors and ongoing development:
 
 	=======		=============================
-	website		http://openrisc.io
+	website		https://openrisc.io
 	email		openrisc at lists.librecores.org
 	=======		=============================
 
-- 
2.27.0

