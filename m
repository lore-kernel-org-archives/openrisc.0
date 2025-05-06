Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BA42AA9;
	Tue,  6 May 2025 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560957; cv=none; b=YhgsTNLQcEB6Z6omsFFCVNF5mBEhBKPR6TMEjKjuaFFTbHtH1Tq+8LaRkKMUqnZPhTiN8ztXu4Ipxy5TtrkyVpEmrT3/63b5TxQxymj4MhDitiIzoapTa6pY0gqOYROQYp/mg6t1QNYQTJFFjZoHWej5vrv76Gu3XacFpuajq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560957; c=relaxed/simple;
	bh=N1ft1MCs11AqOF3ScLkba3Ks9VBNPAuD5bz4Yit63z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kM/Yr8s9BzsdUBfqdfx7B0uZilcL/xDHiM2X5riiaNKZRh3MAs2SrTQKjJ9mztilq8/BWxZm0Pjn8eKq9zimfdExojsDflUw+HIwS85rL4NOeVWFfNEqeN3nWNNhB8IoRkIuDzHDDseaDcYMYSnRlRB+93TlbGDXPtnSlhvLzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzXuxoQN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzXuxoQN"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso6484412b3a.2;
        Tue, 06 May 2025 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560955; x=1747165755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ5089g5fcxDtK8RW4HG6ld5BJ4Ih76RBmbnYmG1YBs=;
        b=DzXuxoQNtZHRRY+suKdAptrBjnxHUDc9X1FjX/689c8Le00dk6XzRWV2Vk8hW2dOOR
         1rvGBVwoNOSWyJgRluFWIXndbt5tAQK9AxZ4VhJUOHMANd0+FmsKIXRZEijGFzpATCA/
         MNGnxTv5RcuFvOzuplf1oYPiTa/GK09gZr0FCAZxelsJAcCvbqXoXNWetDJ1kU7SSGm1
         K5Yj1asFkzUovcEgBeMg+WSgaZh4iXrIGlCWN3pRvg6CdZAG7Mg3XH8/A1ljz04NbjLz
         kXCrqjwNYJ/d7dM3rz/dnrivnYketAuWfJ09LdUEOBxa8fpJk5ombvGbVqWZKszZQwCP
         fI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560955; x=1747165755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZ5089g5fcxDtK8RW4HG6ld5BJ4Ih76RBmbnYmG1YBs=;
        b=h6H6+3J20nY69NMVKLT6QXQOiPeBn/4TZUgftXyjQ8zGGXA9zH29zyVIU87ZAn74nP
         tpE1/m0/a7CIki+e2jdWErlUWmufrgPOx1g6X2Oil0zl0TnO3i9JAW+eN1TqS1Kuacl1
         rU23cJlhJX4OjLH52YPfrXBCIeW2YqWTLwAvolV3RvjEONALNnkVXIhQQGaiBbXpBuFZ
         0LUPf7UlfaDmFIUvRHxf5EtpdOKLIMyIvA+gKjVMbU9g7YRwZ9fGROv8HorIrJ1DUAfN
         XQsJhuhhbHpLdThd4yJd3tHzT3/NRyHYeIwM5oWGP+nWPOfLzlXdFVxxG2Bm2w/M43dr
         xjTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSSFo3rUtPzDmpp+ZfBFSZJHkQyWVLy2Hw0JmpPtnhj2vgWqpmjejX9FkNccjLxcSCrhImDaBEeC+wH0AY5g==@vger.kernel.org, AJvYcCVafwDrYuwKtKmRUOE70ysFVEAqSxhG+DE9vwjU0fWHngaa5fteGpG1CfWZlt7um6eVgGrQ2m3HDWzpJ7gT8Xg=@vger.kernel.org, AJvYcCWHEAIS8Bhhq30rz3CnI61dZe0OXcsTyPmCqbsK7lAER7vutc8WfuRxpst4/cA6jiFc/JioABIst3FU@vger.kernel.org, AJvYcCWKTkJkGvKy40QhN2MxfUt6IWrKJxERwZVF5yqHAp4OJS352b34tcPAnaWNYNRbxmebcxE2KGiYKWMz@vger.kernel.org, AJvYcCWS3lCx0BceEG8wpGwPiNJThxhyDz4OKCdv2dgDNyov2DUJwitLBiN+vaT9v6V56KjBYxLLmNg7aZXC@vger.kernel.org, AJvYcCWfqnjmWGWATE6i4ru90Jt3CQdGavkJAqcX8NVR8sHtpovNU/i614y6a/O0rySd0JvBUnvv0tYdK5visA1K@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtsa66y/f02EUo0qQuO0Rdin9kZP2ccHiBV2HrRH59clLv3kq
	I8KHdjqpWr5Q1I3eAqOFYRwwzbRhqQF9Y2XrmW2cI3MD7suzi6WM
