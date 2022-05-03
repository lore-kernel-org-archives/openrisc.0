From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 3 May 2022 07:46:19 -0700
Subject: [OpenRISC] [PATCH] target/openrisc: implement shutdown and
 reset helpers
In-Reply-To: <YnDyaEW2QiUXTNx8@antec>
References: <20220502225230.237369-1-Jason@zx2c4.com>
 <b1cf3942-115c-bca3-81cf-1f7bfd66dc5a@linaro.org>
 <YnDt0YZK3aG3y8Tl@zx2c4.com> <YnDyaEW2QiUXTNx8@antec>
Message-ID: <0eef40cc-47e0-6670-2b5d-b97026308ce6@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 5/3/22 02:14, Stafford Horne wrote:
> Yes, we had a mail discussion about this with Peter.  This being similar to ARM
> semihosting; enabling these special instructions should be behind the semihosting
> flag.  Something that needs to be done for this patch.

Ah, ok.

> Our other simulators implement this, so the compromise is if we document this
> officially and only implement it behind semihosting peter was OK with it.
> 
> I haven't started on the documentation yet as I haven't has much time in the
> last few days though.
> 
> Or1ksim:
>    - https://github.com/openrisc/or1ksim/blob/79c6f153390127e50259d46a7cc0421aa787d2ed/cpu/or32/insnset.c#L768
> sim:
>    - https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=sim/or1k/or1k.c;h=bfab35461bee1457fe8f42179ac6d27f5ad46b96;hb=HEAD

Thanks for the pointers.


r~
