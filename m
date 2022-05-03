From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Tue, 3 May 2022 10:54:41 +0200
Subject: [OpenRISC] [PATCH] target/openrisc: implement shutdown and
 reset helpers
In-Reply-To: <b1cf3942-115c-bca3-81cf-1f7bfd66dc5a@linaro.org>
References: <20220502225230.237369-1-Jason@zx2c4.com>
 <b1cf3942-115c-bca3-81cf-1f7bfd66dc5a@linaro.org>
Message-ID: <YnDt0YZK3aG3y8Tl@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, May 02, 2022 at 04:57:43PM -0700, Richard Henderson wrote:
> On 5/2/22 15:52, Jason A. Donenfeld wrote:
> > OpenRISC defines various nop instructions in or1k as meaning shutdown or
> > reset. Implement these in TCG. This has been tested with Linux and
> > confirmed to work.
> 
> No, OpenRISC does not define various nop instructions, etc.
> 
> OpenRISC defines a Power Management Register to handle doze and suspend; there is no 
> specification for shutdown or reset.
> 
> See https://openrisc.io/architecture


Stafford is in the process of documenting/spec'ing the nop stuff.

> 
> 
> r~
> 
