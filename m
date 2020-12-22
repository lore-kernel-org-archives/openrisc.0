From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 22 Dec 2020 15:34:00 +0900
Subject: [OpenRISC] [PATCH] openrisc: Add vmlinux.bin target
In-Reply-To: <20201222061805.462460-1-joel@jms.id.au>
References: <20201222061805.462460-1-joel@jms.id.au>
Message-ID: <CAK7LNATHTT2=e0VxxunLhAGP5yDeGcdunxgp2Ne_P1kRAifecg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Dec 22, 2020 at 3:18 PM Joel Stanley <joel@jms.id.au> wrote:
>
> Build it by default. This is commonly used by fpga targets.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/openrisc/Makefile      | 7 +++++++
>  arch/openrisc/boot/Makefile | 8 ++++++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 arch/openrisc/boot/Makefile
>
> diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
> index bf10141c7426..239bca2d1925 100644
> --- a/arch/openrisc/Makefile
> +++ b/arch/openrisc/Makefile
> @@ -24,6 +24,10 @@ LIBGCC               := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
>
>  KBUILD_CFLAGS  += -pipe -ffixed-r10 -D__linux__
>
> +all: vmlinux.bin
> +
> +boot := arch/$(ARCH)/boot
> +
>  ifeq ($(CONFIG_OPENRISC_HAVE_INST_MUL),y)
>         KBUILD_CFLAGS += $(call cc-option,-mhard-mul)
>  else
> @@ -49,3 +53,6 @@ else
>  BUILTIN_DTB := n
>  endif
>  core-$(BUILTIN_DTB) += arch/openrisc/boot/dts/
> +

Since vmlinux.bin is a phony target, you need this:

PHONY += vmlinux.bin


> +vmlinux.bin: vmlinux
> +       $(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)


This is simpler:

          $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@



For clean-up, you need this:

archclean:
        $(Q)$(MAKE) $(clean)=$(boot)






> diff --git a/arch/openrisc/boot/Makefile b/arch/openrisc/boot/Makefile
> new file mode 100644
> index 000000000000..0e71e8f78bb2
> --- /dev/null
> +++ b/arch/openrisc/boot/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for bootable kernel images
> +#
> +
> +OBJCOPYFLAGS_vmlinux.bin := -O binary
> +$(obj)/vmlinux.bin: vmlinux FORCE
> +       $(call if_changed,objcopy)

Please add

targets += vmlinux.bin




Also, you need to add arch/openrisc/boot/.gitignore




> --
> 2.29.2
>


-- 
Best Regards
Masahiro Yamada
