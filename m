Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD81D79B4
	for <linux-openrisc@vger.kernel.org>; Sat, 25 Jan 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802436; cv=none; b=qocvE0BW3OEn1w8bTTk9+PUv0SVDGHo1W9fZr0GQI7N4iiimX4azpguB6CQXuL5vfuLFHyy18KBZlRzFkQ4ougigAcGlH0YavI773JSpeFPb/WnLcRdIjLZj34aqznq1vVbynY1+k2OpK7dbo2TKOSaz180Dt45b9QIqOszKQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802436; c=relaxed/simple;
	bh=H1JCUkPYUfjxbM9eCVEM1bxcauPHjkC5a6G7+AlGKec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBXcq3fCgECeV7px+aM+zf8X3r2m/T+UNVIbvl9KHw8MIgZ854PqDyESfihZKtfgyCkDlOrO4AyvsBIbT53i6wfulvXO1ZfonE5Pj3tqETiulBvhrAbNKGEiEUxo5LF34xcoVrznFmsZlfCY2Wv5nfNa6NVedqlPqXIa42sixSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRwXuZkC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRwXuZkC"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38632b8ae71so2288307f8f.0
        for <linux-openrisc@vger.kernel.org>; Sat, 25 Jan 2025 02:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737802432; x=1738407232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvKKCqjg+yXMBoJGMgF8dC1zMDYHSa5MnLRAf/L+e5g=;
        b=kRwXuZkCY+d+I+2scGf2ZVa/szy1gauNV5+WE3EfvpC0NWzEwPwIVXyYGa+hcGyCns
         IIovwRNgaPOTYiTGDUukIqU3tWuEG0TLEXykSV4++awLyBe4D/OhkeSE9GgOyrSrCmpc
         D3J/B7L0wrqgOvefCLuAZsf8UR3shgF2JA7mN15+tmGCFErfsuTXyGibdamfBrcBzCXs
         ZkBh+ddCJ6++9E9VSHC4S6LBhWSqQG8zDxNgCSO0m3pQQ3KrUfp7+0HA6onUyLfjNY2+
         NScNAAY8y3PVY1lUvuuwmDeqP71Gxr5wzU06/MEA+kW31PFbK1Dvx2sH0Sx7qM2eNKJz
         bQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737802432; x=1738407232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvKKCqjg+yXMBoJGMgF8dC1zMDYHSa5MnLRAf/L+e5g=;
        b=jZh/5OifownAdqDrH//hOd1R512k3IAeytTmgLXbkzjBcWhRENhOtKEaU0VyFbnaEk
         7VCDvmSqsvXbiC3JEQd6ZzY5kLpzxPE7dAPqLKqZ656w024WNS1hyy0V9pIAhWtdbkgu
         hepIRrf3gnjhmqEJyBohNAzDOECvIZUqV154P6J+TWU6o9tcVT/Iyr43KSC76A9J+8Ma
         d6PeycJyUNhnJGCjT6AKHQ4/xHnvYWm8dRH5va+VnY7yoqcQy/syYWAY2VjOTAJUYkyo
         Q8AxLQpcgtrAIeRbbJ5/vZoVaVOxBplhUv0SN6HQbT81PsYVoMerFBug+s9UU03VT/qU
         vc5g==
X-Gm-Message-State: AOJu0YyUV5GFYcLV+64NkdPGLc4E5CIrZ4jI4sfbmbSkHf86iV3o6Bx7
	Zwo0D4R8HzrCJEAn+qGYCI7qFQWXM/lshX8zGdT07Hrz95YcXPH3
X-Gm-Gg: ASbGncsIEqyvyOS9EJF/urP4EHTOhLjiZn7ErpVFqHpDwaV8fU/9NMEVPhLFgRbc251
	soR4TKEOKx1E4jybTXPzbJsjDKykDbaF5BIQXB2y7WfTaOBJBMihpoIm+SJiQDvqJqKpGZMUyg1
	PUS3WHkercAPSUET4oNYcdT2GefbENiX7iXE0DodVn6KqEanjqbQd2gdJ0QYZgrvo+1sGzaZbk1
	sfUO9+W6EQgSzopQEJ3rmVTyVwHWUFpBoXPCO6HOfhUAnyJ1gM+Zf0lp/jVCgsZmBl85oei11ti
	18pPp+DxLfQ/rBp/TjQVnvRO1FhZdtkv66I9xvofFSuE
