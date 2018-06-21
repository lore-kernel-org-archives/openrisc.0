From: Palmer Dabbelt <palmer@sifive.com>
Date: Thu, 21 Jun 2018 11:17:51 -0700
Subject: [OpenRISC] Finish the GENERIC_IRQ_MULTI_HANDLER conversion
Message-ID: <20180621181756.12493-1-palmer@sifive.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

A while ago I sent a patch set that adds a GENERIC_IRQ_MULTI_HANDLER,
which is an exact copy of the existing IRQ_MULTI_HANDLER support in the
arm port, which is being used unconditionally by arm64 and openrisc.
GENERIC_IRQ_MULTI_HANDLER is currently being used by the RISC-V port.  I
managed to make a few mistakes in my original patch set and as a result
my conversion of the other architectures of GENERIC_IRQ_MULTI_HANDLER
was dropped.

This patch set finishes up my original patch set by converting arm,
arm64, and openrisc over to the new GENERIC_IRQ_MULTI_HANDLER support
and then removing MULTI_IRQ_HANDLER as it's obselete.

At the time I wrote this I gave it fairly extensive build testing, but
went I recently rebased it I just tested the full patch set on arm,
arm64, and openrisc defconfigs.

Various flavors of this patch set have bounced around a few times
before, but I'm calling this a whole new patch set as it builds on top
of what was merged.
