From: David Howells <dhowells@redhat.com>
Date: Fri, 13 Jan 2017 15:36:43 +0000
Subject: [OpenRISC] =?utf-8?q?=28no_subject=29?=
In-Reply-To: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
References: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <25063.1484321803@warthog.procyon.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

> This header file is exported, thus move it to uapi.

Exported how?

> +#ifdef __INT32_TYPE__
> +#undef __INT32_TYPE__
> +#define __INT32_TYPE__		int
> +#endif
> +
> +#ifdef __UINT32_TYPE__
> +#undef __UINT32_TYPE__
> +#define __UINT32_TYPE__	unsigned int
> +#endif
> +
> +#ifdef __UINTPTR_TYPE__
> +#undef __UINTPTR_TYPE__
> +#define __UINTPTR_TYPE__	unsigned long
> +#endif

These weren't defined by the kernel before, so why do we need to define them
now?

Will defining __UINTPTR_TYPE__ cause problems in compiling libboost by
changing the signature on C++ functions that use uintptr_t?

David
