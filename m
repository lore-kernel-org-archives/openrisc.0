From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Fri, 8 May 2020 08:53:27 +0200
Subject: [OpenRISC] [PATCH v4 02/14] arm: add support for folded p4d
 page tables
In-Reply-To: <20200507161155.GE683243@linux.ibm.com>
References: <20200414153455.21744-1-rppt@kernel.org>
 <20200414153455.21744-3-rppt@kernel.org>
 <CGME20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f@eucas1p2.samsung.com>
 <39ba8a04-d6b5-649d-c289-0c8b27cb66c5@samsung.com>
 <20200507161155.GE683243@linux.ibm.com>
Message-ID: <98229ab1-fbf8-0a89-c5d6-270c828799e7@samsung.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi Mike,

On 07.05.2020 18:11, Mike Rapoport wrote:
> On Thu, May 07, 2020 at 02:16:56PM +0200, Marek Szyprowski wrote:
>> On 14.04.2020 17:34, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> Implement primitives necessary for the 4th level folding, add walks of p4d
>>> level where appropriate, and remove __ARCH_USE_5LEVEL_HACK.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> Today I've noticed that kexec is broken on ARM 32bit. Bisecting between
>> current linux-next and v5.7-rc1 pointed to this commit. I've tested this
>> on Odroid XU4 and Raspberry Pi4 boards. Here is the relevant log:
>>
>> # kexec --kexec-syscall -l zImage --append "$(cat /proc/cmdline)"
>> memory_range[0]:0x40000000..0xbe9fffff
>> memory_range[0]:0x40000000..0xbe9fffff
>> # kexec -e
>> kexec_core: Starting new kernel
>> 8<--- cut here ---
>> Unable to handle kernel paging request at virtual address c010f1f4
>> pgd = c6817793
>> [c010f1f4] *pgd=4000041e(bad)
>> Internal error: Oops: 80d [#1] PREEMPT ARM
>> Modules linked in:
>> CPU: 0 PID: 1329 Comm: kexec Tainted: G        W
>> 5.7.0-rc3-00127-g6cba81ed0f62 #611
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> PC is at machine_kexec+0x40/0xfc
> Any chance you have the debug info in this kernel?
> scripts/faddr2line would come handy here.

# ./scripts/faddr2line --list vmlinux machine_kexec+0x40
machine_kexec+0x40/0xf8:

machine_kexec at arch/arm/kernel/machine_kexec.c:182
  177            reboot_code_buffer = 
page_address(image->control_code_page);
  178
  179            /* Prepare parameters for reboot_code_buffer*/
  180            set_kernel_text_rw();
  181            kexec_start_address = image->start;
 >182<           kexec_indirection_page = page_list;
  183            kexec_mach_type = machine_arch_type;
  184            kexec_boot_atags = image->arch.kernel_r2;
  185
  186            /* copy our kernel relocation code to the control code 
page */
  187            reboot_entry = fncpy(reboot_code_buffer,

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

