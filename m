From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 26 Sep 2018 11:22:39 +0200
Subject: [OpenRISC] [PATCH 02/30] mm: remove CONFIG_NO_BOOTMEM
In-Reply-To: <1536927045-23536-3-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-3-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <20180926092239.GK6278@dhcp22.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri 14-09-18 15:10:17, Mike Rapoport wrote:
> All achitectures select NO_BOOTMEM which essentially becomes 'Y' for any
> kernel configuration and therefore it can be removed.

git grep suggests that DEFERRED_STRUCT_PAGE_INIT still depends on
NO_BOOTMEM but I have a vague feeling that I've seen a patch to address
that. It would be great to have it folded to this one.

> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
