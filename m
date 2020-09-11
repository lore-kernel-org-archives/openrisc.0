From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Fri, 11 Sep 2020 22:55:26 +0200
Subject: [OpenRISC] [PATCH v3 3/3] openrisc: Fix issue with get_user for
 64-bit values
In-Reply-To: <20200910233940.2132107-4-shorne@gmail.com>
References: <20200910233940.2132107-1-shorne@gmail.com>
 <20200910233940.2132107-4-shorne@gmail.com>
Message-ID: <20200911205526.65llro2gnh7zlsu4@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Sep 11, 2020 at 08:39:40AM +0900, Stafford Horne wrote:
> A build failure was raised by kbuild with the following error.
> 
>     drivers/android/binder.c: Assembler messages:
>     drivers/android/binder.c:3861: Error: unrecognized keyword/register name `l.lwz ?ap,4(r24)'
>     drivers/android/binder.c:3866: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'
> 
> The issue is with 64-bit get_user() calls on openrisc.  I traced this to
> a problem where in the internally in the get_user macros there is a cast
> to long __gu_val this causes GCC to think the get_user call is 32-bit.
> This binder code is really long and GCC allocates register r30, which
> triggers the issue. The 64-bit get_user asm tries to get the 64-bit pair
> register, which for r30 overflows the general register names and returns
> the dummy register ?ap.
> 
> The fix here is to move the temporary variables into the asm macros.  We
> use a 32-bit __gu_tmp for 32-bit and smaller macro and a 64-bit tmp in
> the 64-bit macro.  The cast in the 64-bit macro has a trick of casting
> through __typeof__((x)-(x)) which avoids the below warning.  This was
> barrowed from riscv.
> 
>     arch/openrisc/include/asm/uaccess.h:240:8: warning: cast to pointer from integer of different size
> 
> I tested this is a small unit test to check reading between 64-bit and
> 32-bit pointers to 64-bit and 32-bit values in all combinations.  Also I
> ran make C=1 to confirm no new sparse warnings came up.  It all looks
> clean to me.

It looks correct to me too now at C & assembly level.
Feel free to add my:
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

-- Luc
