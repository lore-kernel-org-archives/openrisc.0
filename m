From: Stafford Horne <shorne@gmail.com>
Date: Mon, 19 Sep 2016 15:06:23 +0900 (JST)
Subject: [OpenRISC] openrisc: Consolidate setup to use memblock instead
	of bootmem
In-Reply-To: <20160918152255.GA29400@roeck-us.net>
References: <1459937321-22393-1-git-send-email-shorne@gmail.com>
 <20160918152255.GA29400@roeck-us.net>
Message-ID: <alpine.LFD.2.20.1609191505590.2354@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On Sun, 18 Sep 2016, Guenter Roeck wrote:

> On Wed, Apr 06, 2016 at 07:08:41PM +0900, Stafford Horne wrote:
>> Clearing out one todo item. This simplifies the boot process by using
>> the memblock api throughout the init process.
>>
>> The old logic bootstrapped from memblock -> bootmem -> buddy allocator
>> This is now simplified by using NO_BOOTMEM.
>>
>> Signed-off-by: Stafford Horne <shorne@gmail.com>
>
> FWIW:
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thank you,

-Stafford

