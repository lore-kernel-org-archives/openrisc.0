From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 31 Jan 2020 08:25:34 -0000
Subject: [OpenRISC] [PATCH] openrisc: configs: Cleanup
 CONFIG_CROSS_COMPILE
In-Reply-To: <20200130213839.GW24874@lianli.shorne-pla.net>
References: <20200130191938.2444-1-krzk@kernel.org>
 <20200130213839.GW24874@lianli.shorne-pla.net>
Message-ID: <CAJKOXPcfpTMr+KGLXCC2Kb5Hz+jSX+6KtCoPS-0qWdk2sazTeQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, 30 Jan 2020 at 22:38, Stafford Horne <shorne@gmail.com> wrote:
>
> +cc: Masahiro,
>
> On Thu, Jan 30, 2020 at 08:19:38PM +0100, Krzysztof Kozlowski wrote:
> > CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
> > CONFIG_CROSS_COMPILE support").
>
> I see this patch is already in, but does it break 0-day test tools that depend
> on this CONFIG_CROSS_COMPILE setup?  I guess its been in since 2018, so there
> should be no problem.
>
> Can you also help to update "Documentation/openrisc/openrisc_port.rst"?  It
> mentions the build steps are:
>
>     Build the Linux kernel as usual::
>
>         make ARCH=openrisc defconfig
>         make ARCH=openrisc
>
> This now changes, I used to use `make ARCH=openrisc CROSS_COMPILE=or1k-linux-`
> is this still going to work?

All cross compile platforms are being built like this, so I guess
openrisc should not be different. I will send a patch for the doc
update.

Best regards,
Krzysztof
