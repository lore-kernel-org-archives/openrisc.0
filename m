Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330519E997
	for <linux-openrisc@vger.kernel.org>; Sat, 25 Jan 2025 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737790251; cv=none; b=EzRodmKs25ADfQXW88ZSDQaSCCCKPlZ+MN1uiBptK66+goA1oT+k22rFm5uVomNHvneuU8Oxon3Fr84sDXGNMtkcdB3DyF9PfTFanid3N4lXcDGvy4MDCnMZNDsFa3ZdtN0+WUyIMsltBlUpa2mn3A9D+gQ59E0icvcMOhlWrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737790251; c=relaxed/simple;
	bh=pJkGoMpbYRjJrTKiwiBs8wgefYnx3Ez2lTFjDDsavRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhSWl7XATUUzfsjDb6onlmMFQNHNZFBcDedSGTBdLyAR9YBm24OBiKH/XgFbdLAGQ5ExE5r/MCzU84q4Qw1N+9YN1wllXxi76nGm7KUNRFuG/zaWIK2J6mtWhFuiTeCpJ8dm6Cft63xLHdPzwPpICuZnQ/MVS+W+Phxyg7IcIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4RZfCNL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4RZfCNL"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43635796b48so18343365e9.0
        for <linux-openrisc@vger.kernel.org>; Fri, 24 Jan 2025 23:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737790248; x=1738395048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AsEFxUt/vh8eZPB4NRZxwLCDoXCcztDqCPpHyPsnTIw=;
        b=T4RZfCNL6mfxHWvZBSeua3kHX4iN3xa0ktns+Kyj8t2UHg/8MebPqTDkbwVLZNzuZc
         XBHTr1xwIFM4bwQL2mRRKWg5sg9P7kEfdirvG9GQuLdesUtKss85WaoqkbGT/cTQGXvw
         YKTL8Odjorj7dYY+E255luxBruNqqEhdluoeNxfQXP4vi7qQ3D5PkjMvW6lXJg/6oNqt
         EPABA6VwBRXANtsI95IzQ20b7j8OYttw2IUOkOBqukfSp8lrX3DTPzjXy6m/HpsZajmB
         FzI7y6xKsE9etWhQcIJlUSzjhRRbHKQBLn1CF5gUdWDnyY0bB+Jghu+SwBVi6Wg8QkrP
         BumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737790248; x=1738395048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsEFxUt/vh8eZPB4NRZxwLCDoXCcztDqCPpHyPsnTIw=;
        b=upVtUepeevNat+qVXH4eeQpZsjOXnTYJ6OxZ18vYxbAFDyHdB6Scapu8fGZboZNKl9
         m51/CDZ9zyZyx3xEbIwXQ6sO9ZxP+4Ev7AlmdnI3KiXhiO47lhAEsJfPG98bUx1Gt19e
         OL69EpUlbfhZohjDedFRpPA4TrwwSqPmw3FnB+iF6j9KAwtr/txDCeClY2iyzth0Gosg
         lI2OPbZK0+RLOyjpZmvUdSCVZ6Onk9mO8tIMAqA9Nv2tKkqYEKXbtiAitI+H+9qlgLkA
         tLeVziW54tLyn0YPSSWOAVjsLniP4Q3KCJlDr1qImvMxjDrjwKE6dbxCF59jd89p5QoO
         jNPw==
X-Gm-Message-State: AOJu0YxZiA107AnUAZ+fUFMGAh99OmujpBaQ+BC5Hbtqe3xHx7HbAIz2
	+wi0bPqK/5pMnePrwGbez/frbUjrGdR7WtFnWZVh9z3044SP267r/fqkZlFy
