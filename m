From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 2 May 2022 16:57:43 -0700
Subject: [OpenRISC] [PATCH] target/openrisc: implement shutdown and
 reset helpers
In-Reply-To: <20220502225230.237369-1-Jason@zx2c4.com>
References: <20220502225230.237369-1-Jason@zx2c4.com>
Message-ID: <b1cf3942-115c-bca3-81cf-1f7bfd66dc5a@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 5/2/22 15:52, Jason A. Donenfeld wrote:
> OpenRISC defines various nop instructions in or1k as meaning shutdown or
> reset. Implement these in TCG. This has been tested with Linux and
> confirmed to work.

No, OpenRISC does not define various nop instructions, etc.

OpenRISC defines a Power Management Register to handle doze and suspend; there is no 
specification for shutdown or reset.

See https://openrisc.io/architecture


r~
