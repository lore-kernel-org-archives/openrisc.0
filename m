From: Stafford Horne <shorne@gmail.com>
Date: Mon, 6 Jan 2020 23:53:47 +0900
Subject: [OpenRISC] [PATCH 4/4] openrisc: use mmgrab
In-Reply-To: <201912301238.xfn6pKut%lkp@intel.com>
References: <1577634178-22530-5-git-send-email-Julia.Lawall@inria.fr>
 <201912301238.xfn6pKut%lkp@intel.com>
Message-ID: <20200106145347.GT24874@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 30, 2019 at 12:49:19PM +0800, kbuild test robot wrote:
> Hi Julia,
> 
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on vfio/next]
> [also build test ERROR on char-misc/char-misc-testing v5.5-rc3 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Julia-Lawall/use-mmgrab/20191230-011611
> base:   https://github.com/awilliam/linux-vfio.git next
> config: openrisc-simple_smp_defconfig (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/openrisc/kernel/smp.c: In function 'secondary_start_kernel':
> >> arch/openrisc/kernel/smp.c:116:2: error: implicit declaration of function 'mmgrab'; did you mean 'igrab'? [-Werror=implicit-function-declaration]
>      116 |  mmgrab(mm);
>          |  ^~~~~~
>          |  igrab
>    cc1: some warnings being treated as errors

Hi Julia,

It looks like this is just an include issue, do you want to revise the patch?

Once fixed, how do you plan to get this patch series merged?  I can add the
OpenRISC part to my queue or do you have a cleanups queue you can manage?

-Stafford

