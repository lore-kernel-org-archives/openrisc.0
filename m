From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 May 2017 09:40:16 -0700
Subject: [OpenRISC] [PATCH] kthread: fix boot hang (regression) on
	MIPS/OpenRISC
In-Reply-To: <20170529072207.16130-1-vegard.nossum@oracle.com>
References: <20170529072207.16130-1-vegard.nossum@oracle.com>
Message-ID: <CA+55aFw4AmyMDbquM9Lm2yGT0pM07386ykLzdaO2X5zyMSSb3Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, May 29, 2017 at 12:22 AM, Vegard Nossum
<vegard.nossum@oracle.com> wrote:
> This fixes a regression in commit 4d6501dce079 where I didn't notice
> that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
> NULL after our initialisation in copy_process().

Ok, I'll just take this directly, since it's such an odd set of architectures.

I guess it could come in through the next "misc fixes" pull request
from the -tip tree (which is where the change that broke this came
from), but ..

             Linus
