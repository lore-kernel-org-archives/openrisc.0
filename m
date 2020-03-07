From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 6 Mar 2020 20:00:16 -0800
Subject: [OpenRISC] [PATCH v3 07/14] powerpc/32: drop get_pteptr()
In-Reply-To: <20200227084608.18223-8-rppt@kernel.org>
References: <20200227084608.18223-1-rppt@kernel.org>
 <20200227084608.18223-8-rppt@kernel.org>
Message-ID: <20200306200016.6f3865ada0daa68b645fe5d7@linux-foundation.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, 27 Feb 2020 10:46:01 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Commit 8d30c14cab30 ("powerpc/mm: Rework I$/D$ coherency (v3)") and
> commit 90ac19a8b21b ("[POWERPC] Abolish iopa(), mm_ptov(),
> io_block_mapping() from arch/powerpc") removed the use of get_pteptr()
> outside of mm/pgtable_32.c
> 
> In mm/pgtable_32.c, the only user of get_pteptr() is __change_page_attr()
> which operates on kernel context and on lowmem pages only.
> 
> Move page table traversal to __change_page_attr() and drop get_pteptr().

People have been changing things in linux-next and the powerpc patches
are hurting.

I'll disable this patch series for now.  Can you please redo
powerpc-32-drop-get_pteptr.patch and
powerpc-add-support-for-folded-p4d-page-tables.patch (and
powerpc-add-support-for-folded-p4d-page-tables-fix.patch)?

Thanks.

