From: Stafford Horne <shorne@gmail.com>
Date: Tue, 9 Feb 2021 06:08:35 +0900
Subject: [OpenRISC] [PATCH v2] Use devicetree to determine present cpus
 (v2)
In-Reply-To: <9dc6c716-c5da-4214-96d8-e088db29d403@rwthex-s2-a.rwth-ad.de>
References: <9dc6c716-c5da-4214-96d8-e088db29d403@rwthex-s2-a.rwth-ad.de>
Message-ID: <20210208210835.GO2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Thanks Jan,

I was able to take these 2 mails and merge them together to a single patch.

I will send the result for review in a bit.

Next time please learn some git/linux kernel developer basics.  It will
help make this more smooth inthe future.  THe code changes you made were great
and I hope to see more in the future. :)

Some tips:
  - Use 'git rebase -i', and the fixup/squash command to merge two or more
    commits.  Also, there you should add the summary as you did in your mail
    in the git commit message.
  - Use 'git format-patch -o patch-dir -v2 <batch-base-commit-id>' to create
    your patch.
  - Use './scripts/checkpatch.pl patch-dir/<patch-name>.patch' to check your
    patch before you send it.  If any issues use 'git rebase' or 'git commit
   --amend' to fix up the checkpatch issues then test and create a new patch.
  - Use './scripts/get-maintainers.pl' with 'git send-email' like this below.

Some links:
  - https://www.kernel.org/doc/html/latest/process/submitting-patches.html
  - http://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/
    (explains --cc-cmd, you can also add --no-rolestats to .get_maintainer.conf`
  - https://thoughtbot.com/blog/git-interactive-rebase-squash-amend-rewriting-history
    (explain rebase squash fixup)


This is usually what I do after testing.

    $ git lo   # my custom alias: lo = log --pretty=format:'%C(yellow)%cd %C(green)%h %C(blue)%<(16)%aN%Creset %s %C(auto)%d%Creset' --decorate --date=short -n10
    2021-02-09 8f722f67452f Jan Henrik Weinstock openrisc: Use devicetree to determine present cpus  (HEAD -> or1k-5.12-updates)
    2021-01-25 2261352157a9 Stafford Horne   Merge remote-tracking branch 'openrisc/or1k-5.11-fixes' into or1k-5.12-updates  (shorne/or1k-5.12-updates, shorne/for-next, openrisc/for-next, for-next)
    2021-01-21 3706f9f76a4f Geert Uytterhoeven drivers/soc/litex: Add restart handler
    2021-01-20 031c7a8cd6fc Geert Uytterhoeven openrisc: io: Add missing __iomem annotation to iounmap()  (shorne/or1k-5.11-fixes, openrisc/or1k-5.11-fixes, or1k-5.11-fixes)
    2021-01-18 803c72c8547c Masahiro Yamada  openrisc: add arch/openrisc/Kbuild
    2021-01-14 4f70d150294b Gabriel Somlo    drivers/soc/litex: make 'litex_[set|get]_reg()' methods private
    2021-01-14 51f109228308 Gabriel Somlo    drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
    2021-01-14 ffa4ebc48971 Gabriel Somlo    drivers/soc/litex: s/LITEX_REG_SIZE/LITEX_SUBREG_ALIGN/g
    2021-01-14 b5d3061ea2e6 Gabriel Somlo    drivers/soc/litex: separate MMIO from subregister offset calculation
    2021-01-14 9d93a9e8aab3 Gabriel Somlo    drivers/soc/litex: move generic accessors to litex.h

    $ git format-patch -v3 -o patches/ 2261352157a9
    patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch

    # Below a warning is printed but I think its OK as we can use NR_CPUS in smp.c
    $ ./scripts/checkpatch.pl patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch
    WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
    #45: FILE: arch/openrisc/kernel/smp.c:73:
    +               if (cpu_id < NR_CPUS)

    total: 0 errors, 1 warnings, 45 lines checked

    NOTE: For some of the reported defects, checkpatch may be able to
	  mechanically convert to the typical style using --fix or --fix-inplace.

    patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch has style problems, please review.

    NOTE: If any of the errors are false positives, please report
	  them to the maintainer, see CHECKPATCH in MAINTAINERS.

    $ git send-email --to linux-kernel --cc-cmd ./scripts/get_maintainer.pl patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch
    patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch

-Stafford

On Mon, Feb 08, 2021@03:28:32PM +0100, Jan Henrik Weinstock wrote:
> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> ---
>  arch/openrisc/kernel/smp.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> index 75be7e34f..83cbf43d4 100644
> --- a/arch/openrisc/kernel/smp.c
> +++ b/arch/openrisc/kernel/smp.c
> @@ -61,32 +61,31 @@ void __init smp_prepare_boot_cpu(void)
>  
>  void __init smp_init_cpus(void)
>  {
> -	int i;
> +	struct device_node* cpu;
> +	u32 cpu_id;
> +
> +	for_each_of_cpu_node(cpu) {
> +		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> +			pr_warn("%s missing reg property", cpu->full_name);
> +			continue;
> +		}
>  
> -	for (i = 0; i < NR_CPUS; i++)
> -		set_cpu_possible(i, true);
> +		if (cpu_id < NR_CPUS)
> +			set_cpu_possible(cpu_id, true);
> +	}
>  }
>  
>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
> -	u32 cpu_id;
> -	struct device_node *cpu, *cpus;
> +	unsigned int cpu;
>  
>  	/*
>  	 * Initialise the present map, which describes the set of CPUs
>  	 * actually populated at the present time.
>  	 */
> -	cpus = of_find_node_by_path("/cpus");
> -	for_each_child_of_node(cpus, cpu) {
> -		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> -			pr_warn("%s missing reg property", cpu->full_name);
> -			continue;
> -		}
> -
> -		if (cpu_id >= max_cpus)
> -			continue;
> -
> -		set_cpu_present(cpu_id, true);
> +	for_each_possible_cpu(cpu) {
> +		if (cpu < max_cpus)
> +			set_cpu_present(cpu, true);
>  	}
>  }
>  
> -- 
> 2.17.1
> 
