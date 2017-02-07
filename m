From: Richard Henderson <rth@twiddle.net>
Date: Mon, 6 Feb 2017 21:48:18 -0800
Subject: [OpenRISC] [Qemu-devel] [PATCH] target-openrisc: Fix exception
 handling status registers
In-Reply-To: <20170207003108.GF32144@lianli.shorne-pla.net>
References: <20170124102625.GF7836@lianli.shorne-pla.net>
 <01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
 <20170125123430.GG7836@lianli.shorne-pla.net>
 <39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
 <20170126131229.GB16014@lianli.shorne-pla.net>
 <ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
 <20170201100423.GE21641@lianli.shorne-pla.net>
 <c840eff0-2be7-07d7-eae9-4cded569d146@twiddle.net>
 <20170202143455.GB32144@lianli.shorne-pla.net>
 <e9f58f51-4cca-6136-d392-91c805d5631d@twiddle.net>
 <20170207003108.GF32144@lianli.shorne-pla.net>
Message-ID: <a6cf2670-bcc8-93e3-0d27-72c775d44c4b@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 02/06/2017 04:31 PM, Stafford Horne wrote:
> Could you send your bld-or/config.log?  At least the first 10 lines?

  ../comb-or/configure --target=or1k-linux-musl \
    --prefix=/home/rth/work/gcc/run-cross \
    --with-sysroot --disable-multilib

I'll note that the or1k-musl-linux that you use is technically incorrect -- the 
libc tag is supposed to go last.  C.f. arm-linux-{android,uclibc}.

> Also which branch are you using to build?

https://github.com/openrisc/binutils-gdb.git or1k

commit 5a0933b80d3d5d6345573a237c9eebb780ccbcbf
Merge: 2aef93c 7db7d93
Author: Stefan Wallentowitz <stefan@wallentowitz.de>
Date:   Wed Jun 8 12:06:13 2016 +0200

I also tried the gdb-7.11-or1k branch.


r~
