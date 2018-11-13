From: Paul Burton <paul.burton@mips.com>
Date: Tue, 13 Nov 2018 22:45:54 +0000
Subject: [OpenRISC] [PATCH 05/17] mips: Remove support for BZIP2 and
 LZMA compressed kernel
In-Reply-To: <20181109190304.8573-5-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
 <20181109190304.8573-5-kilobyte@angband.pl>
Message-ID: <20181113224545.pamrezqxy2ay62k7@pburton-laptop>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Adam,

On Fri, Nov 09, 2018 at 08:02:52PM +0100, Adam Borowski wrote:
> @@ -122,7 +104,6 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
>  
>  targets += vmlinux.its
>  targets += vmlinux.gz.its
> -targets += vmlinux.bz2.its
>  targets += vmlinux.lzmo.its
>  targets += vmlinux.lzo.its

It looks to me like this "vmlinux.lzmo.its" was a typo & ought to have
been vmlinux.lzma.its, and thus ought to be removed.

Apart from that I'm fine with this in general:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
