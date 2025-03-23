Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0DB3D561;
	Sun, 23 Mar 2025 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742770394; cv=none; b=LDGUVFFSo1krhIJ2JNejgjCOEvH++lvg7obz+Y6x5kcSKvs3WFhoDCGRKzK/M7Cko2NMf7Ff1skdB7RgXWzMg9I293r2usb6XG9eZHs44mRG2iRSmhyo2qBgMvg1BZ+Rz01Vu5jEOXzP2WQgGaNZqPtXVJLw8zMXcM3qD4xDpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742770394; c=relaxed/simple;
	bh=KhSk1Wvn41RLE8OuIrS/dgnj4mzOEt2b86JUmA1AdQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxpFQgXRNkB80LDZDwO6jJSjlZ+KNHU/iXA3HeB9f4+5vJtipnUkQS65JPk2qUbayrNrYl1YgNCsGBPhzhOYDxumXqIQSF/3EQov9XosVOgkjG68yolHfiHYwJHuRyH2ZY0FK1l+/z958dyXC6KKJWIL+DZHXHamt9G4tTgRCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cme1o9pR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cme1o9pR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742770392; x=1774306392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KhSk1Wvn41RLE8OuIrS/dgnj4mzOEt2b86JUmA1AdQU=;
  b=Cme1o9pRxFFzpJXb1mPGzHhPCiw2+J4ToV/8X/b/2IL7MAhkzgDrnbal
   m+B97Hy5XuJZAPZ6eaZZDRO/EKbYUH4Y8vn8cpAfihXaukoQDDfEC+VUX
   yIineOdj0CLEEBdRpJ7qIsY4P1y49Qo5kS1Qk+xsVOHEk9LiENyVEVcLw
   gSP0ufhS/ZsE35cox+D/AQpYm0igjOCffI2OIR0vPGax7DgxjDeyasRNM
   ACKgSdXOLWtgjluLs7NCvNIpss8DWWzL1iMyQ7yezuMg75SDKiMKXUYcE
   SWIcEcq+Qy9tk9C2Sq/g7yARVa5U50AH6Ybr7T60TyL6I6D8ZHkhdrF+9
   A==;
X-CSE-ConnectionGUID: 4Un8atEJR8K8x/LMR4Ajyg==
X-CSE-MsgGUID: M8eEvCnuRyGHjVduQY5DkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="43126625"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="43126625"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 15:53:11 -0700
X-CSE-ConnectionGUID: +0cn+hIKQ8iIclIM6QNmXg==
X-CSE-MsgGUID: Fg+EMCiuSdiFWevV8B18Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="154783741"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 23 Mar 2025 15:53:09 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twUBm-0002zq-0f;
	Sun, 23 Mar 2025 22:53:06 +0000
Date: Mon, 24 Mar 2025 06:52:21 +0800
From: kernel test robot <lkp@intel.com>
To: Sahil Siddiq <icegambit91@gmail.com>, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] openrisc: Add cacheinfo support
Message-ID: <202503240635.ir63jqTI-lkp@intel.com>
References: <20250323195544.152948-4-sahilcdq@proton.me>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323195544.152948-4-sahilcdq@proton.me>

Hi Sahil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ea1413e5b53a8dd4fa7675edb23cdf828bbdce1e]

url:    https://github.com/intel-lab-lkp/linux/commits/Sahil-Siddiq/openrisc-Refactor-struct-cpuinfo_or1k-to-reduce-duplication/20250324-035738
base:   ea1413e5b53a8dd4fa7675edb23cdf828bbdce1e
patch link:    https://lore.kernel.org/r/20250323195544.152948-4-sahilcdq%40proton.me
patch subject: [PATCH v3 3/3] openrisc: Add cacheinfo support
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20250324/202503240635.ir63jqTI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250324/202503240635.ir63jqTI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503240635.ir63jqTI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/openrisc/kernel/setup.c: In function 'show_cpuinfo':
>> arch/openrisc/kernel/setup.c:266:30: warning: unused variable 'cpuinfo' [-Wunused-variable]
     266 |         struct cpuinfo_or1k *cpuinfo = v;
         |                              ^~~~~~~


vim +/cpuinfo +266 arch/openrisc/kernel/setup.c

9d02a4283e9ce4 Jonas Bonn          2011-06-04  260  
9d02a4283e9ce4 Jonas Bonn          2011-06-04  261  static int show_cpuinfo(struct seq_file *m, void *v)
9d02a4283e9ce4 Jonas Bonn          2011-06-04  262  {
8e6d08e0a15e7d Stefan Kristiansson 2014-05-11  263  	unsigned int vr, cpucfgr;
8e6d08e0a15e7d Stefan Kristiansson 2014-05-11  264  	unsigned int avr;
8e6d08e0a15e7d Stefan Kristiansson 2014-05-11  265  	unsigned int version;
8e6d08e0a15e7d Stefan Kristiansson 2014-05-11 @266  	struct cpuinfo_or1k *cpuinfo = v;
9d02a4283e9ce4 Jonas Bonn          2011-06-04  267  
9d02a4283e9ce4 Jonas Bonn          2011-06-04  268  	vr = mfspr(SPR_VR);
8e6d08e0a15e7d Stefan Kristiansson 2014-05-11  269  	cpucfgr = mfspr(SPR_CPUCFGR);
8e6d08e0a15e7d Stefan Kristiansson 2014-05-11  270  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
