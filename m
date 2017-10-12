From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 12 Oct 2017 13:50:58 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH 3/5] openrisc/cputimer:
 Perparation for Multicore
In-Reply-To: <9ff134a8c36d63ad667d94cacb5ef490e2227e1e.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
 <9ff134a8c36d63ad667d94cacb5ef490e2227e1e.1503467674.git.shorne@gmail.com>
Message-ID: <05f62b13-b759-1b12-89fc-59d4eedf3791@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/22/2017 10:57 PM, Stafford Horne wrote:
> In order to support multicore system we move some of the previously
> static state variables into the state of each core.
> 
> On the other hand in order to allow timers to be synced between each
> code the ttcr (tick timer count register) is moved out of the core.
> This is not as per real hardware spec which has a separate timer counter
> per core, but it seems the most simple way to keep each clock in sync.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  hw/openrisc/cputimer.c       | 62 +++++++++++++++++++++++++++++++++-----------
>  target/openrisc/cpu.c        |  1 -
>  target/openrisc/cpu.h        |  4 ++-
>  target/openrisc/machine.c    |  1 -
>  target/openrisc/sys_helper.c |  4 +--
>  5 files changed, 52 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
