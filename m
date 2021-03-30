From: Daniel Walker <danielwa@cisco.com>
Date: Tue, 30 Mar 2021 11:23:39 -0700
Subject: [OpenRISC] [PATCH v3 01/17] cmdline: Add generic function to
 build command line.
In-Reply-To: <D8C1FBF6-E5C0-4233-BCB8-694274EA28F9@goldelico.com>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
 <20210330172714.GR109100@zorba>
 <D8C1FBF6-E5C0-4233-BCB8-694274EA28F9@goldelico.com>
Message-ID: <20210330182339.GU109100@zorba>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Mar 30, 2021 at 08:07:30PM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 30.03.2021 um 19:27 schrieb Daniel Walker <danielwa@cisco.com>:
> > 
> > On Fri, Mar 26, 2021 at 01:44:48PM +0000, Christophe Leroy wrote:
> >> This code provides architectures with a way to build command line
> >> based on what is built in the kernel and what is handed over by the
> >> bootloader, based on selected compile-time options.
> >> 
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >> v3:
> >> - Addressed comments from Will
> >> - Added capability to have src == dst
> >> ---
> >> include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 57 insertions(+)
> >> create mode 100644 include/linux/cmdline.h
> >> 
> >> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> >> new file mode 100644
> >> index 000000000000..dea87edd41be
> >> --- /dev/null
> >> +++ b/include/linux/cmdline.h
> >> @@ -0,0 +1,57 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _LINUX_CMDLINE_H
> >> +#define _LINUX_CMDLINE_H
> >> +
> >> +#include <linux/string.h>
> >> +
> >> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
> >> +#ifndef cmdline_strlcat
> >> +#define cmdline_strlcat strlcat
> >> +#endif
> >> +
> >> +/*
> >> + * This function will append or prepend a builtin command line to the command
> >> + * line provided by the bootloader. Kconfig options can be used to alter
> >> + * the behavior of this builtin command line.
> >> + * @dst: The destination of the final appended/prepended string.
> >> + * @src: The starting string or NULL if there isn't one.
> >> + * @len: the length of dest buffer.
> >> + */
> > 
> > Append or prepend ? Cisco requires both at the same time. This is why my
> > implementation provides both. I can't use this with both at once.
> 
> Just an idea: what about defining CMDLINE as a pattern where e.g. "$$" or "%%"
> is replaced by the boot loader command line?
> 
> Then you can formulate replace, prepend, append, prepend+append with a single
> CONFIG setting.
> 
> It may be a little more complex in code (scanning for the pattern and replacing
> it and take care to temporary memory) but IMHO it could be worth to consider.

In some cases this code could be used extremely early in boot up. For example in the
prom_init.c powerpc code, or in efi changes. The flexibility to find and replace
like that is not always an option due to the nature of the environment. It's not
impossible of course.

Daniel
