From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 1 Jul 2018 07:19:37 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH] target/openrisc: Fix delay slot
 exception flag to match spec
In-Reply-To: <20180701051147.31649-1-shorne@gmail.com>
References: <20180701051147.31649-1-shorne@gmail.com>
Message-ID: <99a76cbb-c711-70f2-75db-a966259438ff@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 06/30/2018 10:11 PM, Stafford Horne wrote:
> The delay slot exception flag is only set on the SR register during
> exception.  Previously it was being set on both the ESR and SR this
> caused QEMU to differ from the spec.  The was apparent as the linux
> kernel had a bug where it could boot on QEMU but not on real hardware.
> 
> The fixed logic now matches hardware.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  target/openrisc/interrupt.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
