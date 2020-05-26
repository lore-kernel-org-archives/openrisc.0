From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 26 May 2020 18:15:17 +0100
Subject: [OpenRISC] [PATCH v2 08/20] arm64: simplify detection of memory
 zone boundaries for UMA configs
In-Reply-To: <20200429121126.17989-9-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-9-rppt@kernel.org>
Message-ID: <20200526171516.GL17051@gaia>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Apr 29, 2020 at 03:11:14PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The free_area_init() function only requires the definition of maximal PFN
> for each of the supported zone rater than calculation of actual zone sizes
> and the sizes of the holes between the zones.
> 
> After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP the free_area_init() is
> available to all architectures.
> 
> Using this function instead of free_area_init_node() simplifies the zone
> detection.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(BTW, none of my acks so far made it to the linux-arm-kernel list
because of the large number of people on cc)
