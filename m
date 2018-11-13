From: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 14 Nov 2018 00:10:43 +0100
Subject: [OpenRISC] [PATCH 05/17] mips: Remove support for BZIP2 and
 LZMA compressed kernel
In-Reply-To: <20181113224545.pamrezqxy2ay62k7@pburton-laptop>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
 <20181109190304.8573-5-kilobyte@angband.pl>
 <20181113224545.pamrezqxy2ay62k7@pburton-laptop>
Message-ID: <20181113231043.cv3qpjivxsefxpny@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Tue, Nov 13, 2018 at 10:45:54PM +0000, Paul Burton wrote:
> On Fri, Nov 09, 2018 at 08:02:52PM +0100, Adam Borowski wrote:
> > @@ -122,7 +104,6 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
> >  
> >  targets += vmlinux.its
> >  targets += vmlinux.gz.its
> > -targets += vmlinux.bz2.its
> >  targets += vmlinux.lzmo.its
> >  targets += vmlinux.lzo.its
> 
> It looks to me like this "vmlinux.lzmo.its" was a typo & ought to have
> been vmlinux.lzma.its, and thus ought to be removed.

Good catch!

The whole series was bz2 only at first, grepping for lzma missed this.

> Apart from that I'm fine with this in general:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>

Thanks.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢰⠒⠀⣿⡁ “This is gonna be as easy as cheating on an ethics exam!”
⢿⡄⠘⠷⠚⠋⠀     -Cerise Brightmoon
⠈⠳⣄⠀⠀⠀⠀
