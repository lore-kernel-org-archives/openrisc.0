From: kbuild test robot <lkp@intel.com>
Date: Mon, 30 Dec 2019 12:49:19 +0800
Subject: [OpenRISC] [PATCH 4/4] openrisc: use mmgrab
In-Reply-To: <1577634178-22530-5-git-send-email-Julia.Lawall@inria.fr>
References: <1577634178-22530-5-git-send-email-Julia.Lawall@inria.fr>
Message-ID: <201912301238.xfn6pKut%lkp@intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Julia,

I love your patch! Yet something to improve:

[auto build test ERROR on vfio/next]
[also build test ERROR on char-misc/char-misc-testing v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Julia-Lawall/use-mmgrab/20191230-011611
base:   https://github.com/awilliam/linux-vfio.git next
config: openrisc-simple_smp_defconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/openrisc/kernel/smp.c: In function 'secondary_start_kernel':
>> arch/openrisc/kernel/smp.c:116:2: error: implicit declaration of function 'mmgrab'; did you mean 'igrab'? [-Werror=implicit-function-declaration]
     116 |  mmgrab(mm);
         |  ^~~~~~
         |  igrab
   cc1: some warnings being treated as errors

vim +116 arch/openrisc/kernel/smp.c

   107	
   108	asmlinkage __init void secondary_start_kernel(void)
   109	{
   110		struct mm_struct *mm = &init_mm;
   111		unsigned int cpu = smp_processor_id();
   112		/*
   113		 * All kernel threads share the same mm context; grab a
   114		 * reference and switch to it.
   115		 */
 > 116		mmgrab(mm);
   117		current->active_mm = mm;
   118		cpumask_set_cpu(cpu, mm_cpumask(mm));
   119	
   120		pr_info("CPU%u: Booted secondary processor\n", cpu);
   121	
   122		setup_cpuinfo();
   123		openrisc_clockevent_init();
   124	
   125		notify_cpu_starting(cpu);
   126	
   127		/*
   128		 * OK, now it's safe to let the boot CPU continue
   129		 */
   130		complete(&cpu_running);
   131	
   132		synchronise_count_slave(cpu);
   133		set_cpu_online(cpu, true);
   134	
   135		local_irq_enable();
   136	
   137		preempt_disable();
   138		/*
   139		 * OK, it's off to the idle thread for us
   140		 */
   141		cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
   142	}
   143	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 7983 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20191230/b62daf1a/attachment.gz>
