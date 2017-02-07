From: Richard Henderson <rth@twiddle.net>
Date: Mon, 6 Feb 2017 21:53:26 -0800
Subject: [OpenRISC] [Qemu-devel] [PATCH] target-openrisc: Fix exception
 handling status registers
In-Reply-To: <20170201100423.GE21641@lianli.shorne-pla.net>
References: <CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
 <20170114080435.GF25986@lianli.shorne-pla.net>
 <20170120163918.GD7836@lianli.shorne-pla.net>
 <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
 <20170124102625.GF7836@lianli.shorne-pla.net>
 <01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
 <20170125123430.GG7836@lianli.shorne-pla.net>
 <39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
 <20170126131229.GB16014@lianli.shorne-pla.net>
 <ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
 <20170201100423.GE21641@lianli.shorne-pla.net>
Message-ID: <d3dac109-ad39-8bb9-2012-f7a6824139eb@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 02/01/2017 02:04 AM, Stafford Horne wrote:
> For kernel builds I have created toolchain binaries here:
>
>   http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/
>
> These should work.

This gdb crashes on the first "stepi" that I issue.  To reproduce,

$ cat z.c
int main() { return 0; }
$ or1k-musl-linux-gcc -g z.c
$ qemu-or32 -g 10001 ./a.out

// another window

$ or1k-musl-linux-gdb ./a.out
(gdb) target remote localhost:10001
// should see that the pc is at _start
(gdb) stepi
// crash

I won't be able to debug this myself until I can build my own gdb.


r~
