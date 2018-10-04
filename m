From: Nick Clifton <nickc@redhat.com>
Date: Thu, 4 Oct 2018 16:34:04 +0100
Subject: [OpenRISC] [PATCH v3 4/5] or1k: Add the l.muld, l.muldu, l.macu,
 l.msbu insns
In-Reply-To: <20181004032317.17478-5-shorne@gmail.com>
References: <20181004032317.17478-1-shorne@gmail.com>
 <20181004032317.17478-5-shorne@gmail.com>
Message-ID: <01ed0f00-6278-6157-6002-30478cd47e1d@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

> yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>
> 	    Stafford Horne  <shorne@gmail.com>
> 
> cpu/ChangeLog:
> 
> 	* or1korbis.cpu (insn-opcode-mac): Add opcodes for MACU and MSBU.
> 	(insn-opcode-alu-regreg): Add opcodes for MULD and MULDU.
> 	(l-mul): Fix overflow support and indentation.
> 	(l-mulu): Fix overflow support and indentation.
> 	(l-muld, l-muldu, l-msbu, l-macu): New instructions.
> 	(l-div); Remove incorrect carry behavior.
> 	(l-divu): Fix carry and overflow behavior.
> 	(l-mac): Add overflow support.
> 	(l-msb, l-msbu): Add carry and overflow support.
> 
> opcodes/ChangeLog:
> 
> 	* or1k-desc.c: Regenerate.
> 	* or1k-desc.h: Regenerate.
> 	* or1k-opc.c: Regenerate.
> 	* or1k-opc.h: Regenerate.
> 	* or1k-opinst.c: Regenerate.
> 
> sim/common/ChangeLog:
> 
> 	* cgen-ops.h (ADDCFDI): New function, add carry flag DI variant.
> 	(ADDOFDI): New function, add overflow flag DI variant.
> 	(SUBCFDI): New function, subtract carry flag DI variant.
> 	(SUBOFDI): New function, subtract overflow flag DI variant.
> 
> sim/or1k/ChangeLog:
> 
> 	* or1k/cpu.h: Regenerate.
> 	* or1k/decode.c: Regenerate.
> 	* or1k/decode.h: Regenerate.
> 	* or1k/model.c: Regenerate.
> 	* or1k/sem-switch.c: Regenerate.
> 	* or1k/sem.c: Regenerate:
> 
> sim/testsuite/sim/or1k/ChangeLog:
> 
> 	* div.S: Fix tests to match correct overflow/carry semantics.
> 	* mul.S: Likewise.
> 
> yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
> 
> gas/ChangeLog:
> 
> 	* testsuite/gas/or1k/allinsn.s: Add instruction tests for
> 	l.muld, l.muldu, l.macu, l.msb, l.msbu.
> 	* testsuite/gas/or1k/allinsn.d: Add test results for new
> 	instructions. 

Approved.

Cheers
  Nick

