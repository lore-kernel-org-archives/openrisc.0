From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 30 Jan 2021 11:37:57 +0100
Subject: [OpenRISC] [PATCH] openrisc: use device tree to determine
 present cpus
In-Reply-To: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
Message-ID: <CAMuHMdWcJuBv94pQ-1Bf7QAb6e3=AjSz7GBFCPLqiCJ0CjXjqA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Jan,

On Fri, Jan 29, 2021 at 7:34 PM Jan Henrik Weinstock
<jan.weinstock@rwth-aachen.de> wrote:
> This patch proposes to use the device tree to determine the present cpus
> instead of assuming all CONFIG_NRCPUS are actually present in the system.
>
> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>

Thanks for your patch!

> --- a/arch/openrisc/kernel/smp.c
> +++ b/arch/openrisc/kernel/smp.c

> @@ -68,14 +69,25 @@ void __init smp_init_cpus(void)
>
>   void __init smp_prepare_cpus(unsigned int max_cpus)
>   {
> -       int i;
> +       u32 cpu_id;
> +       struct device_node *cpu, *cpus;
>
>         /*
>          * Initialise the present map, which describes the set of CPUs
>          * actually populated at the present time.
>          */
> -       for (i = 0; i < max_cpus; i++)
> -               set_cpu_present(i, true);
> +       cpus = of_find_node_by_path("/cpus");
> +       for_each_child_of_node(cpus, cpu) {

for_each_of_cpu_node()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
