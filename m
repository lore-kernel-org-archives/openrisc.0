From: Jonas Bonn <jonas@southpole.se>
Date: Sat, 31 Dec 2016 15:11:27 +0100
Subject: [OpenRISC] [PATCH 1/3] openrisc: Add _text symbol to fix ksym
	build error
In-Reply-To: <da0fbe6c8413d990849d8f8764033810b18b83e9.1483184705.git.shorne@gmail.com>
References: <cover.1483184705.git.shorne@gmail.com>
 <da0fbe6c8413d990849d8f8764033810b18b83e9.1483184705.git.shorne@gmail.com>
Message-ID: <99666d68-29c8-7241-1fd3-dc335c8506b7@southpole.se>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 12/31/2016 12:52 PM, Stafford Horne wrote:
> The build robot reports:
>
>     .tmp_kallsyms1.o: In function `kallsyms_relative_base':
>>> (.rodata+0x8a18): undefined reference to `_text'
> This is when using 'make alldefconfig'. Adding this _text symbol to mark
> the start of the kernel as in other architecture fixes this.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Acked-by: Jonas Bonn <jonas@southpole.se>

> ---
>   arch/openrisc/kernel/vmlinux.lds.S | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
> index ef31fc2..5525446 100644
> --- a/arch/openrisc/kernel/vmlinux.lds.S
> +++ b/arch/openrisc/kernel/vmlinux.lds.S
> @@ -44,6 +44,8 @@ SECTIONS
>           /* Read-only sections, merged into text segment: */
>           . = LOAD_BASE ;
>   
> +	_text = .;
> +
>   	/* _s_kernel_ro must be page aligned */
>   	. = ALIGN(PAGE_SIZE);
>   	_s_kernel_ro = .;



