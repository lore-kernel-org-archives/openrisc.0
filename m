From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Mar 2021 12:22:04 -0600
Subject: [OpenRISC] [PATCH v3 05/17] arm: Convert to GENERIC_CMDLINE
In-Reply-To: <c18ef8f7-8e79-a9d3-3853-f8b992a4fc93@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <7362e4f6a5f5b79e6ad3fd3cec3183a4a283f7fc.1616765870.git.christophe.leroy@csgroup.eu>
 <CAL_Jsq+LF-s5K4Jwd5jCHrU8271L5WCiGb0tR7aTUa8ddHF1YQ@mail.gmail.com>
 <c18ef8f7-8e79-a9d3-3853-f8b992a4fc93@csgroup.eu>
Message-ID: <CAL_JsqJOFHmfRNAXgm6Gbe3qTUwnUTroxPzPmmLJUN7ciM2z9g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

+Nico who added the line in question.

On Fri, Mar 26, 2021 at 9:50 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 26/03/2021 à 16:47, Rob Herring a écrit :
> > On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >> This converts the architecture to GENERIC_CMDLINE.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >>   arch/arm/Kconfig              | 38 +----------------------------------
> >>   arch/arm/kernel/atags_parse.c | 15 +++++---------
> >>   2 files changed, 6 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 5da96f5df48f..67bc75f2da81 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -50,6 +50,7 @@ config ARM
> >>          select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
> >>          select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
> >>          select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> >> +       select GENERIC_CMDLINE if ATAGS
> >
> > Don't we need this enabled for !ATAGS (i.e. DT boot)?
> >
> > Can we always enable GENERIC_CMDLINE for OF_EARLY_FLATTREE?
> >
>
> Don't know.
>
> Today ARM has:
>
> choice
>         prompt "Kernel command line type" if CMDLINE != ""
>         default CMDLINE_FROM_BOOTLOADER
>         depends on ATAGS

I think that's a mistake. In a DT only case (no ATAGS), we'll get
different behaviour (in fdt.c) depending if CONFIG_ATAGS is enabled or
not. Note that at the time (2012) the above was added, the DT code
only supported CONFIG_CMDLINE and CONFIG_CMDLINE_FORCE.
CONFIG_CMDLINE_EXTEND was only added in 2016. And that has different
behavior for ATAGS vs. DT. In summary, it's a mess. We should drop the
depends either before this patch or just as part of this patch IMO.
I'd go with the latter given CONFIG_ATAGS is default y and enabled for
common configs. Without that, it looks like CONFIG_CMDLINE disappears
from menuconfig for at91_dt_defconfig.

Also, I think this code should be refactored a bit to eliminate
default_command_line. Instead, we should just save a pointer to the
ATAGS command line string, and then call cmdline_build here instead of
doing the extra copy:

        /* parse_early_param needs a boot_command_line */
        strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);

Rob
