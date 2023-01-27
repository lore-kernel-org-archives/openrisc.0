Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC855C38142
	for <openrisc@archiver.kernel.org>; Sun, 29 Jan 2023 02:03:49 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 907C421730;
	Sun, 29 Jan 2023 03:03:48 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by mail.librecores.org (Postfix) with ESMTPS id 7C80121730
 for <openrisc@lists.librecores.org>; Sun, 29 Jan 2023 03:03:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=6J6Vi0RCPyxDfoC5MKQ9vw5ZM3fRcONntqTYKAAIxtY=; b=lpKOPLkD7r+0WJeIfwAu6uYgaf
 glKSGhhtDkjjDnoz8W1d8hpTwG6ul+6ExLxYfPP4dBciTCgAFsK4GHjo+HEeCf0w5Afw6HEKu0aMS
 6pTubItwg7yslvYxQErJqnWr0Eau7TBYZKtkOktkh2HkUEl40tuP2EJEw3YMPZ1fI5V1Ok2NjKXth
 i/BMADkxf/DpFt/Yn1OdZFQslssDMx708qn+pQeJoYrgadFENLqQiZWTGT8SBnb/2NBJ1un4MPaMq
 vI14843/aGp4g6vXFqXf7EN5KjdmOsE9OmTHun134uz+Rs9vj+o++j4B7Jj/gFBGg4L5PpslvRLeH
 Vf8KYwQQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pLIPL-00DM0u-2s; Fri, 27 Jan 2023 06:40:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 19/35] Documentation: openrisc: correct spelling
Date: Thu, 26 Jan 2023 22:39:49 -0800
Message-Id: <20230127064005.1558-20-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.29
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
Cc: Jonas Bonn <jonas@southpole.se>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Correct spelling problems for Documentation/openrisc/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/openrisc/openrisc_port.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
--- a/Documentation/openrisc/openrisc_port.rst
+++ b/Documentation/openrisc/openrisc_port.rst
@@ -106,7 +106,7 @@ History
 	a much improved version with changes all around.
 
 10-04-2004	Matjaz Breskvar (phoenix@bsemi.com)
-	alot of bugfixes all over.
+	a lot of bugfixes all over.
 	ethernet support, functional http and telnet servers.
 	running many standard linux apps.
 
@@ -114,7 +114,7 @@ History
 	port to 2.6.x
 
 30-11-2004	Matjaz Breskvar (phoenix@bsemi.com)
-	lots of bugfixes and enhancments.
+	lots of bugfixes and enhancements.
 	added opencores framebuffer driver.
 
 09-10-2010    Jonas Bonn (jonas@southpole.se)
