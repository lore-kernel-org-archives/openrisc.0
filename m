From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Apr 2017 00:52:52 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH 2/7] target/openrisc: add
	shutdown logic
In-Reply-To: <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
 <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
Message-ID: <6914f9b7-ece1-973d-2210-871b71319ae0@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 04/16/2017 04:23 PM, Stafford Horne wrote:
> In openrisc simulators we use hooks like 'l.nop 1' to cause the
> simulator to exit.  Implement that for qemu too.
>
> Reported-by: Waldemar Brodkorb <wbx@openadk.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

As I said the first time this was posted: This is horrible.

If you want to do something like this, it needs to be buried under a special 
run mode like -semihosting.

>          case 0x01:    /* l.nop */
>              LOG_DIS("l.nop %d\n", I16);
> +            {
> +                TCGv_i32 arg = tcg_const_i32(I16);
> +                gen_helper_nop(arg);
> +            }

You also really really must special-case l.nop 0 so that it doesn't generate a 
function call.  Just think of all the extra calls you're adding for every delay 
slot that couldn't be filled.


r~