X-Gm-Gg: ASbGncs/+NAM2cB8Fd87hYOFLbnKtb/ox0h+L858l4dDQQ2b1/D/zYTlfVvY2WEoqWs
	wFwog/BZa9x+JkzGMZHFR/8VNG0J1XNNhP2zVXWuw5hU2tFWAEspRoTuuA33FKVcqD9A1NiJXNz
	VLhbpI5R6jHRfqLV5hzdynJlv1BVq5xv40hcRnuibo1ieM6P2TdhHBEm7m48Qt5IbduDlPwAoRC
	PWCxJOEHFVqJJmii4o8dxxqr6Ro9ig8Q7Li95FI/zVO6FMTrWGT3Yj53u8cj6cWzQ5WN9OEh2zD
	O3BWzlbSowPDowaC6874SMH+q+GMefTAVQpiEX+qxMmM
X-Google-Smtp-Source: AGHT+IFYr4UcWIFsT5jFQSN66xuzp2YluGIML7Bh3kZT6o8JEerMzXRvZcOpR6Lei2z9ua3NwaGvsA==
X-Received: by 2002:a05:600c:154a:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-438bd061259mr54769675e9.4.1737790247732;
        Fri, 24 Jan 2025 23:30:47 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48b000sm53327155e9.20.2025.01.24.23.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 23:30:44 -0800 (PST)
Date: Sat, 25 Jan 2025 07:30:43 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: Contributing to OpenRISC Linux
Message-ID: <Z5STI5WUqCXPwcNF@antec>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
 <Z4NvBPYCkz12k0-1@antec>
 <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>
 <Z4SzVtTIuVN7gsX8@antec>
 <1052b18b-7524-49b4-8ac2-22031bf90d4b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1052b18b-7524-49b4-8ac2-22031bf90d4b@gmail.com>

On Thu, Jan 23, 2025 at 12:25:59AM +0530, Sahil Siddiq wrote:
> Hi,
> 
> On 1/13/25 12:01 PM, Stafford Horne wrote:
> > On Mon, Jan 13, 2025 at 11:42:08AM +0530, Sahil Siddiq wrote:
> > > Hi,
> > > 
> > > Thank you for your reply.
> > > 
> > > On 1/12/25 12:58 PM, Stafford Horne wrote:
> > > > Hi Sunil,
> > > > 
> > > > +CC List
> > > > 
> > > > yes, the cacheinfo task is still open.  There are many things that are still not
> > > > implemented in OpenRISC, you can always just look under the kernel
> > > > Documentation/features.
> > > > 
> > > > For example:
> > > > 
> > > >       < shorne@antec ~/work/linux > grep -r -e openrisc.*TODO Documentation/features | column -t
> > > >       Documentation/features/vm/huge-vmap/arch-support.txt:                |  openrisc:  |  TODO  |
> > > >       Documentation/features/vm/ELF-ASLR/arch-support.txt:                 |  openrisc:  |  TODO  |
> > > >       Documentation/features/vm/ioremap_prot/arch-support.txt:             |  openrisc:  |  TODO  |
> > > >       Documentation/features/vm/pte_special/arch-support.txt:              |  openrisc:  |  TODO  |
> > > >       Documentation/features/perf/kprobes-event/arch-support.txt:          |  openrisc:  |  TODO  |
> > > >       ...
> > > 
> > > Got it. I did find this list in the online documentation [1] but I couldn't find
> > > the cacheinfo task listed there.
> > 
> > Right, not all features have config flags that are documented.
> > 
> 
> Understood. Do you know how one finds these flags? I wasn't able
> to find much related to cpu or caches in arch/openrisc/Kconfig [1].
> I did find the usage of ARCH_HAS_CPU_CACHE_ALIASING in
> include/linux/cacheinfo.h [2]. I am not sure if this is relevant.

Not all features are enabled using ARCH_ flags.  The cacheinfo apis are always
enabled and compiled, even for or1k now.  But if we look, we see the default
implementation is defined with __weak symbols:

  drivers/base/cacheinfo.c
  include/linux/cacheinfo.h

    int __weak init_cache_level(unsigned int cpu)
    {
	    return -ENOENT;
    }

    int __weak populate_cache_leaves(unsigned int cpu)
    {
	    return -ENOENT;
    }

In order for us to add support I think all we will need to do is define these
functions under arch/openrisc.

We can look to cpuinfo_or1k for how in openrisc we can pull cache details from
the UPR registers in (we can maybe just get the info from the cpuinfo_or1k
structure):

  arch/openrisc/kernel/setup.c

