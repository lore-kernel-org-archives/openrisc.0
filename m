Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A11B1418
	for <linux-openrisc@vger.kernel.org>; Thu, 29 Aug 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946058; cv=none; b=s7A9PArzP+n8coCqstej60xp4JbTOyLTJZHz6EOEhSfjZV3XhiTfcbAxfWSoAy1OMvwhcnHS8sWgLA2lPURhHdpVZFiPT5eqPYkpKT+lIFo5LMvEuZS2v3xTmv84lBaP+iN6/+xfDwLbijwU+DU6bqf9Jl0pfcxWBB+P9B6IDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946058; c=relaxed/simple;
	bh=CL+2ptcOY3WBkXfo78ZdAQc0B30zxbm+AQ+VMr8wMVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay8l2FxLYztE3sSYOW3oHZpxF9WrKnpmns2cuE7vs0Wv6+dPumFMV4Dbqd3BjffWFVrezvvPFJi7wDsa2AJH5jXJymcbPWW+e+t0+7OZ+rHIU363tTXpeH0dJBahhCCEWX2wrWHO4C1zKm4392Gy5y+Q/vVpeBOkhtE0IvhgVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kywyl5m3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kywyl5m3"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8684c31c60so99472166b.3
        for <linux-openrisc@vger.kernel.org>; Thu, 29 Aug 2024 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724946055; x=1725550855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERbFzOwVPlGwpXVkv2XYWXs4JWWracOiCiXw9VVI8gg=;
        b=kywyl5m3qy6+AW0rfG+JZHh05PB9UhcssRUI5ShdqB0vCjWOAOiQMq/cdWfBnQDg+H
         Xq916FacWHVYiF/G/xlUI2KIle6fI+R1Ysyo2+C7ely0x6fj9fLDrsNw2T3igTPF2THZ
         atK+t72OpB2qZ+eueKDmYspYee+BKelJT/3pvBTWHucqyHJa8wjaQFL8ibxcAEwo8pfj
         n5annAEdQu8v8qv3r6jGjGYmF90JjLKURYrYrWdjCHAuS8eGr76QsMd7Wjy+XNb0O5Yl
         5YDxzl+ccg6ktffobudJo/ZzrSCveKS0uWc6QWx8QG4ltorbWk+7UM4NJsjpC9F8YPJY
         USaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946055; x=1725550855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERbFzOwVPlGwpXVkv2XYWXs4JWWracOiCiXw9VVI8gg=;
        b=O07d5SBc9WNHJAlqbe7a375ywuLT9VgOk5jItSnAxFFpSgdbOn63Zsb0e3v2UWA4ww
         VfNEjp869aE0hXr9fD1OrsuXuVY/jBL0v+mMeFYyC8FzO4CxyuwGZhqAoi/9mUoW8yPE
         7HufkpCVat3kqlxEEmBLaHhNXvrL2nBMcgtB87pu6WTcmVnS6NegA8+1GWSgjd8nSIrA
         SAUolxqEr2adqcDLoy3ami0f+KC7oD/HrxHPSwWWMg3PcolSfcx4z8eCuQEjH1GE0s+Z
         7nYS5UmQJIG3BRE4798FgsTxiX3ubx0r9bL6U80q6rz3T5cDwd8uCL9f7TqaDmWOt5kY
         PFKA==
X-Forwarded-Encrypted: i=1; AJvYcCVzts+nRR64EiJQZI+1x6HqdXtGeAAzJU/P1iHINHoPOFGwUqSkAUhRyCYOBeoXjcMhE6UeWp/metWKTAV00A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7nVn+hXWoPaev9fGXFrKOI2iMtankywYMAo1Qq873eSG+Rxz
	W1osdNb7u01xPv5aYft9YYlsh80XcAuzO3KC4sAKTQJvPZg/a0J5qIiGwQ==
X-Google-Smtp-Source: AGHT+IHXWUl93EzdzAUbMUJfW464wG9ArFmqcJl0AGwHaswWIB5XtR5xZoh8agZ8gjePnVcEXVw8Tg==
X-Received: by 2002:a17:907:7f1f:b0:a86:a090:5caa with SMTP id a640c23a62f3a-a897f8e2be2mr297923666b.34.1724946054498;
        Thu, 29 Aug 2024 08:40:54 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f7bsm91974566b.157.2024.08.29.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:40:53 -0700 (PDT)
Date: Thu, 29 Aug 2024 16:40:52 +0100
From: Stafford Horne <shorne@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>, qemu-devel@nongnu.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Message-ID: <ZtCWhGD8vIv1e88a@antec>
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec>
 <ZssWudpcVotQWr45@zx2c4.com>
 <CAFEAcA95TEA-5Mq9n9+Mva0r-W040A-nt9doCmPg7xW+dU3E2w@mail.gmail.com>
 <Zs4grgFlhYFMjO4j@antec>
 <CAFEAcA-ty1FDvjK+p+CtYVQcWVzgrNTW4jcamWFEbYgHkgXLuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ty1FDvjK+p+CtYVQcWVzgrNTW4jcamWFEbYgHkgXLuA@mail.gmail.com>

