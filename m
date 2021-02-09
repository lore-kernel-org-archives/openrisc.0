From: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Date: Tue, 9 Feb 2021 10:42:44 +0100
Subject: [OpenRISC] [PATCH v2] Use devicetree to determine present cpus
 (v2)
In-Reply-To: <20210208210835.GO2002709@lianli.shorne-pla.net>
References: <9dc6c716-c5da-4214-96d8-e088db29d403@rwthex-s2-a.rwth-ad.de>
 <20210208210835.GO2002709@lianli.shorne-pla.net>
Message-ID: <f033a204-a907-71b8-dd32-faad9b2df768@rwth-aachen.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

thanks for cleaning up the patch and for your feedback! I will surely 
take it into account in the future.

Gruss
Jan

On 08/02/2021 22:08, Stafford Horne wrote:
> Thanks Jan,
> 
> I was able to take these 2 mails and merge them together to a single patch.
> 
> I will send the result for review in a bit.
> 
> Next time please learn some git/linux kernel developer basics.  It will
> help make this more smooth inthe future.  THe code changes you made were great
> and I hope to see more in the future. :)
> 
> Some tips:
>    - Use 'git rebase -i', and the fixup/squash command to merge two or more
>      commits.  Also, there you should add the summary as you did in your mail
>      in the git commit message.
>    - Use 'git format-patch -o patch-dir -v2 <batch-base-commit-id>' to create
>      your patch.
>    - Use './scripts/checkpatch.pl patch-dir/<patch-name>.patch' to check your
>      patch before you send it.  If any issues use 'git rebase' or 'git commit
>     --amend' to fix up the checkpatch issues then test and create a new patch.
>    - Use './scripts/get-maintainers.pl' with 'git send-email' like this below.
> 
> Some links:
>    - https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>    - http://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/
>      (explains --cc-cmd, you can also add --no-rolestats to .get_maintainer.conf`
>    - https://thoughtbot.com/blog/git-interactive-rebase-squash-amend-rewriting-history
>      (explain rebase squash fixup)
> 
> 
> This is usually what I do after testing.
> 
>      $ git lo   # my custom alias: lo = log --pretty=format:'%C(yellow)%cd %C(green)%h %C(blue)%<(16)%aN%Creset %s %C(auto)%d%Creset' --decorate --date=short -n10
>      2021-02-09 8f722f67452f Jan Henrik Weinstock openrisc: Use devicetree to determine present cpus  (HEAD -> or1k-5.12-updates)
>      2021-01-25 2261352157a9 Stafford Horne   Merge remote-tracking branch 'openrisc/or1k-5.11-fixes' into or1k-5.12-updates  (shorne/or1k-5.12-updates, shorne/for-next, openrisc/for-next, for-next)
>      2021-01-21 3706f9f76a4f Geert Uytterhoeven drivers/soc/litex: Add restart handler
>      2021-01-20 031c7a8cd6fc Geert Uytterhoeven openrisc: io: Add missing __iomem annotation to iounmap()  (shorne/or1k-5.11-fixes, openrisc/or1k-5.11-fixes, or1k-5.11-fixes)
>      2021-01-18 803c72c8547c Masahiro Yamada  openrisc: add arch/openrisc/Kbuild
>      2021-01-14 4f70d150294b Gabriel Somlo    drivers/soc/litex: make 'litex_[set|get]_reg()' methods private
>      2021-01-14 51f109228308 Gabriel Somlo    drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
>      2021-01-14 ffa4ebc48971 Gabriel Somlo    drivers/soc/litex: s/LITEX_REG_SIZE/LITEX_SUBREG_ALIGN/g
>      2021-01-14 b5d3061ea2e6 Gabriel Somlo    drivers/soc/litex: separate MMIO from subregister offset calculation
>      2021-01-14 9d93a9e8aab3 Gabriel Somlo    drivers/soc/litex: move generic accessors to litex.h
> 
>      $ git format-patch -v3 -o patches/ 2261352157a9
>      patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch
> 
>      # Below a warning is printed but I think its OK as we can use NR_CPUS in smp.c
>      $ ./scripts/checkpatch.pl patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch
>      WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
>      #45: FILE: arch/openrisc/kernel/smp.c:73:
>      +               if (cpu_id < NR_CPUS)
> 
>      total: 0 errors, 1 warnings, 45 lines checked
> 
>      NOTE: For some of the reported defects, checkpatch may be able to
> 	  mechanically convert to the typical style using --fix or --fix-inplace.
> 
>      patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch has style problems, please review.
> 
>      NOTE: If any of the errors are false positives, please report
> 	  them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
>      $ git send-email --to linux-kernel --cc-cmd ./scripts/get_maintainer.pl patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch
>      patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.patch
> 
> -Stafford

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5316 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210209/037a0605/attachment.bin>