You can read about the background of the cacheinfo work and motivations in the
original patch series:

  https://lore.kernel.org/all/1412084912-2767-1-git-send-email-sudeep.holla@arm.com/

> > > > How far have you come with OpenRISC so far?  If you haven't already I suggest
> > > > working through:
> > > > 
> > > >    - Get a simulator, I use QEMU for most development as it's faster and supports
> > > >      more memory than most FPGA.  Final verification can be done on an FPGA.
> > > >    - Get a working compiler toolchain.
> > > >    - Compile and boot the openrisc kernel.
> > > >    - Build a userspace environment, either buildroot, toybox or busybox.
> > > > 
> > > > I have some tools to help with this in or1k-utils [1], also there are prebuilt
> > > > environments and docs in the linux kernel [2] and qemu [3].
> > > 
> > > I don't have an environment set up yet. I'll start with the steps above. I'll use
> > > QEMU for development. I don't have an FPGA with me currently.
> 
> I have set up a fairly basic environment. I built both QEMU and
> openrisc-linux from the master branch. I used a prebuilt compiler
> toolchain to build openrisc-linux and busybox, and manually
> created an initramfs image. I used the default configuration
> options to build linux.
> 
> The userspace environment only has utilities that are provided
> by busybox. Only the following filesystems have been mounted -
> rootfs, devtmpfs, sys, proc and tmpfs.
> 
> I tried to understand the workings of some of the scripts in
> or1k-utils. There were a few things that I didn't understand
> and I'll need some more time to wrap my head around them. I
> don't think this should hinder the cacheinfo task though.
> 
> Is there anything else that I'll need to set up in the environment
> before progressing?

I think its a good start.  As long as /sys is available in your environment
it should be enough for you to test your changes.

> I don't see any cache-related info in /sys. Based on what I have
> understood, it'll be possible to fetch these details once cacheinfo
> is supported.

On my x86 machine I see:

    $ tree /sys/devices/system/cpu/cpu0/cache/
    /sys/devices/system/cpu/cpu0/cache/
    ├── index0
    │   ├── coherency_line_size
    │   ├── id
    │   ├── level
    │   ├── number_of_sets
    │   ├── physical_line_partition
    │   ├── shared_cpu_list

On or1k I only see (no cache info yet):

    $ tree /sys/devices/system/cpu/cpu0/
    /sys/devices/system/cpu/cpu0/
    |-- of_node -> ../../../../firmware/devicetree/base/cpus/cpu@0
    |-- subsystem -> ../../../../bus/cpu
    |-- topology
    |   |-- core_cpus
    |   |-- core_cpus_list
    |   |-- core_id
    |   |-- core_siblings
    |   |-- core_siblings_list
    |   |-- package_cpus
    |   |-- package_cpus_list
    |   |-- physical_package_id
    |   |-- thread_siblings
    |   `-- thread_siblings_list
    `-- uevent

But we do have some cache info available via cpuinfo:

    $ cat /proc/cpuinfo | head -n16
    processor               : 0
    cpu                     : OpenRISC-13
    revision                : 8
    frequency               : 20000000
    dcache size             : 256 bytes
    dcache block size       : 16 bytes
    dcache ways             : 1
    icache size             : 32 bytes
    icache block size       : 16 bytes
    icache ways             : 2
    immu                    : 128 entries, 1 ways
    dmmu                    : 128 entries, 1 ways
    bogomips                : 40.00
    features                : orbis32  orfpx32

> > > > At the momoment, I am also thinking of what to work on next for OpenRISC, there is:
> > > > 
> > > >     - kexec
> > > >     - jump_label
> > > >     - kprobes
> > > >     - perf_events
> > > >     - ftrace
> > > 
> > > Is the virtio task [2] also still a part of the roadmap? I can't find that either
> > > in the TODO list.
> > 
> > The virtio task is still possible but will be more advanced and may need some
> > architecture changes to support hypervisors.
> 
> Got it.

I am slowly working on kexec support right now.

-Stafford
