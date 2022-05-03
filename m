From: Stafford Horne <shorne@gmail.com>
Date: Tue, 3 May 2022 18:14:16 +0900
Subject: [OpenRISC] [PATCH] target/openrisc: implement shutdown and
 reset helpers
In-Reply-To: <YnDt0YZK3aG3y8Tl@zx2c4.com>
References: <20220502225230.237369-1-Jason@zx2c4.com>
 <b1cf3942-115c-bca3-81cf-1f7bfd66dc5a@linaro.org>
 <YnDt0YZK3aG3y8Tl@zx2c4.com>
Message-ID: <YnDyaEW2QiUXTNx8@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 03, 2022 at 10:54:41AM +0200, Jason A. Donenfeld wrote:
> On Mon, May 02, 2022 at 04:57:43PM -0700, Richard Henderson wrote:
> > On 5/2/22 15:52, Jason A. Donenfeld wrote:
> > > OpenRISC defines various nop instructions in or1k as meaning shutdown or
> > > reset. Implement these in TCG. This has been tested with Linux and
> > > confirmed to work.
> > 
> > No, OpenRISC does not define various nop instructions, etc.
> > 
> > OpenRISC defines a Power Management Register to handle doze and suspend; there is no 
> > specification for shutdown or reset.
> > 
> > See https://openrisc.io/architecture
> 
> 
> Stafford is in the process of documenting/spec'ing the nop stuff.

Hi Richard,

Yes, we had a mail discussion about this with Peter.  This being similar to ARM
semihosting; enabling these special instructions should be behind the semihosting
flag.  Something that needs to be done for this patch.

If you have concern about this let me now.

Mail:
  - https://www.mail-archive.com/qemu-devel at nongnu.org/msg884560.html

Our other simulators implement this, so the compromise is if we document this
officially and only implement it behind semihosting peter was OK with it.

I haven't started on the documentation yet as I haven't has much time in the
last few days though.

Or1ksim:
  - https://github.com/openrisc/or1ksim/blob/79c6f153390127e50259d46a7cc0421aa787d2ed/cpu/or32/insnset.c#L768
sim:
  - https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=sim/or1k/or1k.c;h=bfab35461bee1457fe8f42179ac6d27f5ad46b96;hb=HEAD

-Stafford
