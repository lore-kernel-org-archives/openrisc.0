From: Stafford Horne <shorne@gmail.com>
Date: Wed, 11 Dec 2019 20:44:15 +0900
Subject: [OpenRISC] [PATCH 2/2] or1k: Regnerate opcode files after
 removing 64-bit support
In-Reply-To: <20191210214906.21465-3-shorne@gmail.com>
References: <20191210214906.21465-1-shorne@gmail.com>
 <20191210214906.21465-3-shorne@gmail.com>
Message-ID: <20191211114415.GR24874@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Note subject will be updated to spell Regenerate correctly.

-Stafford

On Wed, Dec 11, 2019 at 06:49:06AM +0900, Stafford Horne wrote:
> opcodes/ChangeLog:
> 
> yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
> 
> 	* or1k-asm.c: Regenerate.
> 	* or1k-desc.c: Regenerate.
> 	* or1k-desc.h: Regenerate.
> 	* or1k-dis.c: Regenerate.
> 	* or1k-ibld.c: Regenerate.
> 	* or1k-opc.c: Regenerate.
> 	* or1k-opc.h: Regenerate.
> 	* or1k-opinst.c: Regenerate.
> ---
>  opcodes/or1k-asm.c    |    9 -
>  opcodes/or1k-desc.c   | 1811 +++++++++++++++++++----------------------
>  opcodes/or1k-desc.h   |  332 ++++----
>  opcodes/or1k-dis.c    |    9 -
>  opcodes/or1k-ibld.c   |   60 +-
>  opcodes/or1k-opc.c    |  152 ----
>  opcodes/or1k-opc.h    |   28 +-
>  opcodes/or1k-opinst.c |  428 +++++-----
>  8 files changed, 1182 insertions(+), 1647 deletions(-)
> 
 
