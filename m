Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E88C19F2C
	for <openrisc@archiver.kernel.org>; Sun, 31 Jul 2022 22:07:39 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 685BF211B0;
	Mon,  1 Aug 2022 00:07:38 +0200 (CEST)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 by mail.librecores.org (Postfix) with ESMTPS id 54EAE248F8
 for <openrisc@lists.librecores.org>; Mon, 25 Jul 2022 22:48:50 +0200 (CEST)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net
 ([86.15.83.122] helo=[192.168.0.17])
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1oG508-006V3d-JH; Mon, 25 Jul 2022 21:48:29 +0100
Message-ID: <a5b079bb-64ab-092d-27d4-d32d0d35afcb@codethink.co.uk>
Date: Mon, 25 Jul 2022 21:48:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] profile: setup_profiling_timer() is moslty not implemented
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>
References: <20220721195509.418205-1-ben-linux@fluff.org>
 <20220725123948.f16674b10022404814161d4a@linux-foundation.org>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20220725123948.f16674b10022404814161d4a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 01 Aug 2022 00:07:35 +0200
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
Cc: linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 25/07/2022 20:39, Andrew Morton wrote:
> On Thu, 21 Jul 2022 20:55:09 +0100 Ben Dooks <ben-linux@fluff.org> wrote:
> 
>> The setup_profiling_timer() is mostly un-implemented by many
>> architectures. In many places it isn't guarded by CONFIG_PROFILE
>> which is needed for it to be used. Make it a weak symbol in
>> kernel/profile.c and remove the 'return -EINVAL' implementations
>> from the kenrel.
>>
>> There are a couple of architectures which do return 0 from
>> the setup_profiling_timer() function but they don't seem to
>> do anything else with it. To keep the /proc compatibility for
>> now, leave these for a future update or removal.
>>
>> On ARM, this fixes the following sparse warning:
>> arch/arm/kernel/smp.c:793:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?
> 
> I'll grab this.
> 
> We have had some problems with weak functions lately.  See
> 
> https://lore.kernel.org/all/87ee0q7b92.fsf@email.froward.int.ebiederm.org/T/#u
> 
> Hopefully that was a rare corner case.

Great, thanks.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
