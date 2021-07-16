From: Nick Clifton <nickc@redhat.com>
Date: Fri, 16 Jul 2021 15:04:39 +0100
Subject: [OpenRISC] [PATCH] or1k: fix pc-relative relocation against
 dynamic on PC relative 26 bit relocation
In-Reply-To: <20210712103256.2275617-1-giulio.benetti@benettiengineering.com>
References: <20210712103256.2275617-1-giulio.benetti@benettiengineering.com>
Message-ID: <2c9bcabe-99d0-c305-26aa-08fee85654d3@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Giulio,

>         use a separate entry
> 	  in switch case R_OR1K_INSN_REL_26 where we need to check for
> 	  !SYMBOL_CALLS_LOCAL() instead of !SYMBOL_REFERENCES_LOCAL().

Patch approved and applied.  Thanks for reporting and fixing this problem.

Cheers
   Nick

