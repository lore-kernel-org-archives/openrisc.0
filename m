Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A0C433FE
	for <openrisc@archiver.kernel.org>; Fri,  7 Oct 2022 11:30:08 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0804024B13;
	Fri,  7 Oct 2022 13:30:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mail.librecores.org (Postfix) with ESMTP id 36AAF24AAE
 for <openrisc@lists.librecores.org>; Fri,  7 Oct 2022 13:30:05 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 746711063;
 Fri,  7 Oct 2022 04:30:10 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 695033F792;
 Fri,  7 Oct 2022 04:30:00 -0700 (PDT)
Date: Fri, 7 Oct 2022 12:29:49 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] RISC-V: Add STACKLEAK erasing the kernel stack at the
 end of syscalls
Message-ID: <Y0ANrYa2IQCg8UTd@FVFF77S0Q05N>
References: <6c48657c-04df-132d-6167-49ed293dea44@microchip.com>
 <mhng-8c3bb2e7-e84e-4aaa-bce8-3e8054255a2c@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-8c3bb2e7-e84e-4aaa-bce8-3e8054255a2c@palmer-ri-x1c9>
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
Cc: linux-efi@vger.kernel.org, heiko@sntech.de, oleg@redhat.com,
 Conor.Dooley@microchip.com, guoren@kernel.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, ardb@kernel.org, linux-arch@vger.kernel.org,
 xianting.tian@linux.alibaba.com, linux@armlinux.org.uk, vgupta@kernel.org,
 linux-snps-arc@lists.infradead.org, aou@eecs.berkeley.edu,
 Arnd Bergmann <arnd@arndb.de>, openrisc@lists.librecores.org,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, linux-kernel@vger.kernel.org, dinguyen@kernel.org,
 daolu@rivosinc.com, davem@davemloft.net
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Oct 06, 2022 at 07:31:01PM -0700, Palmer Dabbelt wrote:
> On Tue, 06 Sep 2022 10:35:10 PDT (-0700), Conor.Dooley@microchip.com wrote:
> > On 03/09/2022 17:23, guoren@kernel.org wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > 
> > > From: Xianting Tian <xianting.tian@linux.alibaba.com>
> > > 
> > > This adds support for the STACKLEAK gcc plugin to RISC-V and disables
> > > the plugin in EFI stub code, which is out of scope for the protection.
> > > 
> > > For the benefits of STACKLEAK feature, please check the commit
> > > afaef01c0015 ("x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls")
> > > 
> > > Performance impact (tested on qemu env with 1 riscv64 hart, 1GB mem)
> > >     hackbench -s 512 -l 200 -g 15 -f 25 -P
> > >     2.0% slowdown
> > > 
> > > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > 
> > What changed since Xianting posted it himself a week ago:
> > https://lore.kernel.org/linux-riscv/20220828135407.3897717-1-xianting.tian@linux.alibaba.com/
> > 
> > There's an older patch from Du Lao adding STACKLEAK too:
> > https://lore.kernel.org/linux-riscv/20220615213834.3116135-1-daolu@rivosinc.com/
> > 
> > But since there's been no activity there since June...
> 
> Looks like the only issues were some commit log wording stuff, and that
> there's a test suite that should be run.  It's not clear from the commits
> that anyone has done that, I'm fine with the patch if it passes the tests
> but don't really know how to run them.

Enable CONFIG_LKDTM, and do:

  echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT

Example GOOD/BAD output below, taken from:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/misc/lkdtm/stackleak.c?id=72b61896f2b47fa4b98e86184bc0e6ddbd1a8db1

GOOD result on x86_64:

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: stackleak stack usage:
|   high offset: 168 bytes
|   current:     336 bytes
|   lowest:      656 bytes
|   tracked:     656 bytes
|   untracked:   400 bytes
|   poisoned:    15152 bytes
|   low offset:  8 bytes
| lkdtm: OK: the rest of the thread stack is properly erased

GOOD result on arm64:

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: stackleak stack usage:
|   high offset: 336 bytes
|   current:     656 bytes
|   lowest:      1232 bytes
|   tracked:     1232 bytes
|   untracked:   672 bytes
|   poisoned:    14136 bytes
|   low offset:  8 bytes
| lkdtm: OK: the rest of the thread stack is properly erased

BAD result on arm64:

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: FAIL: non-poison value 24 bytes below poison boundary: 0x0
| lkdtm: FAIL: non-poison value 32 bytes below poison boundary: 0xffff8000083dbc00
...
| lkdtm: FAIL: non-poison value 1912 bytes below poison boundary: 0x78b4b9999e8cb15
| lkdtm: FAIL: non-poison value 1920 bytes below poison boundary: 0xffff8000083db400
| lkdtm: stackleak stack usage:
|   high offset: 336 bytes
|   current:     688 bytes
|   lowest:      1232 bytes
|   tracked:     576 bytes
|   untracked:   288 bytes
|   poisoned:    15176 bytes
|   low offset:  8 bytes
| lkdtm: FAIL: the thread stack is NOT properly erased!
| lkdtm: Unexpected! This kernel (5.18.0-rc1-00013-g1f7b1f1e29e0-dirty aarch64) was built with CONFIG_GCC_PLUGIN_STACKLEAK=y

Mark.
