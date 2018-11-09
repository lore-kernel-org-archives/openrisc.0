From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:03:04 +0100
Subject: [OpenRISC] [PATCH 17/17] [NOT FOR MERGING] lib: Be noisy about used
	decompression method.
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
Message-ID: <20181109190304.8573-17-kilobyte@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

It's too easy to build the initrd with wrong options during testing, after
which it may silently work anyway.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 lib/decompress.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index 95f39a14eb7b..345679312a45 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -69,7 +69,9 @@ decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
 			break;
 
 	}
-	if (name)
+	if (name) {
 		*name = cf->name;
+		printk("Decompressing using %s.\n", *name);
+	}
 	return cf->decompressor;
 }
-- 
2.19.1

