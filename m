From: Oleg Nesterov <oleg@redhat.com>
Date: Mon, 29 May 2017 18:18:50 +0200
Subject: [OpenRISC] [PATCH] kthread: fix boot hang (regression) on
	MIPS/OpenRISC
In-Reply-To: <20170529072207.16130-1-vegard.nossum@oracle.com>
References: <20170529072207.16130-1-vegard.nossum@oracle.com>
Message-ID: <20170529161850.GA15236@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 05/29, Vegard Nossum wrote:
>
> This fixes a regression in commit 4d6501dce079 where I didn't notice
> that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
> NULL after our initialisation in copy_process().

Oh, I didn't even know that arch/ can play with xxx_child_tid,

> We can simply get rid of the arch-specific initialisation here

Agreed. Thanks!

Acked-by: Oleg Nesterov <oleg@redhat.com>

