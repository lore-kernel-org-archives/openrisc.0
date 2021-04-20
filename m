From: Jeff Law <jeffreyalaw@gmail.com>
Date: Tue, 20 Apr 2021 17:20:39 -0600
Subject: [OpenRISC] [PATCH] or1k: Add mcmodel option to handle large GOTs
In-Reply-To: <20210419001034.3626375-1-shorne@gmail.com>
References: <20210419001034.3626375-1-shorne@gmail.com>
Message-ID: <9b45b7ef-fce1-84dc-3a86-76801b26de08@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


On 4/18/2021 6:10 PM, Stafford Horne via Gcc-patches wrote:
> When building libgeos we get an error with:
>
>      linux-uclibc/9.3.0/crtbeginS.o: in function `__do_global_dtors_aux':
>      crtstuff.c:(.text+0x118): relocation truncated to fit: R_OR1K_GOT16 against symbol `__cxa_finalize' defined in .text section in
>      /home/shorne/work/openrisc/3eb9f9d0f6d8274b2d19753c006bd83f7d536e3c/output/host/or1k-buildroot-linux-uclibc/sysroot/lib/libc.so.
>
> This is caused by GOT code having a limit of 64k.  In OpenRISC this
> looks to be the only relocation code pattern to be limited to 64k.
>
> This patch allows specifying a new option -mcmodel=large which can be
> used to generate 2 more instructions to construct 32-bit addresses for
> up to 4G GOTs.
>
> gcc/ChangeLog:
>
> 	PR 99783
> 	* config/or1k/or1k-opts.h: New file.
> 	* config/or1k/or1k.c (or1k_legitimize_address_1, print_reloc):
> 	Support generating gotha relocations if -mcmodel=large is
> 	specified.
> 	* config/or1k/or1k.h (TARGET_CMODEL_SMALL, TARGET_CMODEL_LARGE):
> 	New macros.
> 	* config/or1k/or1k.opt (mcmodel=): New option.
> 	* doc/invoke.text (OpenRISC Options): Document mcmodel.

Note you're the port maintainer, so you don't need approval to commit 
this to GCC.

Jeff

