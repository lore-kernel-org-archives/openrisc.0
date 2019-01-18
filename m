From: Paul Burton <paul.burton@mips.com>
Date: Fri, 18 Jan 2019 17:53:36 +0000
Subject: [OpenRISC] [PATCH 12/21] arch: use memblock_alloc() instead of
 memblock_alloc_from(size, align, 0)
In-Reply-To: <1547646261-32535-13-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-13-git-send-email-rppt@linux.ibm.com>
Message-ID: <20190118175334.mj2mahbf4onhujgz@pburton-laptop>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Mike,

On Wed, Jan 16, 2019 at 03:44:12PM +0200, Mike Rapoport wrote:
> The last parameter of memblock_alloc_from() is the lower limit for the
> memory allocation. When it is 0, the call is equivalent to
> memblock_alloc().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Paul Burton <paul.burton@mips.com> # MIPS part

Thanks,
    Paul
