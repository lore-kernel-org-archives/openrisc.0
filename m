From: Richard Henderson <rth@twiddle.net>
Date: Wed, 8 Feb 2017 12:38:56 -0800
Subject: [OpenRISC] [Qemu-devel] [PATCH] target-openrisc: Fix exception
 handling status registers
In-Reply-To: <20170208140120.GI32144@lianli.shorne-pla.net>
References: <20170120163918.GD7836@lianli.shorne-pla.net>
 <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
 <20170124102625.GF7836@lianli.shorne-pla.net>
 <01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
 <20170125123430.GG7836@lianli.shorne-pla.net>
 <39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
 <20170126131229.GB16014@lianli.shorne-pla.net>
 <ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
 <20170201100423.GE21641@lianli.shorne-pla.net>
 <d3dac109-ad39-8bb9-2012-f7a6824139eb@twiddle.net>
 <20170208140120.GI32144@lianli.shorne-pla.net>
Message-ID: <4482270c-66f0-3338-0fa0-ed292f80a508@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 02/08/2017 06:01 AM, Stafford Horne wrote:
> On Mon, Feb 06, 2017 at 09:53:26PM -0800, Richard Henderson wrote:
>> On 02/01/2017 02:04 AM, Stafford Horne wrote:
>>> For kernel builds I have created toolchain binaries here:
>>>
>>>   http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/
>>>
>>> These should work.
>>
>> This gdb crashes on the first "stepi" that I issue.  To reproduce,
>>
>> $ cat z.c
>> int main() { return 0; }
>> $ or1k-musl-linux-gcc -g z.c
>> $ qemu-or32 -g 10001 ./a.out
>>
>> // another window
>>
>> $ or1k-musl-linux-gdb ./a.out
>> (gdb) target remote localhost:10001
>> // should see that the pc is at _start
>> (gdb) stepi
>> // crash
>>
>> I won't be able to debug this myself until I can build my own gdb.
>
> Hello,
>
> The gdb branch I use is the following, it is tracking very close to
> upsstream:
>
>   git at github.com:stffrdhrn/binutils-gdb.git or1k-upstream
>
> I have sent this for review to the gdb list and currently waiting on
> comments for version 4.  Most of the code is the same as in openrisc
> github. However, I have just rebased and cleaned up for upstreaming.

Thanks.  I can confirm that I have no problems building this branch.

> However, when debugging I ran into a few errors.
>
>   1. qemu aborts the program and sends SIGILL to gdb, this is caused by
>      the openrisc loop in linux-user missing handlers for EXCP_INTERRUPT
>      and EXCP_DEBUG, I patched that see below:

Yes, I fixed that on my or1k branch Monday.


r~
