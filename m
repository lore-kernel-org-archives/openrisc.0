From: Mike Stump <mikestump@comcast.net>
Date: Thu, 4 Oct 2018 12:13:46 -0700
Subject: [OpenRISC] [PATCH v2 2/3] or1k: testsuite: initial support for
	openrisc
In-Reply-To: <20181004034803.18066-3-shorne@gmail.com>
References: <20181004034803.18066-1-shorne@gmail.com>
 <20181004034803.18066-3-shorne@gmail.com>
Message-ID: <1EB47712-9C9A-49C6-A7DE-04C67A3853D4@comcast.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Oct 3, 2018, at 8:48 PM, Stafford Horne <shorne@gmail.com> wrote:
> 
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

Not sure this needs any extra review, but I did, so, Ok.

