From: Stafford Horne <shorne@gmail.com>
Date: Wed, 1 Feb 2017 19:04:23 +0900
Subject: [OpenRISC] [Qemu-devel] [PATCH] target-openrisc: Fix exception
 handling status registers
In-Reply-To: <ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
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
Message-ID: <20170201100423.GE21641@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jan 26, 2017 at 09:26:55AM -0800, Richard Henderson wrote:
> On 01/26/2017 05:12 AM, Stafford Horne wrote:
> > I just sent you a mail with a link to my kernel for download.
> > 
> > One thing I noticed is you passed '-append console=ttyS0' I think that
> > does nothing on openrisc since as far as I know openrisc only gets boot
> > params from the device tree file. I tried with and without it and got no
> > differences.
> 
> That was just reflex, wondering where the output went.
> 
> > Another thing, I am using a 'late' version of gcc built with musl cross [1]
> > , I dont think it would make a difference, but maybe?
> 
> I think that's likely the difference.  I can indeed boot your kernel.

Hi Richard,

For kernel builds I have created toolchain binaries here:

  http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/

These should work.

If all is ok with the qemu patch I sent what is the next step to get them
incorporated.  Do you need any help from me?

... Actually I just checked your branch on github, it looks like you are
doing a few updates.  Let me know if you want me to review anything.

-Stafford
