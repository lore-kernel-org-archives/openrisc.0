From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Dec 2016 09:57:11 +0100
Subject: [OpenRISC] [PATCH v2 8/9] openrisc: Updates after openrisc.net
	has been lost
In-Reply-To: <85a10b7601c10dc0cf710f69d5729bf1871de22c.1479128947.git.shorne@gmail.com>
References: <cover.1479128947.git.shorne@gmail.com>
 <1479130239-30707-1-git-send-email-shorne@gmail.com>
 <85a10b7601c10dc0cf710f69d5729bf1871de22c.1479128947.git.shorne@gmail.com>
Message-ID: <CAMuHMdU1EUpjmNVMv3Kmb1FrvzpxUVtcfLKmCduT5-pSUZw-bA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford, Stefan,

On Mon, Nov 14, 2016 at 2:30 PM, Stafford Horne <shorne@gmail.com> wrote:
> The openrisc.net domain expired and was taken over by squatters.
> These updates point documentation to the new domain, mailing lists
> and git repos.
>
> Also, Jonas is not the main maintainer anylonger, he reviews changes
> but does not maintain a repo or sent pull requests.  Updating this to
> add Stafford and Stefan who are the active maintainers.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  MAINTAINERS                   | 6 ++++--
>  arch/openrisc/README.openrisc | 8 ++++----
>  arch/openrisc/kernel/setup.c  | 2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 851b89b..d84a585 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8958,9 +8958,11 @@ F:       drivers/of/resolver.c
>
>  OPENRISC ARCHITECTURE
>  M:     Jonas Bonn <jonas@southpole.se>
> -W:     http://openrisc.net
> +M:     Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> +M:     Stafford Horne <shorne@gmail.com>
> +L:     openrisc at lists.librecores.org
> +W:     http://openrisc.io
>  S:     Maintained
> -T:     git git://openrisc.net/~jonas/linux
>  F:     arch/openrisc/

It's great news to see new active maintainers for OpenRISC.
Thanks a lot!

Somehow I seem to have missed the new mailing announcement.
Subscribed ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

