From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 12 Oct 2017 14:28:47 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH 5/5] openrisc: Only kick cpu on
 timeout, not on update
In-Reply-To: <5bbe0752efa40ad6fe397a344967ee0b93394392.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
 <5bbe0752efa40ad6fe397a344967ee0b93394392.1503467674.git.shorne@gmail.com>
Message-ID: <f89d1cc0-51f8-3403-fb33-82f993cd59f2@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/22/2017 10:57 PM, Stafford Horne wrote:
> Previously we were kicking the cpu on every update.  This caused
> problems noticeable in SMP configurations where one CPU got pinned
> continuously servicing timer exceptions.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  hw/openrisc/cputimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

