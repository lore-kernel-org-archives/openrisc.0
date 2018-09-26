From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 26 Sep 2018 11:38:46 +0200
Subject: [OpenRISC] [PATCH 29/30] mm: remove include/linux/bootmem.h
In-Reply-To: <1536927045-23536-30-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-30-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <20180926093846.GS6278@dhcp22.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri 14-09-18 15:10:44, Mike Rapoport wrote:
> Move remaining definitions and declarations from include/linux/bootmem.h
> into include/linux/memblock.h and remove the redundant header.
> 
> The includes were replaced with the semantic patch below and then
> semi-automated removal of duplicated '#include <linux/memblock.h>
> 
> @@
> @@
> - #include <linux/bootmem.h>
> + #include <linux/memblock.h>
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
