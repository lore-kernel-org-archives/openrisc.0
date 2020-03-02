From: Helge Deller <deller@gmx.de>
Date: Mon, 2 Mar 2020 12:19:28 +0100
Subject: [OpenRISC] [PATCH] mm/special: Create generic fallbacks for
 pte_special() and pte_mkspecial()
In-Reply-To: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <c026934a-02c1-8589-f925-e267fcc367ad@gmx.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 02.03.20 02:56, Anshuman Khandual wrote:
> Currently there are many platforms that dont enable HAVE_ARCH_PTE_SPECIAL
> but required to define quite similar fallback stubs for special page table
> entry helpers such as pte_special() and pte_mkspecial(), as they get build
> in generic MM without a config check. This creates two generic fallback
> stub definitions for these helpers, eliminating much code duplication.
>
> mips platform has a special case where pte_special() and pte_mkspecial()
> visibility is wider than what HAVE_ARCH_PTE_SPECIAL enablement requires.
> This restricts those symbol visibility in order to avoid redefinitions
> which is now exposed through this new generic stubs and subsequent build
> failure. arm platform set_pte_at() definition needs to be moved into a C
> file just to prevent a build failure.
>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

for parisc:

Acked-by: Helge Deller <deller@gmx.de> # parisc

Helge
