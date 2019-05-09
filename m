From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Thu, 09 May 2019 19:44:15 +0200
Subject: [OpenRISC] [PATCH 1/2] or1k: Fix code quality for volatile
 memory loads
In-Reply-To: <20190506131621.29929-2-shorne@gmail.com>
References: <20190506131621.29929-1-shorne@gmail.com>
 <20190506131621.29929-2-shorne@gmail.com>
Message-ID: <FF41D424-46AF-4A74-BB13-2E7A3DA4924E@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 6 May 2019 15:16:20 CEST, Stafford Horne <shorne@gmail.com> wrote:
>Volatile memory does not match the memory_operand predicate.  This
>causes extra extend/mask instructions instructions when reading
>from volatile memory.  On OpenRISC loading volitile memory can be

s/volitile/volatile/g

also at least in the test.
Thanks,


>diff --git a/gcc/testsuite/gcc.target/or1k/swap-2.c
>b/gcc/testsuite/gcc.target/or1k/swap-2.c
>new file mode 100644
>index 00000000000..8ddea4e659f
>--- /dev/null
>+++ b/gcc/testsuite/gcc.target/or1k/swap-2.c

>+/* Check to ensure the volitile load does not get zero extended.  */

