From: Stafford Horne <shorne@gmail.com>
Date: Mon, 18 Jan 2021 21:08:53 +0900
Subject: [OpenRISC] [PATCH] openrisc: add arch/openrisc/Kbuild
In-Reply-To: <20210117080332.2289077-1-masahiroy@kernel.org>
References: <20210117080332.2289077-1-masahiroy@kernel.org>
Message-ID: <20210118120853.GG2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Jan 17, 2021 at 05:03:32PM +0900, Masahiro Yamada wrote:
> Describe the subdirectories under arch/openrisc/ in arch/openrisc/Kbuild
> so you can use the standard obj-y syntax.
> 
> I removed the CONFIG_OPENRISC_BUILTIN_DTB conditional because it is
> already controlled by arch/openrisc/boot/dts/Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thank you, This looks OK to me, I have queued this for next.

There was a small conflict with the vmlinux.bin changes you reviewed earlier.
I resolved them and did a test bild and it seems to all be fine.

-Stafford

