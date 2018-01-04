From: weiyongjun (A) <weiyongjun1@huawei.com>
Date: Thu, 4 Jan 2018 03:56:41 +0000
Subject: [OpenRISC] [PATCH -next] irqchip/ompic: fix return value check
 in ompic_of_init()
In-Reply-To: <20180103144129.GJ32243@lianli.shorne-pla.net>
References: <1514893639-70586-1-git-send-email-weiyongjun1@huawei.com>
 <20180103144129.GJ32243@lianli.shorne-pla.net>
Message-ID: <6AADFAC011213A4C87B956458587ADB40131FAB5@dggemi507-mbx.china.huawei.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jan 03, 2018 10:41 PM, Stafford Horne wrote:
> On Tue, Jan 02, 2018 at 11:47:19AM +0000, Wei Yongjun wrote:
> > In case of error, the function ioremap() returns NULL pointer not
> > ERR_PTR(). The IS_ERR() test in the return value check should be
> > replaced with NULL test.
> 
> Thanks, I am not sure why I was using the *ERR*() macros.  2 questions:
> 
>  - How did you notice this?

This is detected by Coccinelle semantic patch. 

>  - Should I pull this in through my tree or do you have another route? i.e.
>    Marc?

Feel free to pull this through your tree.


