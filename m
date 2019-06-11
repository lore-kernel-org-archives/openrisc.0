From: Andrew Burgess <andrew.burgess@embecosm.com>
Date: Tue, 11 Jun 2019 22:48:11 +0100
Subject: [OpenRISC] [PATCH v3 10/11] sim/testsuite/or1k: Add test case
 for l.adrp instruction
In-Reply-To: <20190610204940.3846-1-shorne@gmail.com>
References: <20190610204940.3846-1-shorne@gmail.com>
Message-ID: <20190611214811.GS23204@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

* Stafford Horne <shorne@gmail.com> [2019-06-11 05:49:39 +0900]:

> This is a simple test to ensure that the l.adrp instruction can be assembled and
> simulated correctly.
> 
> sim/testsuite/sim/or1k/ChangeLog:
> 
> yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
> 
> 	* adrp.S: New file.

This is fine with one nit below.

Thanks,
Andrew


> ---
> Changes since v2:
>  - new patch
> 
>  sim/testsuite/sim/or1k/adrp.S | 73 +++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 sim/testsuite/sim/or1k/adrp.S
> 
> diff --git a/sim/testsuite/sim/or1k/adrp.S b/sim/testsuite/sim/or1k/adrp.S
> new file mode 100644
> index 0000000000..ba384ccc84
> --- /dev/null
> +++ b/sim/testsuite/sim/or1k/adrp.S
> @@ -0,0 +1,73 @@
> +/* Tests the load page address instruction.
> +
> +   Copyright (C) 2017-2019 Free Software Foundation, Inc.

This date range should just be '2019'.

> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License as published by
> +   the Free Software Foundation; either version 3 of the License, or
> +   (at your option) any later version.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +
> +   You should have received a copy of the GNU General Public License
> +   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
> +
> +# mach: or1k
> +# output: report(0x00002064);\n
> +# output: report(0x00012138);\n
> +# output: report(0x00002000);\n
> +# output: report(0x00012000);\n
> +# output: report(0x00002000);\n
> +# output: report(0x00014000);\n
> +# output: report(0x00000000);\n
> +# output: exit(0)\n
> +
> +#include "or1k-asm-test-helpers.h"
> +
> +	STANDARD_TEST_ENVIRONMENT
> +
> +	.section .data
> +	.org 0x10000
> +	.align 4
> +	.type   pi, @object
> +	.size   pi, 4
> +pi:
> +	.float	3.14159
> +
> +	.section .text
> +start_tests:
> +	PUSH LINK_REGISTER_R9
> +
> +	/* Print out the PC.  To compare with that loaded by l.adrp.  */
> +	l.jal	capture_pc
> +	 l.nop
> +capture_pc:
> +	REPORT_REG_TO_CONSOLE r9
> +
> +	/* Print out our data address to compared with l.adrp offset.  */
> +	l.movhi	r11, ha(pi)
> +	l.addi	r11, r11, lo(pi)
> +	REPORT_REG_TO_CONSOLE r11
> +
> +	/* Test l.adrp with symbols, loads page of symbol to register.  */
> +	l.adrp	r4, start_tests
> +	REPORT_REG_TO_CONSOLE r4
> +
> +	l.adrp	r4, pi
> +	REPORT_REG_TO_CONSOLE r4
> +
> +	/* Test l.adrp with immediate, immediate is the page offset.  */
> +	l.adrp	r4, 0x0
> +	REPORT_REG_TO_CONSOLE r4
> +
> +	l.adrp	r4, 0x12000
> +	REPORT_REG_TO_CONSOLE r4
> +
> +	l.adrp	r4, -0x2000
> +	REPORT_REG_TO_CONSOLE r4
> +
> +	POP LINK_REGISTER_R9
> +	RETURN_TO_LINK_REGISTER_R9
> -- 
> 2.21.0
> 
