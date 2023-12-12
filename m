Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="0kjqjC+p"
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA79D9
	for <linux-openrisc@vger.kernel.org>; Tue, 12 Dec 2023 02:10:35 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d9e756cf32so3376627a34.2
        for <linux-openrisc@vger.kernel.org>; Tue, 12 Dec 2023 02:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1702375834; x=1702980634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICe4uBOOoZlxUOKaXroa5h8h65N+h/1BrB9RDHFKL/s=;
        b=0kjqjC+pDLdIuJ41g8nRKb+LQle/+9Z+F/mqpzJ/nua/dKjdKsEXDr1xM+2v0z2++V
         YMBRBo2P7E5+EAoHkmi57rsqpRPP6Khfd7tb1kQDXkhXVb7YT65HFMJouvXZdWt3NCGu
         LXeUMsVPCBZEe9WwlZpB5+9eBf66buxdKayBT0fLr0w+6FObwfSvY0pejMZx9jjoiXei
         GI7cVXbgoMyGOxHknjeoqog4iNt3O8o5dmuCh5I0cO+jYfpiwTaWWqtX/+/Vn99gjQGs
         I4l1AI9+BgU3q+a/8WXSpdagLw+GWNNz7W7kSjslBP7ZaMdmcYEOqkfBHAmHmoLg4gIw
         KFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375834; x=1702980634;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ICe4uBOOoZlxUOKaXroa5h8h65N+h/1BrB9RDHFKL/s=;
        b=Qxco9oRt3DGgY8CHKeEKcRGnKzwBf6+HsqqkZZwdV5VZ3s63v5qucJR3rpWUgx+C3H
         v0YUEXP9akgPWkFR83IdGsrWhjF8vuS/a2UZLKhTADgLnpUG2lyPJbPh7lhWKIbNCTbm
         o/R0cHtMPKQ7rmQ5yLRLVr/Myt6S7c2ELaOGmc+7B6GZY8/+Ir07cRPdoiahrZBzWirk
         uW7RsENziVxkBQ3OFDZX4au22qDag9CBGPJ8a1wHIuG+lYd4k2FTQHLrImS/xWP2K7Nk
         yOhFkflkbLTHWW3/IfNMVLXwv+ANrAOY05IHD1A0F9aLHdF1S/a0eAzds7JAI7qNMnPx
         qWTQ==
X-Gm-Message-State: AOJu0YxUgrhdnuDbc1A9K3gaDzVANrK0Ovyg65pba7+QYjjoe59FU7hu
	Y1ALTx+GJdz7eaMv+pFnyL4o6XEww74yfR6M4zg=
X-Google-Smtp-Source: AGHT+IH+lLPG7/nUIXoJffdiS2EhqNhTn8XcWzirG3levchQ6Pk8vy5Jz+l4FSby+pz7ty/E8vnZnw==
X-Received: by 2002:a9d:740a:0:b0:6d8:2909:7bd7 with SMTP id n10-20020a9d740a000000b006d829097bd7mr5491533otk.34.1702375834622;
        Tue, 12 Dec 2023 02:10:34 -0800 (PST)
Received: from ?IPV6:2607:fb90:e600:8489:98cb:fff:fef3:5e24? ([2607:fb90:e600:8489:98cb:fff:fef3:5e24])
        by smtp.gmail.com with ESMTPSA id c8-20020a9d7848000000b006d99c53f745sm2129778otm.77.2023.12.12.02.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 02:10:34 -0800 (PST)
Message-ID: <79b2561e-3167-9758-8196-f2470aec06f7@landley.net>
Date: Tue, 12 Dec 2023 04:16:15 -0600
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: linux-openrisc@vger.kernel.org
From: Rob Landley <rob@landley.net>
Subject: Adding or1k support to mkroot.
Cc: Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Toybox has a tiny system builder in it, a ~300 line bash script that builds
Linux for a dozen targets (using musl-cross-make toolchains) and boots the
result to a shell prompt under QEMU:

https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh
https://landley.net/bin/mkroot/latest/

And since musl and qemu both support openrisc (and I need an or1k toolchain
anyway for my orange pi 3b's power controller firmware, at least according to
u-boot's board/sunxi/README.sunxi64), I thought I'd try to make that target work.

I built an or1k musl+gcc toolchain with my wrapper script around Rich Felker's
musl-cross-make project by adding "or1k::" to the TARGETS list in
https://github.com/landley/toybox/blob/master/scripts/mcm-buildall.sh#L34 and
that seems to have worked-ish. (Well, the kernel headers didn't install because
I have to add or1k->openrisc to musl-cross-make's TARGET_ARCH_MANGLED in
litecross/Makefile, but eh, close enough for the moment.)

With the resulting toolchain, I can build an or1ksim_defconfig kernel (using
v6.6 source) that "qemu-system-or1k -nographic -kernel vmlinux" gives boot
messages for! Woo! (And then panics because no init, but that's standard for
board bringup.)

Some immediately obvious problems are:

1) qemu's -append is ignored, the "Kernel command line: earlycon" is hardwired
into the device tree.

2) Nothing I do seems to get qemu to exit instead of hanging,
CONFIG_PANIC_TIMEOUT=1 makes it _try_ to reboot but adding the CONFIG_POWER
symbols from arch/openrisc/configs/virt_defconfig doesn't seem to affect qemu,
and none of the other targets mention power. (If I can't exit the emulator at
the end then https://github.com/landley/toybox/blob/master/mkroot/testroot.sh
can't report success for the architecture.)

3) If I feed qemu-system-or1k an -initrd the same kernel does NOT give me boot
messages, it just hangs.

Well, SORT OF. If I feed -initrd 2 megabytes copied from /dev/null by dd, I get
boot messages. If I go "true | gz > blah.gz" to create the smallest (20 byte) gz
file and feed it that, no boot messages. Feed it System.map: boot messages. Feed
it vmlinux: no boot messages.

Any idea what's going on here? That last one's kind of a blocker...

Thanks,

Rob