X-Google-Smtp-Source: AGHT+IHnv3jYyj3xZa9FrxtK8fkF6pu6i660JEwL8/gEpWb88oEPgsa2G3uTfCHPCdSjOuHivwPiKg==
X-Received: by 2002:a5d:698d:0:b0:38b:d8e0:a862 with SMTP id ffacd0b85a97d-38bf58e8af9mr26037718f8f.43.1737802432261;
        Sat, 25 Jan 2025 02:53:52 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c3f5dsm5356025f8f.92.2025.01.25.02.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:53:50 -0800 (PST)
Date: Sat, 25 Jan 2025 10:53:49 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: Contributing to OpenRISC Linux
Message-ID: <Z5TCvQ66uvKKzoH1@antec>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
 <Z4NvBPYCkz12k0-1@antec>
 <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>
 <Z4SzVtTIuVN7gsX8@antec>
 <1052b18b-7524-49b4-8ac2-22031bf90d4b@gmail.com>
 <Z5STI5WUqCXPwcNF@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5STI5WUqCXPwcNF@antec>

On Sat, Jan 25, 2025 at 07:30:43AM +0000, Stafford Horne wrote:
> On Thu, Jan 23, 2025 at 12:25:59AM +0530, Sahil Siddiq wrote:
> > Hi,
> > 
> > On 1/13/25 12:01 PM, Stafford Horne wrote:
> > > On Mon, Jan 13, 2025 at 11:42:08AM +0530, Sahil Siddiq wrote:
> > > > Hi,
> > > > 
> > > > Thank you for your reply.
> > > > 
> > > > On 1/12/25 12:58 PM, Stafford Horne wrote:
> > > > > Hi Sunil,
> > > > > 
> > > > > +CC List
> > > > > 
> > > > > yes, the cacheinfo task is still open.  There are many things that are still not
> > > > > implemented in OpenRISC, you can always just look under the kernel
> > > > > Documentation/features.
> > > > > 
> > > > > For example:
> > > > > 
> > > > >       < shorne@antec ~/work/linux > grep -r -e openrisc.*TODO Documentation/features | column -t
> > > > >       Documentation/features/vm/huge-vmap/arch-support.txt:                |  openrisc:  |  TODO  |
> > > > >       Documentation/features/vm/ELF-ASLR/arch-support.txt:                 |  openrisc:  |  TODO  |
> > > > >       Documentation/features/vm/ioremap_prot/arch-support.txt:             |  openrisc:  |  TODO  |
> > > > >       Documentation/features/vm/pte_special/arch-support.txt:              |  openrisc:  |  TODO  |
> > > > >       Documentation/features/perf/kprobes-event/arch-support.txt:          |  openrisc:  |  TODO  |
> > > > >       ...
> > > > 
> > > > Got it. I did find this list in the online documentation [1] but I couldn't find
> > > > the cacheinfo task listed there.
> > > 
> > > Right, not all features have config flags that are documented.
> > > 
> > 
> > Understood. Do you know how one finds these flags? I wasn't able
> > to find much related to cpu or caches in arch/openrisc/Kconfig [1].
> > I did find the usage of ARCH_HAS_CPU_CACHE_ALIASING in
> > include/linux/cacheinfo.h [2]. I am not sure if this is relevant.
> 
> Not all features are enabled using ARCH_ flags.  The cacheinfo apis are always
> enabled and compiled, even for or1k now.  But if we look, we see the default
> implementation is defined with __weak symbols:
> 
>   drivers/base/cacheinfo.c
>   include/linux/cacheinfo.h
> 
>     int __weak init_cache_level(unsigned int cpu)
>     {
> 	    return -ENOENT;
>     }
> 
>     int __weak populate_cache_leaves(unsigned int cpu)
>     {
> 	    return -ENOENT;
>     }
> 
> In order for us to add support I think all we will need to do is define these
> functions under arch/openrisc.
> 
> We can look to cpuinfo_or1k for how in openrisc we can pull cache details from
> the UPR registers in (we can maybe just get the info from the cpuinfo_or1k
> structure):
> 
>   arch/openrisc/kernel/setup.c
> 
> You can read about the background of the cacheinfo work and motivations in the
> original patch series:
> 
>   https://lore.kernel.org/all/1412084912-2767-1-git-send-email-sudeep.holla@arm.com/

Hi Sahil,

Also please check these comments [0] from Sudeep Holla and Stefan Kristiansson.

    >> 14/03/17 13:11, Stefan Kristiansson wrote:
    >>> On Tue, Mar 14, 2017 at 12:08:33PM +0000, Sudeep Holla wrote:
    >>>> On Tue, Feb 21, 2017 at 7:11 PM, Stafford Horne <shorne@gmail.com> wrote:
    >>>>> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
    >>>>>
    >>>>> Motivation for this is to be able to print the way information
    >>>>> properly in print_cpuinfo(), instead of hardcoding it to one.
    >>>>>
    >>>>
    >>>> Any particular reason not to use generic cacheinfo sysfs infrastructure ?
    >>>>
    >>>
    >>> No reason as far as I can see, the creation of this patch predates the
    >>> generic cacheinfo sysfs infrastructure.
    >>>
    >>> The patch itself doesn't add cache information to cpuinfo though,
    >>> only corrects a bug in the information that is already there.
    >>>
    >>> We should look into exposing the info in the generic cache info sysfs
    >>> and potentially removing the information from cpuinfo.

