From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Mon, 21 Mar 2016 23:27:50 +0100
Subject: [OpenRISC] [RFC PATCH 1/1] openrisc: Add optimized memcpy
	routine
In-Reply-To: <1458596217-14337-2-git-send-email-shorne@gmail.com>
References: <1458596217-14337-1-git-send-email-shorne@gmail.com>
 <1458596217-14337-2-git-send-email-shorne@gmail.com>
Message-ID: <56F07566.6090607@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Nice work.

A while since I've looked at this, but you might like to consider
whether the compiler is also aggressively optimizing memcpy in all
circumstances. The compiler should generate _builtin_memcpy for things
like structure assignment, and then lower that to suitably efficient
inline code in most circumstances.

Best wishes,


Jeremy

On 21/03/16 22:36, Stafford Horne wrote:
> The default memcpy routing provided in lib does only byte copies.
> Using word copies we can lower boot time and cycles spend in memcpy
> quite significantly.
> 
> Booting on my de0 nano I see boot times go from 7.2 to 5.6 seconds.
> The avg cycles in memcpy during boot go from 6467 to 1887.
> 
> This commit contains an option menu for people to see what I tried
> but in the end we should only leave the implementation we want to
> keep.
> The implementations I tested and avg cycles:
>   - Word Copies + Loop Unrolls + Non Aligned    1882
>   - Word Copies + Loop Unrolls                  1887
>   - Word Copies                                 2441
>   - Byte Copies + Loop Unrolls                  6467
>   - Byte Copies                                 7600
> 
> I would suggest going with the Word Copies + Loop Unrolls one as its
> provides best tradeoff between simplicity and boot speedups.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/Kconfig              |  61 ++++++
>  arch/openrisc/TODO.openrisc        |   1 -
>  arch/openrisc/include/asm/string.h |   5 +
>  arch/openrisc/lib/Makefile         |   3 +-
>  arch/openrisc/lib/memcpy.c         | 377 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 445 insertions(+), 2 deletions(-)
>  create mode 100644 arch/openrisc/lib/memcpy.c
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 6e88268..68c0588 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -115,6 +115,67 @@ config OPENRISC_HAVE_INST_LWA_SWA
>  
>  endmenu
>  
> +menu "Optimized Lib"
> +
> +config OPT_LIB_FUNCTION
> +	bool "Enable Optimalized lib functions"
> +	default y
> +	help
> +	  Tunes on optimalized library functions (memcpy and memset).
> +	  They are optimized for using word memory operations instead of
> +          the default byte operations.
> +choice
> +	prompt "Optimized lib Implementation"
> +	default OPT_LIB_WORD_NONALIGNED
> +	depends on OPT_LIB_FUNCTION
> +
> +config OPT_LIB_WORD_NONALIGNED
> +	bool "Non-Aligned Word Operations"
> +	help
> +	  The implementation performs word operations and loop unrolls.
> +	  It supports word operations on non-aligned memory but at the cost
> +	  of doing shifts and or operations to fix alignement issues.
> +
> +	  This should be the fasted implementation.
> +
> +config OPT_LIB_WORD_UNROLL
> +	bool "Unrolled Loop Word Operations"
> +	help
> +	  This implementation performs word operations and loop unrolls.
> +	  However, if memory being operated on is not word aligned it will
> +	  fall back to using byte operations.
> +
> +	  This may be as fast as the non-aligned operations if the shift and
> +	  or operations to reconstructe alignement issues are slower than the
> +	  4 byte memory operations.
> +
> +	  This should be the 2nd fastest implementation.
> +
> +config OPT_LIB_WORD
> +	bool "Simple Word Operations"
> +	help
> +	  This implementation performs word operations if data is word aligned
> +	  then falls back to byte operations.  It does not do loop unrolling.
> +
> +	  This should be 3rd fastest implementation.
> +
> +config OPT_LIB_BYTE_UNROLL
> +	bool "Unrolled Loop Byte Operations"
> +	help
> +	  This implemenation performes Byte operations with loop untolling.
> +
> +	  This should be the 4th fastest implementation.
> +
> +config OPT_LIB_BYTE
> +	bool "Simple Byte Operations"
> +	help
> +	  Simple byte operations. No frills but should not have any problem
> +	  working on any architecture.
> +
> +endchoice
> +
> +endmenu
> +
>  config NR_CPUS
>  	int "Maximum number of CPUs (2-32)"
>  	range 2 32
> diff --git a/arch/openrisc/TODO.openrisc b/arch/openrisc/TODO.openrisc
> index acfeef9..a2bda7b 100644
> --- a/arch/openrisc/TODO.openrisc
> +++ b/arch/openrisc/TODO.openrisc
> @@ -13,4 +13,3 @@ that are due for investigation shortly, i.e. our TODO list:
>     or1k and this change is slowly trickling through the stack.  For the time
>     being, or32 is equivalent to or1k.
>  
> --- Implement optimized version of memcpy and memset
> diff --git a/arch/openrisc/include/asm/string.h b/arch/openrisc/include/asm/string.h
> index 33470d4..04111b2 100644
> --- a/arch/openrisc/include/asm/string.h
> +++ b/arch/openrisc/include/asm/string.h
> @@ -1,7 +1,12 @@
>  #ifndef __ASM_OPENRISC_STRING_H
>  #define __ASM_OPENRISC_STRING_H
>  
> +#ifdef CONFIG_OPT_LIB_FUNCTION
>  #define __HAVE_ARCH_MEMSET
>  extern void *memset(void *s, int c, __kernel_size_t n);
>  
> +#define __HAVE_ARCH_MEMCPY
> +extern void *memcpy(void *dest, __const void *src, __kernel_size_t n);
> +#endif
> +
>  #endif /* __ASM_OPENRISC_STRING_H */
> diff --git a/arch/openrisc/lib/Makefile b/arch/openrisc/lib/Makefile
> index 67c583e..c3316f6 100644
> --- a/arch/openrisc/lib/Makefile
> +++ b/arch/openrisc/lib/Makefile
> @@ -2,4 +2,5 @@
>  # Makefile for or32 specific library files..
>  #
>  
> -obj-y  = memset.o string.o delay.o
> +obj-y				:= delay.o string.o
> +obj-$(CONFIG_OPT_LIB_FUNCTION)	+= memset.o memcpy.o
> diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
> new file mode 100644
> index 0000000..36a7aac
> --- /dev/null
> +++ b/arch/openrisc/lib/memcpy.c
> @@ -0,0 +1,377 @@
> +/*
> + * arch/openrisc/lib/memcpy.c
> + *
> + * Optimized memory copy routines for openrisc.  These are mostly copied
> + * from ohter sources but slightly entended based on ideas discuassed in
> + * #openrisc.
> + *
> + * The word non aligned is based on microblaze found in:
> + *  arch/microblaze/lib/memcpy.c
> + * but this is extended to have loop unrolls. This only supports
> + * big endian at the moment.
> + *
> + * The byte unroll implementation is a copy of that found in:
> + *  arm/boot/compressed/string.c
> + *
> + * The word unroll implementation is an extention to the byte
> + * unrolled implementation, but using word copies (if things are
> + * properly aligned)
> + */
> +
> +#ifndef _MC_TEST
> +#include <linux/export.h>
> +
> +#include <linux/string.h>
> +#endif
> +
> +#if defined(CONFIG_OPT_LIB_WORD_NONALIGNED)
> +/*
> + * Make below loops a bit more manageable
> + *
> + *
> + */
> +#define __OFFSET_MEMCPY(n) 	value = *src_w++;					\
> +				*dest_w++ = buf_hold | value >> ( ( 4 - n ) * 8 );	\
> +				buf_hold = value << ( n * 8 )
> +
> +void *memcpy(void *dest, const void *src, __kernel_size_t n)
> +{
> +	const char *src_b = src;
> +	char *dest_b = dest;
> +	int i;
> +
> +	/* The following code tries to optimize the copy by using unsigned
> +	 * alignment. This will work fine if both source and destination are
> +	 * aligned on the same boundary. However, if they are aligned on
> +	 * different boundaries shifts will be necessary.
> +	 */
> +	const uint32_t *src_w;
> +	uint32_t *dest_w;
> +
> +	if (likely(n >= 4)) {
> +		unsigned  value, buf_hold;
> +
> +		/* Align the destination to a word boundary. */
> +		/* This is done in an endian independent manner. */
> +		switch ((unsigned long)dest_b & 3) {
> +		case 1:
> +			*dest_b++ = *src_b++;
> +			--n;
> +		case 2:
> +			*dest_b++ = *src_b++;
> +			--n;
> +		case 3:
> +			*dest_b++ = *src_b++;
> +			--n;
> +		}
> +
> +		dest_w = (void *)dest_b;
> +
> +		/* Choose a copy scheme based on the source, this is done big endian */
> +		/* alignment relative to destination. */
> +		switch ((unsigned long)src_b & 3) {
> +		case 0x0:	/* Both byte offsets are aligned */
> +			src_w  = (const uint32_t *)src_b;
> +
> +			/* Copy 32 bytes per loop */
> +			for (i = n >> 5; i > 0; i--) {
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +			}
> +
> +			if (n & 1 << 4) {
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +			}
> +
> +			if (n & 1 << 3) {
> +				*dest_w++ = *src_w++;
> +				*dest_w++ = *src_w++;
> +			}
> +
> +			if (n & 1 << 2)
> +				*dest_w++ = *src_w++;
> +
> +			src_b  = (const char *)src_w;
> +			break;
> +
> +		case 0x1:	/* Unaligned - Off by 1 */
> +			/* Word align the source */
> +			src_w = (const void *) ((unsigned)src_b & ~3);
> +			/* Load the holding buffer */
> +			buf_hold = *src_w++ << 8;
> +
> +			for (i = n >> 5; i > 0; i--) {
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +			}
> +
> +			if (n & 1 << 4) {
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +			}
> +
> +			if (n & 1 << 3) {
> +				__OFFSET_MEMCPY(1);
> +				__OFFSET_MEMCPY(1);
> +			}
> +
> +			if (n & 1 << 2) {
> +				__OFFSET_MEMCPY(1);
> +			}
> +
> +			/* Realign the source */
> +			src_b = (const void *)src_w;
> +			src_b -= 3;
> +			break;
> +		case 0x2:	/* Unaligned - Off by 2 */
> +			/* Word align the source */
> +			src_w = (const void *) ((unsigned)src_b & ~3);
> +			/* Load the holding buffer */
> +			buf_hold = *src_w++ << 16;
> +
> +			for (i = n >> 5; i > 0; i--) {
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +			}
> +
> +			if (n & 1 << 4) {
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +			}
> +
> +			if (n & 1 << 3) {
> +				__OFFSET_MEMCPY(2);
> +				__OFFSET_MEMCPY(2);
> +			}
> +
> +			if (n & 1 << 2) {
> +				__OFFSET_MEMCPY(2);
> +			}
> +
> +			/* Realign the source */
> +			src_b = (const void *)src_w;
> +			src_b -= 2;
> +			break;
> +		case 0x3:	/* Unaligned - Off by 3 */
> +			/* Word align the source */
> +			src_w = (const void *) ((unsigned)src_b & ~3);
> +			/* Load the holding buffer */
> +			buf_hold = *src_w++ << 24;
> +
> +			for (i = n >> 5; i > 0; i--) {
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +			}
> +
> +			if (n & 1 << 4) {
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +			}
> +
> +			if (n & 1 << 3) {
> +				__OFFSET_MEMCPY(3);
> +				__OFFSET_MEMCPY(3);
> +			}
> +
> +			if (n & 1 << 2) {
> +				__OFFSET_MEMCPY(3);
> +			}
> +
> +			/* Realign the source */
> +			src_b = (const void *)src_w;
> +			src_b -= 1;
> +			break;
> +		}
> +		dest_b = (void *)dest_w;
> +	}
> +
> +	/* Finish off any remaining bytes */
> +	/* simple fast copy, ... unless a cache boundary is crossed */
> +       	if (n & 1 << 1) {
> +		*dest_b++ = *src_b++;
> +		*dest_b++ = *src_b++;
> +	}
> +
> +	if (n & 1)
> +		*dest_b++ = *src_b++;
> +
> +
> +	return dest;
> +}
> +#elif defined(CONFIG_OPT_LIB_WORD)
> +void * memcpy(void *dest, __const void *src, __kernel_size_t n)
> +{
> +	unsigned char * d = (unsigned char *) dest, * s = (unsigned char *) src;
> +	uint32_t * dest_w = (uint32_t *) dest, * src_w = (uint32_t *) src;
> +
> +	/* If both source and dest are word aligned copy words */
> +	if (!((unsigned)dest_w & 3) && !((unsigned)src_w & 3)) {
> +		for (; n >= 4; n -= 4)
> +			*dest_w++ = *src_w++;
> +	}
> +
> +	d = (unsigned char *) dest_w;
> +	s = (unsigned char *) src_w;
> +
> +	/* For remaining or if not aligned, copy bytes */
> +	for (; n >= 1; n -= 1)
> +		*d++ = *s++;
> +
> +	return dest;
> +
> +}
> +#elif defined(CONFIG_OPT_LIB_WORD_UNROLL)
> +void * memcpy(void *dest, __const void *src, __kernel_size_t n)
> +{
> +	int i = 0;
> +	unsigned char * d, * s;
> +	uint32_t * dest_w = (uint32_t *) dest, * src_w = (uint32_t *) src;
> +
> +	/* If both source and dest are word aligned copy words */
> +	if (!((unsigned)dest_w & 3) && !((unsigned)src_w & 3)) {
> +		/* Copy 32 bytes per loop */
> +		for (i = n >> 5; i > 0; i--) {
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +		}
> +
> +		if (n & 1 << 4) {
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +		}
> +
> +		if (n & 1 << 3) {
> +			*dest_w++ = *src_w++;
> +			*dest_w++ = *src_w++;
> +		}
> +
> +		if (n & 1 << 2)
> +			*dest_w++ = *src_w++;
> +
> +		d = (unsigned char *) dest_w;
> +		s = (unsigned char *) src_w;
> +
> +	} else {
> +		d = (unsigned char *) dest_w;
> +		s = (unsigned char *) src_w;
> +
> +		for (i = n >> 3; i > 0; i--) {
> +			*d++ = *s++;
> +			*d++ = *s++;
> +			*d++ = *s++;
> +			*d++ = *s++;
> +			*d++ = *s++;
> +			*d++ = *s++;
> +			*d++ = *s++;
> +			*d++ = *s++;
> +		 }
> +
> +		 if (n & 1 << 2) {
> +			*d++ = *s++;
> +			*d++ = *s++;
> +			*d++ = *s++;
> +			*d++ = *s++;
> +		 }
> +	}
> +
> +       	if (n & 1 << 1) {
> +		*d++ = *s++;
> +		*d++ = *s++;
> +	}
> +
> +	if (n & 1)
> +		*d++ = *s++;
> +
> +	return dest;
> +}
> +
> +#elif defined(CONFIG_OPT_LIB_BYTE_UNROLL)
> +void * memcpy(void *dest, __const void *src, __kernel_size_t n)
> +{
> +	int i = 0;
> +	unsigned char * d = (unsigned char *) dest, * s = (unsigned char *) src;
> +
> +	/* For remaining or if not aligned, still unroll loops */
> +	for (i = n >> 3; i > 0; i--) {
> +		*d++ = *s++;
> +		*d++ = *s++;
> +		*d++ = *s++;
> +		*d++ = *s++;
> +		*d++ = *s++;
> +		*d++ = *s++;
> +		*d++ = *s++;
> +		*d++ = *s++;
> +	}
> +
> +	if (n & 1 << 2) {
> +		*d++ = *s++;
> +		*d++ = *s++;
> +		*d++ = *s++;
> +		*d++ = *s++;
> +	}
> +
> +	if (n & 1 << 1) {
> +		*d++ = *s++;
> +		*d++ = *s++;
> +	}
> +
> +	if (n & 1)
> +		*d++ = *s++;
> +
> +	return dest;
> +}
> +#else /* CONFIG_OPT_LIB_BYTE fallback */
> +void * memcpy(void *dest, __const void *src, __kernel_size_t n)
> +{
> +	unsigned char * d = (unsigned char *) dest, * s = (unsigned char *) src;
> +
> +	/* For remaining or if not aligned, still unroll loops */
> +	for (; n > 0; n--)
> +		*d++ = *s++;
> +
> +	return dest;
> +}
> +#endif
> +
> +EXPORT_SYMBOL(memcpy);
> 


-- 
Tel:     +44 (1590) 610184
Cell:    +44 (7970) 676050
SkypeID: jeremybennett
Twitter: @jeremypbennett
Email:   jeremy.bennett at embecosm.com
Web:     www.embecosm.com
PGP key: 1024D/BEF58172FB4754E1 2009-03-20

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160321/8e2c384f/attachment.sig>
