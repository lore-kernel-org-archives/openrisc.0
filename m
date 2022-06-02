Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB34C43334
	for <openrisc@archiver.kernel.org>; Wed,  8 Jun 2022 23:00:01 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 11263249E2;
	Thu,  9 Jun 2022 01:00:00 +0200 (CEST)
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
 by mail.librecores.org (Postfix) with ESMTPS id 434FC213FD
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 10:54:59 +0200 (CEST)
X-QQ-mid: bizesmtp89t1654160052t1zf8w5m
Received: from localhost.localdomain ( [117.176.187.31])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 02 Jun 2022 16:53:52 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000000A0000000
X-QQ-FEAT: luOaNWLUXql+90tq29tHlaNee6MTAc5jjfOS9XKjMNS+OyiwiwUYqgaGNscJ9
 8tJj84zGyFElEZsdG/8fvCTBcU4NetPRF4vmIw1PNdhFyDYvNKU49/7p1PVjU/yp6IeO7kR
 qNy2bnnnwIBkcB5hXAzb9cWGiy0HU4ZiSfydTM/OArb2LWbQAUMf86QN29iw3JVIkSFCoPG
 A4Jj27zN7MMrQIWB9WobNrxuJrgLvmGW3rH7Vo8sHrqKTzdmVMPssTn+XD/PGEmiuN8Kw5s
 i6F5XN5drdhwQm8yncRYYeYpVNphFNWXr4rR8yt1fhyNXRX/lkrHSSpYJ7UAccuxbCipBsv
 6e2aJJ+YINtwKtZlLI=
X-QQ-GoodBg: 0
From: Xiang wangx <wangxiang@cdjrlc.com>
To: jonas@southpole.se
Subject: [PATCH] openrisc: Fix syntax errors in comments
Date: Thu,  2 Jun 2022 16:53:50 +0800
Message-Id: <20220602085350.12741-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Mailman-Approved-At: Thu, 09 Jun 2022 00:59:57 +0200
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: Xiang wangx <wangxiang@cdjrlc.com>, openrisc@lists.librecores.org,
 linux-kernel@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/openrisc/kernel/unwinder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/unwinder.c b/arch/openrisc/kernel/unwinder.c
index 8ae15c2c1845..c6ad6f867a6a 100644
--- a/arch/openrisc/kernel/unwinder.c
+++ b/arch/openrisc/kernel/unwinder.c
@@ -25,7 +25,7 @@ struct or1k_frameinfo {
 /*
  * Verify a frameinfo structure.  The return address should be a valid text
  * address.  The frame pointer may be null if its the last frame, otherwise
- * the frame pointer should point to a location in the stack after the the
+ * the frame pointer should point to a location in the stack after the
  * top of the next frame up.
  */
 static inline int or1k_frameinfo_valid(struct or1k_frameinfo *frameinfo)
-- 
2.36.1

