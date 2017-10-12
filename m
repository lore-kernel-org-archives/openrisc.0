From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 12 Oct 2017 13:48:13 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH 2/5] target/openrisc: Make
 coreid and numcores configurable in state
In-Reply-To: <88d5624e0d2f52db9072fcb36406baadf31d96bd.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
 <88d5624e0d2f52db9072fcb36406baadf31d96bd.1503467674.git.shorne@gmail.com>
Message-ID: <96862cfe-263b-78fc-e471-ed04966791f8@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/22/2017 10:57 PM, Stafford Horne wrote:
> Previously coreid and numcores were hard coded as 0 and 1 respectively
> as OpenRISC QEMU did not have multicore support.
> 
> Multicore support is now being added so these registers need to have
> configured values.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  hw/openrisc/openrisc_sim.c   | 3 +++
>  target/openrisc/cpu.h        | 3 +++
>  target/openrisc/machine.c    | 7 +++++--
>  target/openrisc/sys_helper.c | 4 ++--
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index e1eeffc490..44a657753d 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -110,6 +110,9 @@ static void openrisc_sim_init(MachineState *machine)
>  
>      for (n = 0; n < smp_cpus; n++) {
>          cpu = cpu_openrisc_init(cpu_model);
> +        cpu->env.coreid = n;
> +        cpu->env.numcores = smp_cpus;

This duplicates cpu->parent_obj.cpu_index.  Also c.f. max_cpus vs smp_cpus; the
latter can change via hot-plug.

> @@ -104,8 +104,8 @@ static const VMStateInfo vmstate_sr = {
>  
>  static const VMStateDescription vmstate_env = {
>      .name = "env",
> -    .version_id = 6,
> -    .minimum_version_id = 6,
> +    .version_id = 7,
> +    .minimum_version_id = 7,
>      .post_load = env_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
> @@ -152,6 +152,9 @@ static const VMStateDescription vmstate_env = {
>          VMSTATE_UINT32(picmr, CPUOpenRISCState),
>          VMSTATE_UINT32(picsr, CPUOpenRISCState),
>  
> +        VMSTATE_UINT32(coreid, CPUOpenRISCState),
> +        VMSTATE_UINT32(numcores, CPUOpenRISCState),

If you use the above directly you don't need to save/restore these yourself.

>      case TO_SPR(0, 128): /* COREID */
> -        return 0;
> +        return env->coreid;

>      case TO_SPR(0, 129): /* NUMCORES */
> -        return 1;
> +        return env->numcores;

Just use the global variable directly here, IMO.


r~