X-Gm-Gg: ASbGnctnRT7LKYhCLKXyrXM50+vLI+Cgpxa0+pSzibgBzLaQo/+OZd44KWBNGI/ib1y
	yjthTG/2p1HNVkR1EseXpmUwk6fsuLO+Lr7zOSbRLZ/Y9Sg92t3oA7d/O5GtVhmLk6jf9DyQwHH
	JnTXKRz8PxxZ15z8Fw9u+2vYc8tZijjuNVYCz39rWLdn7+RhMJIqa6nTx1/3tjj86+xHswb22RB
	kCBrBZm9AcKK7+bNy2LzlsCI6PhDjrxUtzzw2bcPl90IChqIeEKR2Tcw+cHOhxukpmyaeIjGad0
	YL7T2IaIAz8lzb/CcIeDmHgrouSS2qzJ2folbCqcc0ap1oQEy34Y
X-Google-Smtp-Source: AGHT+IF5NliMgAkD005uOw+1owSmpP0uGKxfxNXpPz2R7hfi06C85Yyah/G4yQkzTWZpYJUeU1a68w==
X-Received: by 2002:a05:6a20:6f87:b0:203:c461:dd36 with SMTP id adf61e73a8af0-2148b113868mr730085637.6.1746560954804;
        Tue, 06 May 2025 12:49:14 -0700 (PDT)
