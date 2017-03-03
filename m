From: Richard Henderson <rth@twiddle.net>
Date: Fri, 3 Mar 2017 15:50:23 +1100
Subject: [OpenRISC] gcc7 port and improvements
In-Reply-To: <20170303040803.GZ2449@lianli.shorne-pla.net>
References: <93ad6594-b3f1-5a4f-14d4-f45cb72229f5@twiddle.net>
 <4bfff4c5-fdea-563b-3b84-340b1bc6b708@twiddle.net>
 <20170303040803.GZ2449@lianli.shorne-pla.net>
Message-ID: <d38310f3-c5ca-3616-5fb6-3bcca6f57e5d@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 03/03/2017 03:08 PM, Stafford Horne wrote:
> On Fri, Mar 03, 2017 at 09:14:17AM +1100, Richard Henderson wrote:
>> On 02/23/2017 12:01 PM, Richard Henderson wrote:
>>> If this goes well, I have some additional patches to revive that enhance both
>>> binutils and gcc with additional relocations so that the low-part of an address
>>> can be moved into a load or store offset.
>>
>> Please see
>>
>>   git://github.com/rth7680/binutils-gdb.git or1k-3
>>   git://github.com/rth7680/gcc.git or1k-7-1
>
> It looks like you rebased this on my binutils-gdb or1k-upstream branch.
> Sorry, but I often blow that away with rebase.  I didnt realize other
> would be pulling from there :)

:-)  It's fine.  I based it on the upstream branch because I build 
gcc+binutils+gdb in a combined tree, and wanted a version of the gdb patches 
that work.  It's easy enough for me to rebase back to master once your patches 
are upstream.

> Also, I see you have fixed up the 64-bit target as well.  Does anyone
> use openrisc 64-bit?  I remember hearing there is no soft core.  I ask
> because I was considering removing the 64bit gdb/sim code since as far
> as I can see its not complete, and probably should be a separate sim on
> its own as per the gdb/sim's go. Any issues let me know.

Once upon a time I started trying to extend the toolchain to support 64-bit.  I 
had also started trying to extend qemu to support 64-bit.

The only bits of that which haven't rotted to uselessness are those couple of 
patches for the assembler.  They could be dropped easily enough, if we simply 
don't care.


r~
