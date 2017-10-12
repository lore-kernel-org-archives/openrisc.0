From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 12 Oct 2017 14:28:03 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH 4/5] openrisc: Initial SMP
	support
In-Reply-To: <b12db1e3daefa777fe0025c71ac30a816a126653.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
 <b12db1e3daefa777fe0025c71ac30a816a126653.1503467674.git.shorne@gmail.com>
Message-ID: <54bd0b51-0e47-c8b8-b423-ff9d599b1d61@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/22/2017 10:57 PM, Stafford Horne wrote:
> Wire in ompic and add basic support for SMP.  The OpenRISC is special in
> that interrupts for devices are routed to each core's PIC.  This is
> achieved using the qemu_irq_split utility, but this currently limits
> OpenRISC to 2 cores.
> 
> This models the reference architecture described in the OpenRISC spec
> 1.2 proposal.
> 
>   https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
> 
> The changes to the intialization of the sim include:
> 
> CPU Reset
>  o Reset each cpu to the bootstrap PC rather than only a single cpu as
>    done before.
>  o During Kernel loading the bootstrap PC is saved in a static global.
> 
> Network Initialization
>  o Connect the interrupt to each CPU
>  o Use more simple sysbus_mmio_map() rather than memory_region_add_subregion()
> 
> Sim Initialization
>  o Initialize the pic and tick timer per cpu
>  o Wire in the OMPIC if SMP is enabled
>  o Wire the serial irq to each CPU using qemu_irq_split()
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  hw/openrisc/openrisc_sim.c | 84 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 61 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

