From: Marc Zyngier <marc.zyngier@arm.com>
Date: Thu, 4 Jan 2018 09:57:42 +0000
Subject: [OpenRISC] [PATCH -next] irqchip/ompic: fix return value check
 in ompic_of_init()
In-Reply-To: <6AADFAC011213A4C87B956458587ADB40131FAB5@dggemi507-mbx.china.huawei.com>
References: <1514893639-70586-1-git-send-email-weiyongjun1@huawei.com>
 <20180103144129.GJ32243@lianli.shorne-pla.net>
 <6AADFAC011213A4C87B956458587ADB40131FAB5@dggemi507-mbx.china.huawei.com>
Message-ID: <68282353-1c44-3d0f-32ec-23934fc19686@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 04/01/18 03:56, weiyongjun (A) wrote:
> On Wed, Jan 03, 2018 10:41 PM, Stafford Horne wrote:
>> On Tue, Jan 02, 2018 at 11:47:19AM +0000, Wei Yongjun wrote:
>>> In case of error, the function ioremap() returns NULL pointer not
>>> ERR_PTR(). The IS_ERR() test in the return value check should be
>>> replaced with NULL test.
>>
>> Thanks, I am not sure why I was using the *ERR*() macros.  2 questions:
>>
>>  - How did you notice this?
> 
> This is detected by Coccinelle semantic patch. 
> 
>>  - Should I pull this in through my tree or do you have another route? i.e.
>>    Marc?
> 
> Feel free to pull this through your tree.

That's for me to say... I'll take it.


Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
