From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 18 Nov 2021 22:34:10 +0000
Subject: [OpenRISC] [PATCH v2 11/13] or1k: Build Infrastructure
In-Reply-To: <20211113031639.2402161-12-shorne@gmail.com>
References: <20211113031639.2402161-1-shorne@gmail.com>
 <20211113031639.2402161-12-shorne@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111182231450.1393807@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, 13 Nov 2021, Stafford Horne via Libc-alpha wrote:

> diff --git a/sysdeps/unix/sysv/linux/or1k/configure.ac b/sysdeps/unix/sysv/linux/or1k/configure.ac
> new file mode 100644
> index 0000000000..d439e7fd53
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/configure.ac
> @@ -0,0 +1,4 @@
> +GLIBC_PROVIDES dnl See aclocal.m4 in the top level source directory.
> +# Local configure fragment for sysdeps/unix/sysv/linux/or1k.
> +
> +arch_minimum_kernel=5.10.0

This seems to be a lot more recent than when OpenRISC support was actually 
added to the Linux kernel, and also more recent than when 64-bit time 
support was added for 32-bit architectures (which may be a convenient 
minimum kernel for some new 32-bit architectures for that reason).  
Requiring a newer kernel like that is certainly fine if convenient for the 
port, but I think the choice of minimum kernel version, and the reasons 
for it, deserve mention at least in the commit message and the NEWS file 
entry.

-- 
Joseph S. Myers
joseph at codesourcery.com
