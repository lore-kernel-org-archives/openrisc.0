From: Stafford Horne <shorne@gmail.com>
Date: Thu, 1 Dec 2016 07:02:26 +0900 (JST)
Subject: [OpenRISC] Add openrisc for-next branch to linux-next
In-Reply-To: <f7f0e124-00b9-5b21-9ca0-1f17e7c338bd@infradead.org>
References: <alpine.LFD.2.20.1611302214520.29569@lianli.shorne-pla.net>
 <f7f0e124-00b9-5b21-9ca0-1f17e7c338bd@infradead.org>
Message-ID: <alpine.LFD.2.20.1612010658350.29569@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On Wed, 30 Nov 2016, Randy Dunlap wrote:

> On 11/30/16 05:22, Stafford Horne wrote:
>> Hi Stephen,
>>
>> I have been working on getting the OpenRISC backlog of fixes sorted out for upstream.  Can this branch be added to linux-next?
>>
>>   git://github.com/openrisc/linux.git for-next
>>
>> These have been through a few reviews and we plan to ask Linus to pull in the next merge window.
>>
>> -Stafford
>
> Hi,
>
> I see that you have updated MAINTAINERS.  Good.
>
> Does openRISC support VGA console?
> I tried to send a patch to Jason a few days ago.
> Please look at http://marc.info/?l=linux-kernel&m=147968525011508&w=2
> (or I can resend it if you wish).
>
> The kbuild test bot has been reporting this build error for several
> months.  If my fix is wrong, please submit something else.

Hi Randy,

I was watching that thread, I honestly thought it would have been pulled 
in by one of the console maintainers.

Openrisc does not have support for vga console, some people may have 
hacked something together, but its not in our kernel yet.  So I have no 
issue disabling it in the build.

I will pull it in to my branch.

If someone else pulls,
Acked-by: Stafford Horne <shorne@gmail.com>

-Stafford

