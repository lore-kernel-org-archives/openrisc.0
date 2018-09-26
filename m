From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Wed, 26 Sep 2018 14:54:05 +0300
Subject: [OpenRISC] [PATCH 03/30] mm: remove CONFIG_HAVE_MEMBLOCK
In-Reply-To: <20180926092404.GL6278@dhcp22.suse.cz>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
 <20180926092404.GL6278@dhcp22.suse.cz>
Message-ID: <20180926115404.GE4628@rapoport-lnx>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Sep 26, 2018 at 11:24:04AM +0200, Michal Hocko wrote:
> On Fri 14-09-18 15:10:18, Mike Rapoport wrote:
> > All architecures use memblock for early memory management. There is no need
> > for the CONFIG_HAVE_MEMBLOCK configuration option.
> 
> git grep says
> arch/csky/Kconfig:  select HAVE_MEMBLOCK
 
Not only that, there are other bootmem leftovers in csky.
I've sent the patch with the necessary fixups [1]

[1] https://lkml.kernel.org/lkml/20180926112744.GC4628 at rapoport-lnx/

> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Other than that
> Acked-by: Michal Hocko <mhocko@suse.com>
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

