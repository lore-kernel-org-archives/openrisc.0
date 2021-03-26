From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Mar 2021 09:42:35 -0600
Subject: [OpenRISC] [PATCH v3 01/17] cmdline: Add generic function to
 build command line.
In-Reply-To: <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
Message-ID: <CAL_JsqKr3xekKSo3DtQvOOw_VoGC=FUTagZGY5g=CGGGdUZSMQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> This code provides architectures with a way to build command line
> based on what is built in the kernel and what is handed over by the
> bootloader, based on selected compile-time options.

Note that I have this patch pending:

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210316193820.3137-1-alex at ghiti.fr/

It's going to need to be adapted for this. I've held off applying to
see if this gets settled.

>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3:
> - Addressed comments from Will
> - Added capability to have src == dst
> ---
>  include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 include/linux/cmdline.h
>
> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> new file mode 100644
> index 000000000000..dea87edd41be
> --- /dev/null
> +++ b/include/linux/cmdline.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CMDLINE_H
> +#define _LINUX_CMDLINE_H
> +
> +#include <linux/string.h>
> +
> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
> +#ifndef cmdline_strlcat
> +#define cmdline_strlcat strlcat
> +#endif
> +
> +/*
> + * This function will append or prepend a builtin command line to the command
> + * line provided by the bootloader. Kconfig options can be used to alter
> + * the behavior of this builtin command line.
> + * @dst: The destination of the final appended/prepended string.
> + * @src: The starting string or NULL if there isn't one.
> + * @len: the length of dest buffer.
> + */
> +static __always_inline void __cmdline_build(char *dst, const char *src, size_t len)
> +{
> +       if (!len || src == dst)
> +               return;
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src) {
> +               dst[0] = 0;
> +               cmdline_strlcat(dst, CONFIG_CMDLINE, len);
> +               return;
> +       }
> +
> +       if (dst != src)
> +               dst[0] = 0;
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_PREPEND))
> +               cmdline_strlcat(dst, CONFIG_CMDLINE " ", len);
> +
> +       cmdline_strlcat(dst, src, len);
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))

Should be APPEND.

> +               cmdline_strlcat(dst, " " CONFIG_CMDLINE, len);
> +}
> +
> +#define cmdline_build(dst, src, len) do {                              \

Perhaps a comment why we need this to be a define.

> +       char *__c_dst = (dst);                                          \
> +       const char *__c_src = (src);                                    \
> +                                                                       \
> +       if (__c_src == __c_dst) {                                       \
> +               static char __c_tmp[COMMAND_LINE_SIZE] __initdata = ""; \
> +                                                                       \
> +               cmdline_strlcat(__c_tmp, __c_src, COMMAND_LINE_SIZE);   \
> +               __cmdline_build(__c_dst, __c_tmp, (len));               \
> +       } else {                                                        \
> +               __cmdline_build(__c_dst, __c_src, (len));               \
> +       }                                                               \
> +} while (0)
> +
> +#endif /* _LINUX_CMDLINE_H */
> --
> 2.25.0
>
