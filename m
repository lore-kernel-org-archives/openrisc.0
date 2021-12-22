From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Wed, 22 Dec 2021 17:20:10 -0300
Subject: [OpenRISC] [PATCH v3 10/13] or1k: ABI lists
In-Reply-To: <20211210233456.4146479-11-shorne@gmail.com>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-11-shorne@gmail.com>
Message-ID: <1a46b8a6-87dd-b811-fd82-0292ea575935@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:

> diff --git a/sysdeps/unix/sysv/linux/or1k/ld.abilist b/sysdeps/unix/sysv/linux/or1k/ld.abilist
> new file mode 100644
> index 0000000000..c4b85c8a33
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/ld.abilist
> @@ -0,0 +1,5 @@
> +GLIBC_2.35 __libc_stack_end D 0x4
> +GLIBC_2.35 __stack_chk_guard D 0x4
> +GLIBC_2.35 __tls_get_addr F
> +GLIBC_2.35 _dl_mcount F
> +GLIBC_2.35 _r_debug D 0x14

You will need to regenerate it to include the rseq symbols:

GLIBC_2.35 __rseq_flags D 0x4
GLIBC_2.35 __rseq_offset D 0x4
GLIBC_2.35 __rseq_size D 0x4


> diff --git a/sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist b/sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist
> new file mode 100644
> index 0000000000..366c393274
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/libBrokenLocale.abilist
> @@ -0,0 +1 @@
> +GLIBC_2.35 __ctype_get_mb_cur_max F
> diff --git a/sysdeps/unix/sysv/linux/or1k/libanl.abilist b/sysdeps/unix/sysv/linux/or1k/libanl.abilist
> new file mode 100644
> index 0000000000..c6437809db
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/libanl.abilist
> @@ -0,0 +1 @@
> +GLIBC_2.35 __libanl_version_placeholder F

This does seems right, or1k should not require the placeholder.  I think
we are missing a SHLIB_COMPAT on resolv/libanl-compat.c:

diff --git a/resolv/libanl-compat.c b/resolv/libanl-compat.c
index 29df76f278..02c18bde90 100644
--- a/resolv/libanl-compat.c
+++ b/resolv/libanl-compat.c
@@ -30,6 +30,8 @@ __libanl_version_placeholder_1 (void)
 {
 }
 
+# if SHLIB_COMPAT (libanl, GLIBC_2_2_3, GLIBC_2_34)
 compat_symbol (libanl, __libanl_version_placeholder_1,
                __libanl_version_placeholder, GLIBC_2_2_3);
+# endif
 #endif

> diff --git a/sysdeps/unix/sysv/linux/or1k/libutil.abilist b/sysdeps/unix/sysv/linux/or1k/libutil.abilist
> new file mode 100644
> index 0000000000..f33b84813b
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/libutil.abilist
> @@ -0,0 +1 @@
> +GLIBC_2.35 __libutil_version_placeholder F

This also does not seems right, libutil-compat will only built for
have-GLIBC_2.33, which is not the case.
