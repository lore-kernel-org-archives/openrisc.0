From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date: Mon, 19 Apr 2021 11:26:32 +0200
Subject: [OpenRISC] [PATCH 1/4] or1k: Fix issue with plt link failure
 for local calls
In-Reply-To: <20210419000524.3625897-2-shorne@gmail.com>
References: <20210419000524.3625897-1-shorne@gmail.com>
 <20210419000524.3625897-2-shorne@gmail.com>
Message-ID: <901d949c-f056-c680-d011-25b0b6fc23e4@benettiengineering.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford, All,

I've tested this patch succesfully rebuilding protobuf with Buildroot.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

On 4/19/21 2:05 AM, Stafford Horne wrote:
> When building protobuf we were seeing the assert failure:
> 
>      /home/giuliobenetti/git/upstream/or1k-binutils-2.36.1/host/lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld:
>      BFD (GNU Binutils) 2.36.1 assertion fail elf32-or1k.c:2377
>      /home/giuliobenetti/git/upstream/or1k-binutils-2.36.1/host/lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld:
>      BFD (GNU Binutils) 2.36.1 assertion fail elf32-or1k.c:2377
>      /home/giuliobenetti/git/upstream/or1k-binutils-2.36.1/host/lib/gcc/or1k-buildroot-linux-uclibc/9.3.0/../../../../or1k-buildroot-linux-uclibc/bin/ld:
>      BFD (GNU Binutils) 2.36.1 assertion fail elf32-or1k.c:2377
>      collect2: error: ld returned 1 exit status
> 
> This failure happens while writing out PLT entries, there is a check
> "BFD_ASSERT (h->dynindx != -1)" to confirm all plt entries have dynamic
> symbol attributes.  This was failing for symbols that were
> "forced_local" in previous linking code.
> 
> The fix adds logic to or1k_elf_adjust_dynamic_symbol to identify
> "forced_local" symbols and exclude them from the the PLT.
> 
> bfd/ChangeLog:
> 
> 	PR 27624
> 	* elf32-or1k.c (or1k_elf_adjust_dynamic_symbol): Change
> 	condition used to cleanup plt entries to cleanup forced local
> 	entries.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>   bfd/elf32-or1k.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
> index 013deb406f8..cc6c51220e5 100644
> --- a/bfd/elf32-or1k.c
> +++ b/bfd/elf32-or1k.c
> @@ -2566,11 +2566,10 @@ or1k_elf_adjust_dynamic_symbol (struct bfd_link_info *info,
>     if (h->type == STT_FUNC
>         || h->needs_plt)
>       {
> -      if (! bfd_link_pic (info)
> -	  && !h->def_dynamic
> -	  && !h->ref_dynamic
> -	  && h->root.type != bfd_link_hash_undefweak
> -	  && h->root.type != bfd_link_hash_undefined)
> +      if (h->plt.refcount <= 0
> +	  || (SYMBOL_CALLS_LOCAL (info, h)
> +	  || (ELF_ST_VISIBILITY (h->other) != STV_DEFAULT
> +	      && h->root.type == bfd_link_hash_undefweak)))
>   	{
>   	  /* This case can occur if we saw a PLT reloc in an input
>   	     file, but the symbol was never referred to by a dynamic
> 

