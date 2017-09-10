From: Stafford Horne <shorne@gmail.com>
Date: Sun, 10 Sep 2017 15:49:17 +0900
Subject: [OpenRISC] [PATCH v2 05/14] dt-bindings: add openrisc to vendor
	prefixes list
In-Reply-To: <20170910064926.5874-1-shorne@gmail.com>
References: <20170910064926.5874-1-shorne@gmail.com>
Message-ID: <20170910064926.5874-6-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add OpenRISC.io to vendor prefixes.  This is reserved for softcores
developed by the OpenRISC community.  The OpenRISC community has
separated from OpenCores.org requiring a new prefix.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---

Changes since v1
 - New patch

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index daf465bef758..0025aa7c3745 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -241,6 +241,7 @@ onion	Onion Corporation
 onnn	ON Semiconductor Corp.
 ontat	On Tat Industrial Company
 opencores	OpenCores.org
+openrisc	OpenRISC.io
 option	Option NV
 ORCL	Oracle Corporation
 ortustech	Ortus Technology Co., Ltd.
-- 
2.13.5

