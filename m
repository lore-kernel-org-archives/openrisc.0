From: Stafford Horne <shorne@gmail.com>
Date: Thu, 24 Nov 2016 07:10:39 +0900
Subject: [OpenRISC] [PATCH 13/18] gdb: Add OpenRISC to texinfo menu
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <1479939044-1341-14-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Wallentowitz <stefan@wallentowitz.de>

Fixes an error during make install

gdb/ChangeLog:

	* gdb/doc/gdb.texinfo: add openrisc to suppress an error
---
 gdb/doc/gdb.texinfo | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdb/doc/gdb.texinfo b/gdb/doc/gdb.texinfo
index 50f27b3..296534b 100644
--- a/gdb/doc/gdb.texinfo
+++ b/gdb/doc/gdb.texinfo
@@ -22026,6 +22026,7 @@ acceptable commands.
 * M68K::                        Motorola M68K
 * MicroBlaze::			Xilinx MicroBlaze
 * MIPS Embedded::               MIPS Embedded
+* OpenRISC 1000::               OpenRISC 1000 (or1k)
 * PowerPC Embedded::            PowerPC Embedded
 * AVR::                         Atmel AVR
 * CRIS::                        CRIS
-- 
2.7.4


