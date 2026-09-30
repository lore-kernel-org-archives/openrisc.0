Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E99503BEE
	for <linux-openrisc@vger.kernel.org>; Wed, 30 Sep 2026 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800321; cv=none; b=YR5/YoKzpN9YW5GK9rWSfNtAdVfk25TY+hECdllcE6sPBikC+ppJaaG3jb/cndS32vOd0x1dOOeZA5t4Ja1FsWX3977rAupaIprBXu+7gwsYVdclejF1suBfjcwDRJgdfl8vrqr6L9FgkaUpMwqyNMWOymMp72t2nrKsuLT5kcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800321; c=relaxed/simple;
	bh=JsUyX/iJjMo1Mi4MUpeDu8VJE810XoBK9W5Gdt15IMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKK0TSodm9rAa0hF93JPlggGoxuJwSqMS/6etrbjbUDxEKkedJqpoQK1DBtXq0btf7GOMJTKhpGt9hO8e5XL/HMehJM0OfU6Ebap6Hp1niUFad79bv1vN1AP5BvhH18g+m5sRVz98b527NHLbpDm+8nnEMPFVQemC0VeIJHnb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvSSYmfv; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvSSYmfv"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso8900472eec.1
        for <linux-openrisc@vger.kernel.org>; Wed, 30 Sep 2026 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790800319; x=1791405119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72nYRrTYSL7ww//DHgv9cQLgr49cv6bRekJhb1O1FHo=;
        b=rvSSYmfvU8O1u8AvjYnnJ8Xg6TICncsuF5FO5FwxXKxWA6m7SwRcv1G+GeOhaP5j0M
         gbER2XjTL26INm4ZcCakyq2ye+60Cwalda+AqfuMRurSne7fd/NLwgG3w5hoJtsuE8uh
         3Nxl9YzA486ppEWF7VthuGK9jE6kc2X+QGbrZ/PKKhIfzpYva3/Mc4oRgyRswfwUjCUW
         XnHVyb0k6fEu8mTmi5sM0O6pcKQTGNif1YyvQl8TuGEAJZaJc0muW2vxskX6AMZGp2Ql
         oKFTF2zJqxjlhmlR2baa9Uh2g/S6P6yLlwI717snHhpKAkOaf8plGvhYLrLvMhm3YP/H
         AEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800319; x=1791405119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=72nYRrTYSL7ww//DHgv9cQLgr49cv6bRekJhb1O1FHo=;
        b=dHCK2DRxj5vvAAlROcE3Fw3w1n0YmBCx0PrCcRwfEASZocGMRjD2bjRhP4KicIfGn/
         dy67cbCjNYKKPzA6wINqs7pUPmjImj4wvDY7FlSAH1/N0+z1DXni0I4XF5UZ391SZC8r
         NChfiwAuW3yHTfP1gVQB6UPktoicn+0qmVFtyeT65HapeiSEGPZIz4H1EAJIecizJf1U
         7RfMevtvo8PKS+x/VOPZC3vfGE9dtZ/HTsuOaN3IVidnxbH2/5NgURK3Y33WJO+YM7lp
         1pmqHfug9E+CTKZl6h7a8s3poFLHpY2E61w14tTYUkXEpY3xJgOmyQxXagUaridJ1ryu
         C9lg==
X-Forwarded-Encrypted: i=1; AKwUvByKNt9TeW+UpGhVR6et+UtCdZjBKhqzg6ZxDTWsFe0EXlOLCjd98If8U2nnn5MfDAKHgv4I4nv4bppzbOLyww==@vger.kernel.org
X-Gm-Message-State: AFuF++mUVZKBQLt9p3cooTqSuYp5jFUa6MOspepGCRsGm4L5kJttqo4k
	rohQN6q0v30I5UOPLV6cLRS+VjE1/bA2uyckiscZ1l3YYqe+eCA3T/cP
