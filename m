From: kbuild test robot <lkp@intel.com>
Date: Sun, 17 Jun 2018 02:14:28 +0800
Subject: [OpenRISC] [PATCH] mm: convert return type of handle_mm_fault()
 caller to vm_fault_t
In-Reply-To: <20180614190629.GA18576@jordon-HP-15-Notebook-PC>
References: <20180614190629.GA18576@jordon-HP-15-Notebook-PC>
Message-ID: <201806170146.1XtJpNiY%fengguang.wu@intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Souptick,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.17]
[cannot apply to linus/master powerpc/next sparc-next/master next-20180615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Souptick-Joarder/mm-convert-return-type-of-handle_mm_fault-caller-to-vm_fault_t/20180615-030636
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

   arch/powerpc/mm/copro_fault.c:36:5: error: conflicting types for 'copro_handle_mm_fault'
    int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
        ^~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/mm/copro_fault.c:27:0:
   arch/powerpc/include/asm/copro.h:18:5: note: previous declaration of 'copro_handle_mm_fault' was here
    int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
        ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7:0,
                    from include/linux/kernel.h:7,
                    from include/asm-generic/bug.h:18,
                    from arch/powerpc/include/asm/bug.h:128,
                    from include/linux/bug.h:5,
                    from arch/powerpc/include/asm/mmu.h:126,
                    from arch/powerpc/include/asm/lppaca.h:36,
                    from arch/powerpc/include/asm/paca.h:21,
                    from arch/powerpc/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from arch/powerpc/mm/copro_fault.c:23:
   arch/powerpc/mm/copro_fault.c:101:19: error: conflicting types for 'copro_handle_mm_fault'
    EXPORT_SYMBOL_GPL(copro_handle_mm_fault);
                      ^
   include/linux/export.h:65:21: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                        ^~~
>> arch/powerpc/mm/copro_fault.c:101:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(copro_handle_mm_fault);
    ^~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/mm/copro_fault.c:27:0:
   arch/powerpc/include/asm/copro.h:18:5: note: previous declaration of 'copro_handle_mm_fault' was here
    int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
        ^~~~~~~~~~~~~~~~~~~~~

vim +/EXPORT_SYMBOL_GPL +101 arch/powerpc/mm/copro_fault.c

7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20  @23  #include <linux/sched.h>
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   24  #include <linux/mm.h>
4b16f8e2d arch/powerpc/platforms/cell/spu_fault.c Paul Gortmaker     2011-07-22   25  #include <linux/export.h>
e83d01697 arch/powerpc/mm/copro_fault.c           Ian Munsie         2014-10-08   26  #include <asm/reg.h>
73d16a6e0 arch/powerpc/mm/copro_fault.c           Ian Munsie         2014-10-08   27  #include <asm/copro.h>
be3ebfe82 arch/powerpc/mm/copro_fault.c           Ian Munsie         2014-10-08   28  #include <asm/spu.h>
ec249dd86 arch/powerpc/mm/copro_fault.c           Michael Neuling    2015-05-27   29  #include <misc/cxl-base.h>
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   30  
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   31  /*
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   32   * This ought to be kept in sync with the powerpc specific do_page_fault
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   33   * function. Currently, there are a few corner cases that we haven't had
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   34   * to handle fortunately.
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   35   */
e83d01697 arch/powerpc/mm/copro_fault.c           Ian Munsie         2014-10-08   36  int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
7c71e54a4 arch/powerpc/mm/copro_fault.c           Souptick Joarder   2018-06-15   37  		unsigned long dsisr, vm_fault_t *flt)
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   38  {
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   39  	struct vm_area_struct *vma;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   40  	unsigned long is_write;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   41  	int ret;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   42  
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   43  	if (mm == NULL)
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   44  		return -EFAULT;
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   45  
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   46  	if (mm->pgd == NULL)
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   47  		return -EFAULT;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   48  
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   49  	down_read(&mm->mmap_sem);
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   50  	ret = -EFAULT;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   51  	vma = find_vma(mm, ea);
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   52  	if (!vma)
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   53  		goto out_unlock;
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   54  
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   55  	if (ea < vma->vm_start) {
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   56  		if (!(vma->vm_flags & VM_GROWSDOWN))
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   57  			goto out_unlock;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   58  		if (expand_stack(vma, ea))
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   59  			goto out_unlock;
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   60  	}
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   61  
e83d01697 arch/powerpc/mm/copro_fault.c           Ian Munsie         2014-10-08   62  	is_write = dsisr & DSISR_ISSTORE;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   63  	if (is_write) {
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   64  		if (!(vma->vm_flags & VM_WRITE))
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   65  			goto out_unlock;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   66  	} else {
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   67  		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   68  			goto out_unlock;
842915f56 arch/powerpc/mm/copro_fault.c           Mel Gorman         2015-02-12   69  		/*
18061c17c arch/powerpc/mm/copro_fault.c           Aneesh Kumar K.V   2017-01-30   70  		 * PROT_NONE is covered by the VMA check above.
18061c17c arch/powerpc/mm/copro_fault.c           Aneesh Kumar K.V   2017-01-30   71  		 * and hash should get a NOHPTE fault instead of
18061c17c arch/powerpc/mm/copro_fault.c           Aneesh Kumar K.V   2017-01-30   72  		 * a PROTFAULT in case fixup is needed for things
18061c17c arch/powerpc/mm/copro_fault.c           Aneesh Kumar K.V   2017-01-30   73  		 * like autonuma.
842915f56 arch/powerpc/mm/copro_fault.c           Mel Gorman         2015-02-12   74  		 */
18061c17c arch/powerpc/mm/copro_fault.c           Aneesh Kumar K.V   2017-01-30   75  		if (!radix_enabled())
842915f56 arch/powerpc/mm/copro_fault.c           Mel Gorman         2015-02-12   76  			WARN_ON_ONCE(dsisr & DSISR_PROTFAULT);
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   77  	}
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   78  
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   79  	ret = 0;
dcddffd41 arch/powerpc/mm/copro_fault.c           Kirill A. Shutemov 2016-07-26   80  	*flt = handle_mm_fault(vma, ea, is_write ? FAULT_FLAG_WRITE : 0);
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   81  	if (unlikely(*flt & VM_FAULT_ERROR)) {
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   82  		if (*flt & VM_FAULT_OOM) {
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   83  			ret = -ENOMEM;
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   84  			goto out_unlock;
33692f275 arch/powerpc/mm/copro_fault.c           Linus Torvalds     2015-01-29   85  		} else if (*flt & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV)) {
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   86  			ret = -EFAULT;
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   87  			goto out_unlock;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   88  		}
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   89  		BUG();
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   90  	}
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   91  
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   92  	if (*flt & VM_FAULT_MAJOR)
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   93  		current->maj_flt++;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   94  	else
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   95  		current->min_flt++;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   96  
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   97  out_unlock:
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20   98  	up_read(&mm->mmap_sem);
60ee03194 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2009-02-17   99  	return ret;
7cd58e438 arch/powerpc/platforms/cell/spu_fault.c Jeremy Kerr        2007-12-20  100  }
e83d01697 arch/powerpc/mm/copro_fault.c           Ian Munsie         2014-10-08 @101  EXPORT_SYMBOL_GPL(copro_handle_mm_fault);
73d16a6e0 arch/powerpc/mm/copro_fault.c           Ian Munsie         2014-10-08  102  

:::::: The code at line 101 was first introduced by commit
:::::: e83d01697583d8610d1d62279758c2a881e3396f powerpc/cell: Move spu_handle_mm_fault() out of cell platform

:::::: TO: Ian Munsie <imunsie@au1.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56250 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180617/db6a6435/attachment-0001.gz>
