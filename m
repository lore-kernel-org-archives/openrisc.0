Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB715CCA47A
	for <openrisc@archiver.kernel.org>; Wed,  8 Jun 2022 23:00:13 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C20F224911;
	Thu,  9 Jun 2022 01:00:12 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mail.librecores.org (Postfix) with ESMTPS id EA637249C4
 for <openrisc@lists.librecores.org>; Wed,  8 Jun 2022 16:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=pxqjaMyXYMAIciLaWxKe0qnmRXZim+cyW3iOuZrk594=; b=npWDxkQdpsP/KSbB8UVk7cSTfR
 iAvH2EDMYqweSjq8GVWChqEcX/9BIHnt+/9Lh2o73ASUuV3YGe0N1gseF/G3NKGkJrIf+0It9dNyi
 FAvR8qXc2Wg9XRPiJtu0ItkxyceEVaw/05Yp7Ekb/y4g2aezSDA4pvjQ6wKPUVatsqaVeKHbB2bcq
 mZiZTyBSaEWIyApTNtwFIeiNSKagNK4BMp9uLK4X+ZDckF4tkdR4/twee7LOTtORPxdg1htlaoW41
 LiZVginb/4mTy1FluTeIqpvVDv2MTNtlL+Aa4yxsbdvio0znFSvZKUdNiAQUmElpo3cRSF9a3DUwX
 Ck0o5LKQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nywx4-00ChYj-7G; Wed, 08 Jun 2022 14:46:30 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC219302F27;
 Wed,  8 Jun 2022 16:46:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id A74D220C119A3; Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Message-ID: <20220608144517.633293983@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 08 Jun 2022 16:27:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH 27/36] cpuidle,mwait: Make noinstr clean
References: <20220608142723.103523089@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org,
 linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, srivatsa@csail.mit.edu, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org,
 linux-acpi@vger.kernel.org, agross@kernel.org, linux-imx@nxp.com,
 catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com,
 borntraeger@linux.ibm.com, mturquette@baylibre.com, sammy@sammy.net,
 pmladek@suse.com, linux-pm@vger.kernel.org, jiangshanlai@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org,
 acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org,
 dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org,
 paulus@samba.org, mark.rutland@arm.com, linux-ia64@vger.kernel.org,
 dave.hansen@linux.intel.com, virtualization@lists.linux-foundation.org,
 James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, quic_neeraju@quicinc.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, festevam@gmail.com,
 deller@gmx.de, daniel.lezcano@linaro.org, jonathanh@nvidia.com,
 mathieu.desnoyers@efficios.com, frederic@kernel.org, lenb@kernel.org,
 linux-xtensa@linux-xtensa.org, kernel@pengutronix.de, gor@linux.ibm.com,
 linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-arm-kernel@lists.infradead.org,
 chris@zankel.net, sboyd@kernel.org, dinguyen@kernel.org, bristot@redhat.com,
 alexander.shishkin@linux.intel.com, lpieralisi@kernel.org,
 linux@rasmusvillemoes.dk, joel@joelfernandes.org, will@kernel.org,
 boris.ostrovsky@oracle.com, khilman@kernel.org, linux-csky@vger.kernel.org,
 pv-drivers@vmware.com, linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 ulli.kroll@googlemail.com, vgupta@kernel.org, linux-clk@vger.kernel.org,
 josh@joshtriplett.org, rostedt@goodmis.org, rcu@vger.kernel.org, bp@alien8.de,
 bcain@quicinc.com, tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
 sudeep.holla@arm.com, shawnguo@kernel.org, davem@davemloft.net,
 dalias@libc.org, tony@atomide.com, amakhalov@vmware.com,
 bjorn.andersson@linaro.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 anton.ivanov@cambridgegreys.com, jonas@southpole.se, yury.norov@gmail.com,
 richard@nod.at, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 aou@eecs.berkeley.edu, paulmck@kernel.org, hca@linux.ibm.com,
 openrisc@lists.librecores.org, paul.walmsley@sifive.com,
 linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, jgross@suse.com,
 monstr@monstr.eu, linux-mips@vger.kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, ink@jurassic.park.msu.ru, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

vmlinux.o: warning: objtool: intel_idle_s2idle+0x6e: call to __monitor.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_irq+0x8c: call to __monitor.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle+0x73: call to __monitor.constprop.0() leaves .noinstr.text section

vmlinux.o: warning: objtool: mwait_idle+0x88: call to clflush() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/mwait.h         |   12 ++++++------
 arch/x86/include/asm/special_insns.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -25,7 +25,7 @@
 #define TPAUSE_C01_STATE		1
 #define TPAUSE_C02_STATE		0
 
-static inline void __monitor(const void *eax, unsigned long ecx,
+static __always_inline void __monitor(const void *eax, unsigned long ecx,
 			     unsigned long edx)
 {
 	/* "monitor %eax, %ecx, %edx;" */
@@ -33,7 +33,7 @@ static inline void __monitor(const void
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
-static inline void __monitorx(const void *eax, unsigned long ecx,
+static __always_inline void __monitorx(const void *eax, unsigned long ecx,
 			      unsigned long edx)
 {
 	/* "monitorx %eax, %ecx, %edx;" */
@@ -41,7 +41,7 @@ static inline void __monitorx(const void
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
-static inline void __mwait(unsigned long eax, unsigned long ecx)
+static __always_inline void __mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
 
@@ -76,8 +76,8 @@ static inline void __mwait(unsigned long
  * EAX                     (logical) address to monitor
  * ECX                     #GP if not zero
  */
-static inline void __mwaitx(unsigned long eax, unsigned long ebx,
-			    unsigned long ecx)
+static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
+				     unsigned long ecx)
 {
 	/* No MDS buffer clear as this is AMD/HYGON only */
 
@@ -86,7 +86,7 @@ static inline void __mwaitx(unsigned lon
 		     :: "a" (eax), "b" (ebx), "c" (ecx));
 }
 
-static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
+static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -196,7 +196,7 @@ static inline void load_gs_index(unsigne
 
 #endif /* CONFIG_PARAVIRT_XXL */
 
-static inline void clflush(volatile void *__p)
+static __always_inline void clflush(volatile void *__p)
 {
 	asm volatile("clflush %0" : "+m" (*(volatile char __force *)__p));
 }


