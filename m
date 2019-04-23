From: Stafford Horne <shorne@gmail.com>
Date: Tue, 23 Apr 2019 18:22:56 +0900
Subject: [OpenRISC] cannot boot linux
In-Reply-To: <AM5PR0801MB16336F56C18491748C786E25FE2A0@AM5PR0801MB1633.eurprd08.prod.outlook.com>
References: <AM5PR0801MB16336F56C18491748C786E25FE2A0@AM5PR0801MB1633.eurprd08.prod.outlook.com>
Message-ID: <CAAfxs77PWBihhMSBnYmi8qA_cyROR0s_pvORgMtE3oDcd-bbbQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Basel,

Sorry for delay I was off all last week.

What version of Linux are you using and what does your device tree look
like?  What version of the gcc toolchain are you using?

Also, have you tried the kernel gdb helpers?

Some examples here
https://www.kernel.org/doc/html/v4.10/dev-tools/gdb-kernel-debugging.html

-stafford

On Mon, Apr 15, 2019, 4:28 PM Basel Sayeh <basel.sayeh@hotmail.com> wrote:

> Hello
>
> I tried to boot linux via mor1kx cpu built via fusesoc for a qmtech
> Cyclone IV board
> https://github.com/baselsayeh/qmtech_ep4ce15-multicore
>
> Every time the kernel jumps to or32_early_setup, the cpu throws bus errors
> and jumps to 0x200
>
> Here is gdb output just before the error
> https://pastebin.com/U5izVPG9
>
> How i can investigate this?
> Thanks
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190423/682823f6/attachment.html>