-Stafford

[0[] https://lkml.org/lkml/2017/3/14/639

> > > > > How far have you come with OpenRISC so far?  If you haven't already I suggest
> > > > > working through:
> > > > > 
> > > > >    - Get a simulator, I use QEMU for most development as it's faster and supports
> > > > >      more memory than most FPGA.  Final verification can be done on an FPGA.
> > > > >    - Get a working compiler toolchain.
> > > > >    - Compile and boot the openrisc kernel.
> > > > >    - Build a userspace environment, either buildroot, toybox or busybox.
> > > > > 
> > > > > I have some tools to help with this in or1k-utils [1], also there are prebuilt
> > > > > environments and docs in the linux kernel [2] and qemu [3].
> > > > 
> > > > I don't have an environment set up yet. I'll start with the steps above. I'll use
> > > > QEMU for development. I don't have an FPGA with me currently.
> > 
> > I have set up a fairly basic environment. I built both QEMU and
> > openrisc-linux from the master branch. I used a prebuilt compiler
> > toolchain to build openrisc-linux and busybox, and manually
> > created an initramfs image. I used the default configuration
> > options to build linux.
> > 
> > The userspace environment only has utilities that are provided
> > by busybox. Only the following filesystems have been mounted -
> > rootfs, devtmpfs, sys, proc and tmpfs.
> > 
> > I tried to understand the workings of some of the scripts in
> > or1k-utils. There were a few things that I didn't understand
> > and I'll need some more time to wrap my head around them. I
> > don't think this should hinder the cacheinfo task though.
> > 
> > Is there anything else that I'll need to set up in the environment
> > before progressing?
> 
> I think its a good start.  As long as /sys is available in your environment
> it should be enough for you to test your changes.
> 
> > I don't see any cache-related info in /sys. Based on what I have
> > understood, it'll be possible to fetch these details once cacheinfo
> > is supported.
> 
> On my x86 machine I see:
> 
>     $ tree /sys/devices/system/cpu/cpu0/cache/
>     /sys/devices/system/cpu/cpu0/cache/
>     ├── index0
>     │   ├── coherency_line_size
>     │   ├── id
>     │   ├── level
>     │   ├── number_of_sets
>     │   ├── physical_line_partition
>     │   ├── shared_cpu_list
> 
> On or1k I only see (no cache info yet):
> 
>     $ tree /sys/devices/system/cpu/cpu0/
>     /sys/devices/system/cpu/cpu0/
>     |-- of_node -> ../../../../firmware/devicetree/base/cpus/cpu@0
>     |-- subsystem -> ../../../../bus/cpu
>     |-- topology
>     |   |-- core_cpus
>     |   |-- core_cpus_list
>     |   |-- core_id
>     |   |-- core_siblings
>     |   |-- core_siblings_list
>     |   |-- package_cpus
>     |   |-- package_cpus_list
>     |   |-- physical_package_id
>     |   |-- thread_siblings
>     |   `-- thread_siblings_list
>     `-- uevent
> 
> But we do have some cache info available via cpuinfo:
> 
>     $ cat /proc/cpuinfo | head -n16
>     processor               : 0
>     cpu                     : OpenRISC-13
>     revision                : 8
>     frequency               : 20000000
>     dcache size             : 256 bytes
>     dcache block size       : 16 bytes
>     dcache ways             : 1
>     icache size             : 32 bytes
>     icache block size       : 16 bytes
>     icache ways             : 2
>     immu                    : 128 entries, 1 ways
>     dmmu                    : 128 entries, 1 ways
>     bogomips                : 40.00
>     features                : orbis32  orfpx32
> 
> > > > > At the momoment, I am also thinking of what to work on next for OpenRISC, there is:
> > > > > 
> > > > >     - kexec
> > > > >     - jump_label
> > > > >     - kprobes
> > > > >     - perf_events
> > > > >     - ftrace
> > > > 
> > > > Is the virtio task [2] also still a part of the roadmap? I can't find that either
> > > > in the TODO list.
> > > 
> > > The virtio task is still possible but will be more advanced and may need some
> > > architecture changes to support hypervisors.
> > 
> > Got it.
> 
> I am slowly working on kexec support right now.
> 
> -Stafford
