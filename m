From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 2 May 2022 16:59:47 -0700
Subject: [OpenRISC] [PATCH] hw/openrisc: use right OMPIC size variable
In-Reply-To: <20220502232800.259036-1-Jason@zx2c4.com>
References: <20220502232800.259036-1-Jason@zx2c4.com>
Message-ID: <c6d3a823-b9a4-411a-b4b8-5fb1f1c9c214@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 5/2/22 16:28, Jason A. Donenfeld wrote:
> This appears to be a copy and paste error. The UART size was used
> instead of the much smaller OMPIC size.
> 
> Signed-off-by: Jason A. Donenfeld<Jason@zx2c4.com>
> ---
>   hw/openrisc/openrisc_sim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
