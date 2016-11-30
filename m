From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 30 Nov 2016 14:05:45 -0800
Subject: [OpenRISC] Add openrisc for-next branch to linux-next
In-Reply-To: <CAKaYPCMpZF6tQwQrtkVMZ1+F=vSUWxAx+skyMeU6FPPA_LGgVg@mail.gmail.com>
References: <alpine.LFD.2.20.1611302214520.29569@lianli.shorne-pla.net>
 <f7f0e124-00b9-5b21-9ca0-1f17e7c338bd@infradead.org>
 <CAKaYPCMpZF6tQwQrtkVMZ1+F=vSUWxAx+skyMeU6FPPA_LGgVg@mail.gmail.com>
Message-ID: <2079b13e-080c-7797-b003-f1d1336dfb58@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 11/30/16 12:11, Olof Kindgren wrote:
> 
>     Hi,
> 
>     I see that you have updated MAINTAINERS.  Good.
> 
>     Does openRISC support VGA console?
>     I tried to send a patch to Jason a few days ago.
>     Please look at http://marc.info/?l=linux-kernel&m=147968525011508&w=2 <http://marc.info/?l=linux-kernel&m=147968525011508&w=2>
>     (or I can resend it if you wish).
> 
>     The kbuild test bot has been reporting this build error for several
>     months.  If my fix is wrong, please submit something else.
> 
>     Thanks.
>     --
>     ~Randy
>     _______________________________________________
>     OpenRISC mailing list
>     OpenRISC at lists.librecores.org <mailto:OpenRISC@lists.librecores.org>
>     https://lists.librecores.org/listinfo/openrisc <https://lists.librecores.org/listinfo/openrisc>
> 
> 
> Hi Randy,
> 
> This is a known issue. This patch (https://github.com/openrisc/linux/pull/5) should take care of it. Can't say if it's the correct solution though, but it works both with and without a VGA console
> 
> //Olof

Thanks.


-- 
~Randy

