From: Stafford Horne <shorne@gmail.com>
Date: Sat, 17 Sep 2016 09:06:44 +0900 (JST)
Subject: [OpenRISC] [PATCH 1/7] Apply transparent_union attribute to
	union semun
In-Reply-To: <201609170716.mwj8lyk6%fengguang.wu@intel.com>
References: <201609170716.mwj8lyk6%fengguang.wu@intel.com>
Message-ID: <alpine.LFD.2.20.1609170902390.2354@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On Sat, 17 Sep 2016, kbuild test robot wrote:

> Hi Jonas,
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.8-rc6 next-20160916]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
>
> url:    https://github.com/0day-ci/linux/commits/Stafford-Horne/openrisc-Misc-fixes-from-backlog/20160916-230114
> config: x86_64-randconfig-b0-09170504 (attached as .config)
> compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
> reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>   cc1: warnings being treated as errors
>   In file included from include/linux/sem.h:7,
>                    from include/linux/sched.h:35,
>                    from include/linux/kasan.h:4,
>                    from include/linux/slab.h:118,
>                    from include/linux/resource_ext.h:19,
>                    from include/linux/acpi.h:26,
>                    from drivers/gpu/drm/i915/i915_drv.c:30:
>>> include/uapi/linux/sem.h:51: error: union cannot be made transparent

Thanks for catching this.  I missed that this would break non openrisc 
architectures.

This issue is that "
All members of the union must have the same machine representation; this 
is necessary for this argument passing to work properly.
"

Definitely int and * will not always be the same.  Investingating what we 
can do on in arch/openrisc side without breaking the build/backcompat for
others.

Any other idea's welcome.

-Stafford

> vim +51 include/uapi/linux/sem.h
>
>    45	union semun {
>    46		int val;			/* value for SETVAL */
>    47		struct semid_ds __user *buf;	/* buffer for IPC_STAT & IPC_SET */
>    48		unsigned short __user *array;	/* array for GETALL & SETALL */
>    49		struct seminfo __user *__buf;	/* buffer for IPC_INFO */
>    50		void __user *__pad;
>  > 51	} __attribute__ ((transparent_union));
>    52
>    53	struct  seminfo {
>    54		int semmap;
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