Received: from localhost.localdomain ([104.28.249.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a473sm9686059b3a.18.2025.05.06.12.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:49:14 -0700 (PDT)
From: Jesung Yang <y.j3ms.n@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Vineet Gupta <vgupta@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesung Yang <y.j3ms.n@gmail.com>
Subject: [PATCH] docs: align with scripts/syscall.tbl migration
Date: Wed,  7 May 2025 04:48:41 +0900
Message-ID: <20250506194841.1567737-1-y.j3ms.n@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation to reflect the migration of the following
architectures to the centralized syscall table format:

  arc, arm64, csky, hexagon, loongarch, nios2, openrisc, riscv

As of commit 3db80c999debbad ("riscv: convert to generic syscall table"),
these architectures no longer rely on include/uapi/asm-generic/unistd.h.
Instead, syscall table headers (syscall_table_{32,64}.h) are generated by
scripts/syscalltbl.sh based on entries in scripts/syscall.tbl, with ABIs
specified in arch/*/kernel/Makefile.syscalls.

For the convenience of developers working with older kernel versions, the
original documentation is fully retained, with new sections added to
cover the scripts/syscall.tbl approach.

Verified with `make htmldocs`.

Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
Link: https://lore.kernel.org/lkml/20240704143611.2979589-1-arnd@kernel.org
---

I have tested all the listed architectures except hexagon and nios2.

Hexagon was skipped because no system-level emulator appears to be
available.

For nios2, QEMU removed support for both user and system emulation as of
version 9.1. With older versions (9.0.4 and 5.2.0), the kernel appears to
boot but gets stuck alternating between `get_cycles` and `__const_udelay`
during execution. Additionally, I could not find sufficient documentation
to enable runtime testing for nios2.

Any guidance on how to proceed with testing for hexagon or nios2 would be
appreciated.

Testing Summary:

- Linux kernel: 6.15.0-rc4-next-20250501
- System call number: 468
- System call name: xyzzy
- System call implementation:
    SYSCALL_DEFINE1(xyzzy, u64, d)
    {
    	printk("Hi, SYSCALL_DEFINE1\n");
    	return d;
    }

    COMPAT_SYSCALL_DEFINE2(xyzzy, compat_arg_u64_dual(d))
    {
    	printk("Hi, COMPAT_SYSCALL_DEFINE2\n");
    	return compat_arg_u64_glue(d);
    }
- Test userspace program:
    #include <unistd.h>
    int main(void) {
        long r = syscall(468, 17, 39);
        return 0;
    }

Each architecture was tested using the following steps:
  - Add the following entry to scripts/syscall.tbl:
      468	common	xyzzy			sys_xyzzy		compat_sys_xyzzy
  - Compile the kernel with the new syscall implementation
  - Verify that arch/*/include/generated/uapi/asm/unistd_*.h contains:
      #define __NR_xyzzy 468
  - Verify that arch/*/include/generated/asm/syscall_table_*.h contains:
      __SYSCALL_WITH_COMPAT(468, sys_xyzzy, compat_sys_xyzzy)
  - Boot the kernel under QEMU
  - Invoke sys_xyzzy() using the test program

Detailed Results:

1. arc
  - Kernel config: haps_hs_defconfig
  - QEMU target: qemu-system-arc -M virt -cpu archs
    - Src: https://github.com/foss-for-synopsys-dwc-arc-processors/qemu
    - Commit hash: 76e0fa9053b4184a29c9077959d484047eefe521
    - Version: 7.0.0
  - Result:
    - The following files were correctly generated
      - arch/arc/include/generated/asm/syscall_table_32.h
      - arch/arc/include/generated/uapi/asm/unistd_32.h
    - The system call was successfully invoked with output:
        "Hi, SYSCALL_DEFINE1\n"
    - The above output is expected due to a macro override in
      arch/arc/kernel/sys.c:
        #define __SYSCALL_WITH_COMPAT(nr, native, compat) \
                __SYSCALL(nr, native)
  - Notes:
    - Modified arch/arc/Makefile:
        - tune-mcpu-def-$(CONFIG_ISA_ARCV2)	:= -mcpu=hs38
        + tune-mcpu-def-$(CONFIG_ISA_ARCV2)	:= -mcpu=archs

2. arm64
  - Kernel config: defconfig
  - QEMU target: qemu-system-aarch64 -M virt -cpu cortex-a53
    - Src: https://github.com/qemu/qemu
    - Commit hash: a17976b04f2117e1bab64358f873b36fe4561520
    - Version: 9.0.4
  - Result:
    - The following files were correctly generated
      - arch/arm64/include/generated/asm/syscall_table_32.h
      - arch/arm64/include/generated/asm/syscall_table_64.h
      - arch/arm64/include/generated/asm/unistd_32.h
      - arch/arm64/include/generated/asm/unistd_compat_32.h
        - contains #define __NR_compat32_xyzzy 468
      - arch/arm64/include/generated/uapi/asm/unistd_64.h
    - 32-bit userspace process successfully invoked the system call with
      output:
        "Hi, COMPAT_SYSCALL_DEFINE2\n"
    - 64-bit userspace process successfully invoked the system call with
      output:
        "Hi, SYSCALL_DEFINE1\n"

3. csky
  - Kernel config: defconfig
  - QEMU target: qemu-system-cskyv2 -M virt -cpu ck807
    - Src: https://github.com/XUANTIE-RV/qemu/tree/xuantie-qemu-9.0
    - Commit hash: e0ace167effcd36d1f82c7ccb4522b3126011479
    - Version: 8.2.94
  - Result:
    - The following files were correctly generated
      - arch/csky/include/generated/asm/syscall_table_32.h
      - arch/csky/include/generated/uapi/asm/unistd_32.h
    - The system call was successfully invoked with output:
        "Hi, SYSCALL_DEFINE1\n"
    - The above output is expected due to a macro override in
      arch/csky/kernel/syscall_table.c:
        #define __SYSCALL_WITH_COMPAT(nr, native, compat) \
                __SYSCALL(nr, native)

4. hexagon
  - Kernel config: defconfig
  - QEMU target: N/A
  - Result:
    - The following files were correctly generated
      - arch/hexagon/include/generated/asm/syscall_table_32.h
      - arch/hexagon/include/generated/uapi/asm/unistd_32.h

5. loongarch
  - Kernel config: loongson3_defconfig
  - QEMU target: qemu-system-loongarch64 -machine virt -cpu la464
    - Src: https://github.com/qemu/qemu
    - Commit hash: a17976b04f2117e1bab64358f873b36fe4561520
    - Version: 9.0.4
  - Result:
    - The following files were correctly generated
      - arch/loongarch/include/generated/asm/syscall_table_64.h
      - arch/loongarch/include/generated/uapi/asm/unistd_64.h
    - The system call was successfully invoked with output:
        "Hi, SYSCALL_DEFINE1\n"
    - The above output is expected due to a macro override in
      arch/loongarch/kernel/syscall.c:
        #define __SYSCALL_WITH_COMPAT(nr, native, compat) \
                __SYSCALL(nr, native)

6. nios2
  - Kernel config: 10m50_defconfig
  - QEMU target: qemu-system-nios2 -machine 10m50-ghrd
    - Src: https://github.com/qemu/qemu
    - Commit hash (9.0.4): a17976b04f2117e1bab64358f873b36fe4561520
    - Commit hash (5.2.0): 553032db17440f8de011390e5a1cfddd13751b0b
    - Version: 9.0.4, 5.2.0
  - Result:
    - The following files were correctly generated
      - arch/nios2/include/generated/asm/syscall_table_32.h
      - arch/nios2/include/generated/uapi/asm/unistd_32.h

7. openrisc
  - Kernel config: virt_defconfig
  - QEMU target: qemu-system-or1k -machine virt -cpu or1200
    - Src: https://github.com/qemu/qemu
    - Commit hash: a17976b04f2117e1bab64358f873b36fe4561520
    - Version: 9.0.4
  - Result:
    - The following files were correctly generated
      - arch/openrisc/include/generated/asm/syscall_table_32.h
      - arch/openrisc/include/generated/uapi/asm/unistd_32.h
    - The system call was successfully invoked with output:
        "Hi, SYSCALL_DEFINE1\n"
    - The above output is expected due to a macro override in
      arch/openrisc/kernel/sys_call_table.c:
        #define __SYSCALL_WITH_COMPAT(nr, native, compat) \
                __SYSCALL(nr, native)

8. riscv (32-bit)
  - Kernel config: defconfig + 32-bit.config
  - QEMU target: qemu-system-riscv32 -M virt -cpu rv32
    - Src: https://github.com/qemu/qemu
    - Commit hash: a17976b04f2117e1bab64358f873b36fe4561520
    - Version: 9.0.4
  - Result:
    - The following files were correctly generated
      - arch/riscv/include/generated/asm/syscall_table_32.h
      - arch/riscv/include/generated/uapi/asm/unistd_32.h
    - The system call was successfully invoked with output:
        "Hi, SYSCALL_DEFINE1\n"
    - The above output is expected due to a macro override in
      arch/riscv/kernel/syscall_table.c:
        #define __SYSCALL_WITH_COMPAT(nr, native, compat) \
                __SYSCALL(nr, native)

9. riscv (64-bit)
  - Kernel config: defconfig + 64-bit.config
  - QEMU target: qemu-system-riscv64 -M virt -cpu rv64
    - Src: https://github.com/qemu/qemu
    - Commit hash: a17976b04f2117e1bab64358f873b36fe4561520
    - Version: 9.0.4
  - Result:
    - The following files were correctly generated
      - arch/riscv/include/generated/asm/syscall_table_32.h
      - arch/riscv/include/generated/asm/syscall_table_64.h
      - arch/riscv/include/generated/uapi/asm/unistd_32.h
      - arch/riscv/include/generated/uapi/asm/unistd_64.h
    - 32-bit userspace process successfully invoked the system call with
      output:
        "Hi, COMPAT_SYSCALL_DEFINE2\n"
    - 64-bit userspace process successfully invoked the system call with
      output:
        "Hi, SYSCALL_DEFINE1\n"

 Documentation/process/adding-syscalls.rst | 84 +++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 906c47f1a9e5..fc0b0bbcd34d 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -248,6 +248,52 @@ To summarize, you need a commit that includes:
  - fallback stub in ``kernel/sys_ni.c``
 
 
+.. _syscall_generic_6_11:
+
+Since 6.11
+~~~~~~~~~~
+
+Starting with kernel version 6.11, general system call implementation for the
+following architectures no longer requires modifications to
+``include/uapi/asm-generic/unistd.h``:
+
+ - arc
+ - arm64
+ - csky
+ - hexagon
+ - loongarch
+ - nios2
+ - openrisc
+ - riscv
+
+Instead, you need to update ``scripts/syscall.tbl`` and, if applicable, adjust
+``arch/*/kernel/Makefile.syscalls``.
+
+As ``scripts/syscall.tbl`` serves as a common syscall table across multiple
+architectures, a new entry is required in this table::
+
+    468   common   xyzzy     sys_xyzzy
+
+Note that adding an entry to ``scripts/syscall.tbl`` with the "common" ABI
+also affects all architectures that share this table. For more limited or
+architecture-specific changes, consider using an architecture-specific ABI or
+defining a new one.
+
+If a new ABI, say ``xyz``, is introduced, the corresponding updates should be
+made to ``arch/*/kernel/Makefile.syscalls`` as well::
+
+    syscall_abis_{32,64} += xyz (...)
+
+To summarize, you need a commit that includes:
+
+ - ``CONFIG`` option for the new function, normally in ``init/Kconfig``
+ - ``SYSCALL_DEFINEn(xyzzy, ...)`` for the entry point
+ - corresponding prototype in ``include/linux/syscalls.h``
+ - new entry in ``scripts/syscall.tbl``
+ - (if needed) Makefile updates in ``arch/*/kernel/Makefile.syscalls``
+ - fallback stub in ``kernel/sys_ni.c``
+
+
 x86 System Call Implementation
 ------------------------------
 
@@ -353,6 +399,41 @@ To summarize, you need:
    ``include/uapi/asm-generic/unistd.h``
 
 
+Since 6.11
+~~~~~~~~~~
+
+This applies to all the architectures listed in :ref:`Since 6.11<syscall_generic_6_11>`
+under "Generic System Call Implementation", except arm64. See
+:ref:`Compatibility System Calls (arm64)<compat_arm64>` for more information.
+
+You need to extend the entry in ``scripts/syscall.tbl`` with an extra column
+to indicate that a 32-bit userspace program running on a 64-bit kernel should
+hit the compat entry point::
+
+    468   common     xyzzy     sys_xyzzy    compat_sys_xyzzy
+
+To summarize, you need:
+
+ - ``COMPAT_SYSCALL_DEFINEn(xyzzy, ...)`` for the compat entry point
+ - corresponding prototype in ``include/linux/compat.h``
+ - modification of the entry in ``scripts/syscall.tbl`` to include an extra
+   "compat" column
+ - (if needed) 32-bit mapping struct in ``include/linux/compat.h``
+
+
+.. _compat_arm64:
+
+Compatibility System Calls (arm64)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+On arm64, there is a dedicated syscall table for compatibility system calls
+targeting 32-bit (AArch32) userspace: ``arch/arm64/tools/syscall_32.tbl``.
+You need to add an additional line to this table specifying the compat
+entry point::
+
+    468   common     xyzzy     sys_xyzzy    compat_sys_xyzzy
+
+
 Compatibility System Calls (x86)
 --------------------------------
 
@@ -575,3 +656,6 @@ References and Sources
  - Recommendation from Linus Torvalds that x32 system calls should prefer
    compatibility with 64-bit versions rather than 32-bit versions:
    https://lore.kernel.org/r/CA+55aFxfmwfB7jbbrXxa=K7VBYPfAvmu3XOkGrLbB1UFjX1+Ew@mail.gmail.com
+ - Patch series revising system call table infrastructure to use
+   scripts/syscall.tbl across multiple architectures:
+   https://lore.kernel.org/lkml/20240704143611.2979589-1-arnd@kernel.org
-- 
2.43.0

