From: Stafford Horne <shorne@gmail.com>
Date: Sun, 28 Jun 2020 06:23:35 +0900
Subject: [OpenRISC] [PATCH 2/8] opeinrisc: switch to generic version of
 pte allocation
In-Reply-To: <20200627143453.31835-3-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627143453.31835-3-rppt@kernel.org>
Message-ID: <20200627212335.GJ1401039@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Jun 27, 2020 at 05:34:47PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Replace pte_alloc_one(), pte_free() and pte_free_kernel() with the generic
> implementation. The only actual functional change is the addition of
> __GFP_ACCOUT for the allocation of the user page tables.
> 
> The pte_alloc_one_kernel() is kept back because its implementation on
> openrisc is different than the generic one.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Thank's for this.

Acked-by: Stafford Horne <shorne@gmail.com>