X-Gm-Gg: AYBFou202lBfhi3exjAzBx9m3Lmzr+0jp4aqMbKT/kO72B8l0DT6AVDj8EbbfEctPoV
	lv0QQKSvOkVXdo8hZZmjRaiVJ8BxL9dSAuC8VLMLg0hJFMbLOdZS9jlRdPn8a+iEFfDc6DQSITt
	/md8T3lcfl79amcq0MRk1prqXOY+CffkA6xocftqkLKPQtzUMyONunel5xhSZ5glZdHuSPaKS5w
	HOw/n9XI64bIKJqJuq0jamFOHKrazbJQkV6nqt7PZm6wu4vGGq5udT1MuC/Tzlvd62JLkNyFZHY
	3ioJPGF8MocgUBcl7Vb81STBhU8rzHaCo/J3h6OHJukujT66B1uY6VEb+5P7rV4cref5khbWIJ8
	/NjokwBZQF6mrvG1bkyi9KT5E5E5ml9dUqLwDfnRRrb+3h+JdaRK7j6fcOmVisov+qHWuriHOeW
	ly6TN+xDYPuztM9T7SOvQA/6x5sSEK4QLiYwARse0Hrbmc4uncFi26JToxXM1HbJkEwGpVpsYZB
	Kk4hw==
X-Received: by 2002:a05:7301:a0a:b0:328:643d:4f80 with SMTP id 5a478bee46e88-34cdc4cdf88mr2447838eec.20.1790800318264;
        Wed, 30 Sep 2026 13:31:58 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:2e39:63b8:ea3c:fa28:7091])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4d1d560sm1162411eec.29.2026.09.30.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:31:57 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: tytso@mit.edu,
	wangruikang@iscas.ac.cn,
	namcao@linutronix.de,
	pjw@kernel.org,
	kees@kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v2 0/4] openrisc: Add support for KProbes
Date: Thu,  1 Oct 2026 02:01:25 +0530
Message-ID: <20260930203129.51048-1-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260407185650.79816-2-sahilcdq0@gmail.com>
References: <20260407185650.79816-2-sahilcdq0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Apologies for the delay. This is v2 of the patch series to add KProbe
support for OpenRISC.

The series also adds support for Kretprobes (which depends on the rethook
framework [1]). Kretprobes are fired on function return.

In order to build the kernel with Kprobes and Kretprobes enabled, the
following config options are required:
1. CONFIG_HAVE_KPROBES=y
2. CONFIG_KPROBES=y
3. CONFIG_RETHOOK=y
4. CONFIG_KRETPROBES=y

I tested the generic functionality of Kprobes and Kretprobes using the
tests located at "lib/tests" [2], samples located at "samples/kprobes" [3],
as well as a few test modules that I have published here [4]. The following
options are required to build the samples and tests:
1. CONFIG_SAMPLES=y
2. CONFIG_SAMPLE_KPROBES=m
3. CONFIG_SAMPLE_KRETPROBES=m
4. CONFIG_KPROBES_SANITY_TEST=m

I have also added unit tests at "arch/openrisc/kernel/tests" to verify
that Kprobes work properly when inserted at branch instructions, and
that delay slots are handled correctly. The tests are based on the Kprobe
testsuite added for RISC-V. The following options need to be enabled to
build the tests:
1. CONFIG_KUNIT=y
2. CONFIG_RUNTIME_KERNEL_TESTING_MENU=y
3. CONFIG_OR_KPROBES_KUNIT=m

Below are the results of the tests and sample modules when run in my
environment.

- kretprobe_example:

/home # insmod kretprobe_example.ko 
Planted return probe at kernel_clone: (ptrval)
/home # ls >/dev/null
kernel_clone returned 35 and took 1302450 ns to execute
/home # rmmod kretprobe_example.ko 
kernel_clone returned 36 and took 1121200 ns to execute
kretprobe at (ptrval) unregistered
Missed probing 0 instances of kernel_clone

- test_kprobes:

/home # insmod test_kprobes.ko 
KTAP version 1
1..1
    KTAP version 1
    # Subtest: kprobes_test
    # module: test_kprobes
    1..5
    ok 1 test_kprobe
    ok 2 test_kprobes
    ok 3 test_kprobe_missed
    ok 4 test_kretprobe
    ok 5 test_kretprobes
