From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 26 Sep 2018 11:25:29 +0200
Subject: [OpenRISC] [PATCH 05/30] mm: nobootmem: remove dead code
In-Reply-To: <1536927045-23536-6-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-6-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <20180926092529.GM6278@dhcp22.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri 14-09-18 15:10:20, Mike Rapoport wrote:
> Several bootmem functions and macros are not used. Remove them.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
