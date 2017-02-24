From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:38 +0900
Subject: [OpenRISC] [PATCH v4 18/24] scripts/checkstack.pl: Add openrisc
	support
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <fa5b73d3d8891452306376998a26886512934616.1487910170.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Openrisc stack pointer is managed by decrementing r1. Add regexes to
recognize this.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 scripts/checkstack.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index dd83978..eea5b78 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -106,6 +106,9 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 	} elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
 		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
 		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
+	} elsif ($arch eq 'openrisc') {
+		# c000043c:       9c 21 fe f0     l.addi r1,r1,-272
+		$re = qr/.*l\.addi.*r1,r1,-(([0-9]{2}|[3-9])[0-9]{2})/o;
 	} else {
 		print("wrong or unknown architecture \"$arch\"\n");
 		exit
-- 
2.9.3

