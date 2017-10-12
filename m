From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 12 Oct 2017 13:48:42 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH 1/5] openrisc/ompic: Add
 OpenRISC Multicore PIC (OMPIC)
In-Reply-To: <ededad1a3abe4ca8dc25fc6eb368fe15a4ccfe12.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
 <ededad1a3abe4ca8dc25fc6eb368fe15a4ccfe12.1503467674.git.shorne@gmail.com>
Message-ID: <aedb9d6c-6123-9628-0630-21810a1e3f2e@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/22/2017 10:57 PM, Stafford Horne wrote:
> Add OpenRISC Multicore PIC which handles inter processor interrupts
> (IPI) between cores.  In OpenRISC all device interrupts are routed to
> each core enabling this device to be simple.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  default-configs/or1k-softmmu.mak |   1 +
>  hw/intc/Makefile.objs            |   1 +
>  hw/intc/ompic.c                  | 179 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 181 insertions(+)
>  create mode 100644 hw/intc/ompic.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
