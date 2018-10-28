From: Richard Henderson <rth@twiddle.net>
Date: Sun, 28 Oct 2018 01:27:39 +0000
Subject: [OpenRISC] [PATCH v3 2/3] or1k: testsuite: initial support for
	openrisc
In-Reply-To: <20181027043702.18414-3-shorne@gmail.com>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-3-shorne@gmail.com>
Message-ID: <f49de9a1-f73c-53ea-0206-3b0edbf738b3@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/27/18 5:37 AM, Stafford Horne wrote:
> yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
> 	    Richard Henderson  <rth@twiddle.net>
> 
> gcc/testsuite/ChangeLog:
> 
> 	* gcc.c-torture/execute/20101011-1.c: Adjust for OpenRISC.
> 	* gcc.dg/20020312-2.c: Likewise.
> 	* gcc.dg/attr-alloc_size-11.c: Likewise.
> 	* gcc.dg/builtin-apply2.c: Likewise.
> 	* gcc.dg/nop.h: Likewise.
> 	* gcc.dg/torture/stackalign/builtin-apply-2.c: Likewise.
> 	* gcc.dg/tree-ssa/20040204-1.c: Likewise.
> 	* gcc.dg/tree-ssa/reassoc-33.c: Likewise.
> 	* gcc.dg/tree-ssa/reassoc-34.c: Likewise.
> 	* gcc.dg/tree-ssa/reassoc-35.c: Likewise.
> 	* gcc.dg/tree-ssa/reassoc-36.c: Likewise.
> 	* lib/target-supports.exp
> 	(check_effective_target_logical_op_short_circuit): Add or1k*-*-*.
> 	* gcc.target/or1k/*: New.
> ---

Ok.


r~
