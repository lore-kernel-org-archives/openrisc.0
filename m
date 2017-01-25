From: Richard Henderson <rth@twiddle.net>
Date: Wed, 25 Jan 2017 09:27:29 -0800
Subject: [OpenRISC] [Qemu-devel] [PATCH] target-openrisc: Fix exception
 handling status registers
In-Reply-To: <20170125123430.GG7836@lianli.shorne-pla.net>
References: <20170113215720.29598-1-shorne@gmail.com>
 <20170113220252.GE25986@lianli.shorne-pla.net>
 <CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
 <20170114080435.GF25986@lianli.shorne-pla.net>
 <20170120163918.GD7836@lianli.shorne-pla.net>
 <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
 <20170124102625.GF7836@lianli.shorne-pla.net>
 <01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
 <20170125123430.GG7836@lianli.shorne-pla.net>
Message-ID: <39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 01/25/2017 04:34 AM, Stafford Horne wrote:
> Hmm, I just tried your qemu branch and mine:
> 
>   git at github.com:stffrdhrn/qemu.git or1k-fix-sigill
> 
> Both of them were able to boot fine.
> 
> The opencores,or1200-rtlsvn481 cpu node is in the or1ksim device tree
> definition.  Are you sure your kernel config has this in it?
> 
>   CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"
> 
> Could you send your kernel config?
> 
> I have attached mine, just in case.  For next-20170124

Curious.  The entire diff between our configs is just

--- ../or-config        2017-01-24 09:14:51.918059107 -0800
+++ .config     2017-01-25 09:18:14.153999754 -0800
@@ -18,7 +18,7 @@
 #
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-CONFIG_CROSS_COMPILE="or1k-linux-musl-"
+CONFIG_CROSS_COMPILE="or1k-musl-linux-"
 # CONFIG_COMPILE_TEST is not set
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y

So you're saying you *do* get serial port output?

Perhaps you can just send me your kernel...


r~
