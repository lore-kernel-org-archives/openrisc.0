From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 26 Sep 2018 11:24:04 +0200
Subject: [OpenRISC] [PATCH 03/30] mm: remove CONFIG_HAVE_MEMBLOCK
In-Reply-To: <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <20180926092404.GL6278@dhcp22.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri 14-09-18 15:10:18, Mike Rapoport wrote:
> All architecures use memblock for early memory management. There is no need
> for the CONFIG_HAVE_MEMBLOCK configuration option.

git grep says
arch/csky/Kconfig:  select HAVE_MEMBLOCK

> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Other than that
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
