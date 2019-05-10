From: Stafford Horne <shorne@gmail.com>
Date: Sat, 11 May 2019 06:35:05 +0900
Subject: [OpenRISC] [PATCH 1/2] or1k: Fix code quality for volatile
 memory loads
In-Reply-To: <FF41D424-46AF-4A74-BB13-2E7A3DA4924E@gmail.com>
References: <20190506131621.29929-1-shorne@gmail.com>
 <20190506131621.29929-2-shorne@gmail.com>
 <FF41D424-46AF-4A74-BB13-2E7A3DA4924E@gmail.com>
Message-ID: <20190510213505.GH11006@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, May 09, 2019 at 07:44:15PM +0200, Bernhard Reutner-Fischer wrote:
> On 6 May 2019 15:16:20 CEST, Stafford Horne <shorne@gmail.com> wrote:
> >Volatile memory does not match the memory_operand predicate.  This
> >causes extra extend/mask instructions instructions when reading
> >from volatile memory.  On OpenRISC loading volitile memory can be
> 
> s/volitile/volatile/g
> 
> also at least in the test.
> Thanks,

Thank you,

I always mispell that one.

-Stafford

> 
> >diff --git a/gcc/testsuite/gcc.target/or1k/swap-2.c
> >b/gcc/testsuite/gcc.target/or1k/swap-2.c
> >new file mode 100644
> >index 00000000000..8ddea4e659f
> >--- /dev/null
> >+++ b/gcc/testsuite/gcc.target/or1k/swap-2.c
> 
> >+/* Check to ensure the volitile load does not get zero extended.  */
> 