On Wed, Aug 28, 2024 at 04:38:49PM +0100, Peter Maydell wrote:
> On Tue, 27 Aug 2024 at 19:53, Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Sun, Aug 25, 2024 at 03:09:20PM +0100, Peter Maydell wrote:
> > > On Sun, 25 Aug 2024 at 12:35, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > On Fri, Aug 23, 2024 at 07:28:43AM +0100, Stafford Horne wrote:
> > > > > Also, I will wait to see if Jason has anything to say.
> > > >
> > > > So long as this doesn't change the assignment of the serial ports to
> > > > device nodes in Linux, I don't think this should interfere with much.
> > > > You might want to try it, though.
> > >
> > > It looks like this board already creates the fdt /aliases/
> > > node and puts uart0, uart1, etc, so that part should be OK.
> > >
> > > However I notice that the openrisc_sim_serial_init() code
> > > will always set the /chosen/stdout-path, so this means
> > > (unless I'm misreading the code -- I haven't tested) that
> > > the last UART we create will be the stdout-path one. Before
> > > this patch, that would be serial_hd(0), but after this it
> > > will not be. So I think we probably need to fix this too
> > > in the same patch, so that we only set stdout-path for uart0,
> > > rather than setting it and then overwriting it on all the
> > > subsequent calls. This patch on its own will change the
> > > stdout-path value I think.
> >
> > Hi Peter,
> >
> > I suspected the same and tested the theory.  Now when running linux with
> > or1k-sim machine we get no stdout output from qemu.  Upon debugging and
> > looking at dmesg via gdb I can see the wrong uart is getting setup in
> > Linux:
> >
> >     [    0.080000] workingset: timestamp_bits=30 max_order=17 bucket_order=0
> >     [    0.100000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> >     [    0.110000] printk: legacy console [ttyS0] disabled
> >     [    0.110000] 90000300.serial: ttyS0 at MMIO 0x90000300 (irq = 2, base_baud = 1250000) is a 16550A
> >     [    0.120000] printk: legacy console [ttyS0] enabled
> >     [    0.120000] 90000200.serial: ttyS1 at MMIO 0x90000200 (irq = 2, base_baud = 1250000) is a 16550A
> >     [    0.130000] 90000100.serial: ttyS2 at MMIO 0x90000100 (irq = 2, base_baud = 1250000) is a 16550A
> >     [    0.130000] 90000000.serial: ttyS3 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
> >     [    0.150000] NET: Registered PF_PACKET protocol family
> >     [    0.160000] clk: Disabling unused clocks
> 
> Interesting, that seems to have assigned ttyS0/1/2/3 in the
> reverse order, which suggests it might be ignoring the /aliases/
> nodes entirely? Though that would surprise me, so perhaps
> something else is going on.

This got me thinking, the /aliases/ defined in OpenRISC are "uart0", "uart1"...
this is different than almost everything else which use "serial0", "serial1"...
I don't know why OpenRISC chose to use "uart0" and I think this is an issue.

I tried the patch below.

After switching to the more standard "serial0", ... everything is working well.

It seems only one driver uses device tree alias stem (prefix) "uart" and that is
drivers/tty/serial/bcm63xx_uart.c.  Which we have no intention of supporting.

All other drivers look for aliases using the serial prefix via call:

  of_alias_get_id(np, "serial");.

> For the Arm virt board we ended up taking a conservative
> approach of making sure the UARTs were listed in the dtb
> in the exact same order we'd traditionally done it, for
> the benefit of any guests which didn't honour /aliases/
> or /chosen/stdout-path. But we were thinking more about
> that being old firmware rather than the kernel.

In this case only the openrisc_sim board has been setup with multiple
UARTs.  I think making sure the first/qemu default serial device
stays the same is the most important for this point, which the original patch
fixes.

-Stafford

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index bffd6f721f..2a15a3a4f0 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -250,7 +250,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     void *fdt = state->fdt;
     char *nodename;
     qemu_irq serial_irq;
-    char alias[sizeof("uart0")];
+    char alias[sizeof("serial0")];
     int i;
 
     if (num_cpus > 1) {
@@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         serial_irq = get_cpu_irq(cpus, 0, irq_pin);
     }
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
-                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
+                   serial_hd(uart_idx),
                    DEVICE_NATIVE_ENDIAN);
 
     /* Add device tree node for serial. */
@@ -277,10 +277,13 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", OR1KSIM_CLK_MHZ);
     qemu_fdt_setprop(fdt, nodename, "big-endian", NULL, 0);
 
-    /* The /chosen node is created during fdt creation. */
-    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    snprintf(alias, sizeof(alias), "uart%d", uart_idx);
+    if (uart_idx == 0) {
+        /* The /chosen node is created during fdt creation. */
+        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
+    }
+    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
+
     g_free(nodename);
 }
 