# kprobes_test: pass:5 fail:0 skip:0 total:5
# Totals: pass:5 fail:0 skip:0 total:5
ok 1 kprobes_test

- openrisc_test_kprobes:

/home # insmod openrisc_test_kprobes.ko 
KTAP version 1
1..1
    KTAP version 1
    # Subtest: kprobes_openrisc
    # module: openrisc_test_kprobes
    1..1
    ok 1 test_kprobe_openrisc
ok 1 kprobes_openrisc

I have also made changes based on the review comments I received for
v1 [5] including several of Sachiko's comments [6]. I chose not to make
changes in a few places. I'll send emails as a reply to this thread
explaining my reasoning inline.

Thanks,
Sahil

[1] https://lkml.rescloud.iu.edu/2203.0/05974.html
[2] https://github.com/torvalds/linux/tree/master/lib/tests
[3] https://github.com/torvalds/linux/tree/master/samples/kprobes
[4] https://github.com/valdaarhun/or-dev
[5] https://lwn.net/ml/all/20260407185650.79816-1-sahilcdq0@gmail.com/
[6] https://sashiko.dev/#/patchset/20260407185650.79816-1-sahilcdq0%40gmail.com

Sahil Siddiq (4):
  openrisc: Add utilities and clean up simulation of instructions
  openrisc: Add KProbes
  openrisc: Add unit tests for KProbes on branch instructions
  openrisc: Add Kretprobes

 arch/openrisc/Kconfig                         |   3 +
 arch/openrisc/Kconfig.debug                   |  30 +-
 arch/openrisc/configs/or1ksim_defconfig       |   2 +
 arch/openrisc/configs/virt_defconfig          |   2 +
 arch/openrisc/include/asm/asm.h               |  22 +
 arch/openrisc/include/asm/break.h             |  19 +
 arch/openrisc/include/asm/cpuinfo.h           |   3 +
 arch/openrisc/include/asm/insn-def.h          |  64 ++-
 arch/openrisc/include/asm/kprobes.h           |  77 ++++
 arch/openrisc/include/asm/spr_defs.h          |   1 +
 arch/openrisc/kernel/Makefile                 |   5 +-
 arch/openrisc/kernel/entry.S                  |  16 +
 arch/openrisc/kernel/insn.c                   |  84 ++++
 arch/openrisc/kernel/kprobes.c                | 400 ++++++++++++++++++
 arch/openrisc/kernel/rethook.c                |  32 ++
 arch/openrisc/kernel/rethook.h                |   8 +
 arch/openrisc/kernel/rethook_trampoline.S     |  97 +++++
 arch/openrisc/kernel/setup.c                  |   4 +
 arch/openrisc/kernel/tests/Makefile           |   3 +
 arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++
 arch/openrisc/kernel/tests/test_kprobes.h     |  24 ++
 arch/openrisc/kernel/tests/test_kprobes_asm.S | 147 +++++++
 arch/openrisc/kernel/traps.c                  |  82 ++--
 arch/openrisc/lib/memcpy.c                    |   2 +
 arch/openrisc/lib/memset.S                    |   4 +
 arch/openrisc/mm/fault.c                      |   5 +
 samples/kprobes/kprobe_example.c              |   8 +
 27 files changed, 1152 insertions(+), 51 deletions(-)
 create mode 100644 arch/openrisc/include/asm/asm.h
 create mode 100644 arch/openrisc/include/asm/break.h
 create mode 100644 arch/openrisc/include/asm/kprobes.h
 create mode 100644 arch/openrisc/kernel/insn.c
 create mode 100644 arch/openrisc/kernel/kprobes.c
 create mode 100644 arch/openrisc/kernel/rethook.c
 create mode 100644 arch/openrisc/kernel/rethook.h
 create mode 100644 arch/openrisc/kernel/rethook_trampoline.S
 create mode 100644 arch/openrisc/kernel/tests/Makefile
 create mode 100644 arch/openrisc/kernel/tests/test_kprobes.c
 create mode 100644 arch/openrisc/kernel/tests/test_kprobes.h
 create mode 100644 arch/openrisc/kernel/tests/test_kprobes_asm.S

-- 
2.55.0

