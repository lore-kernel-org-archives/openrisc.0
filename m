From: Stafford Horne <shorne@gmail.com>
Date: Thu, 10 Jun 2021 06:44:43 +0900
Subject: [OpenRISC] [PATCH] bfd/elf32-or1k: fix building with gcc
 version < 5
In-Reply-To: <20210609153059.191496-1-giulio.benetti@benettiengineering.com>
References: <20210609153059.191496-1-giulio.benetti@benettiengineering.com>
Message-ID: <YME2SzQdpj/AVz/2@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jun 09, 2021 at 05:30:59PM +0200, Giulio Benetti wrote:
> Gcc version >= 5 has standard C mode not set to -std=gnu11, so if we use
> an old compiler(i.e. gcc 4.9) build fails on:
> ```
> elf32-or1k.c:2251:3: error: 'for' loop initial declarations are only allowed in
> C99 or C11 mode
>     for (size_t i = 0; i < insn_count; i++)
>     ^
> ```
> 
> So let's declare `size_t i` at the top of the function instead of inside
> for loop.

This looks ok to me.  Can you also include the changelog entry needed for
binutils patches?

Something like:

bfd/ChangeLog:

	* elf32-or1k.c (or1k_write_plt_entry): Move i declaration to top of
	function.

> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  bfd/elf32-or1k.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
> index 4ae7f324d33..32063ab0289 100644
> --- a/bfd/elf32-or1k.c
> +++ b/bfd/elf32-or1k.c
> @@ -2244,9 +2244,10 @@ or1k_write_plt_entry (bfd *output_bfd, bfd_byte *contents, unsigned insnj,
>  {
>    unsigned nodelay = elf_elfheader (output_bfd)->e_flags & EF_OR1K_NODELAY;
>    unsigned output_insns[PLT_MAX_INSN_COUNT];
> +  size_t i;
>  
>    /* Copy instructions into the output buffer.  */
> -  for (size_t i = 0; i < insn_count; i++)
> +  for (i = 0; i < insn_count; i++)
>      output_insns[i] = insns[i];
>  
>    /* Honor the no-delay-slot setting.  */
> @@ -2277,7 +2278,7 @@ or1k_write_plt_entry (bfd *output_bfd, bfd_byte *contents, unsigned insnj,
>      }
>  
>    /* Write out the output buffer.  */
> -  for (size_t i = 0; i < (insn_count+1); i++)
> +  for (i = 0; i < (insn_count+1); i++)
>      bfd_put_32 (output_bfd, output_insns[i], contents + (i*4));
>  }
>  
> -- 
> 2.25.1
> 
