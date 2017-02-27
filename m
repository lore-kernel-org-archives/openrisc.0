From: Ben Hutchings <ben@decadent.org.uk>
Date: Mon, 27 Feb 2017 14:06:56 +0000
Subject: [OpenRISC] [PATCH] kbuild: avoid unrecognized option error for
	external DTC
In-Reply-To: <1488174052-2530-1-git-send-email-yamada.masahiro@socionext.com>
References: <1488174052-2530-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1488204416.2819.9.camel@decadent.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Mon, 2017-02-27 at 14:40 +0900, Masahiro Yamada wrote:
> Since commit 6b22b3d1614a ("kbuild: Allow using host dtc instead of
> kernel's copy"), it is possible to use an external dtc.  In this
> case, we do not know which options are supported on it.
> 
> Commit bc553986a2f7 ("dtc: turn off dtc unit address warnings by
> default") gives -Wno-unit_address_vs_reg, but this options is only
> recognized by v1.4.2 or later.
> 
> If an older version is specified, the build fails:

But the option to use an external dtc was intended to allow testing of
newer versions.  If there's no reason to use this option to run an
older version, why bother trying to support that?

[...]
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -171,6 +171,20 @@ ld-version = $(shell $(LD) --version | $(srctree)/scripts/ld-version.sh)
>  # Usage:  $(call ld-ifversion, -ge, 22252, y)
>  ld-ifversion = $(shell [ $(ld-version) $(1) $(2) ] && echo $(3) || echo $(4))
>  
> +# dtc-option
> +# Usage:  DTC_FLAGS += $(call dtc-option,-Wno-unit_address_vs_reg)
> +#
> +# When we use the external dtc, check if the desired options are supported.
> +# When we use the kernel's copy (scripts/dtc/dtc), just use the fixed option.
> +# Until Kbuild descends into the scripts/dtc/ directory, scripts/dtc/dtc may
> +# not exist, i.e. $(call try-run,...) may not work.
> +ifeq ("$(origin DTC)", "command line")
[...]

It could also be specified as an environment variable (assignment with
"?=" doesn't override them, but "=" does).

Ben.

-- 
Ben Hutchings
This sentence contradicts itself - no actually it doesn't.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170227/672850b7/attachment.sig>
