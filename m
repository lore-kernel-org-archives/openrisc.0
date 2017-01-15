From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Jan 2017 17:36:45 +0900
Subject: [OpenRISC] [PATCH 00/22] Openrisc patchees from backlog for 4.11
In-Reply-To: <513f6ecd-3ace-56e4-f83a-6efa4153b380@roeck-us.net>
References: <cover.1484432596.git.shorne@gmail.com>
 <513f6ecd-3ace-56e4-f83a-6efa4153b380@roeck-us.net>
Message-ID: <20170115083645.GI25986@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Guenter,

On Sat, Jan 14, 2017 at 09:17:01PM -0800, Guenter Roeck wrote:
> On 01/14/2017 03:07 PM, Stafford Horne wrote:
> > Hi All,
> > 
> > This is another set of patches which I have been pulling out of the
> > openrisc backlogs. Its a bit of a process since I need to cleanup commit
> > messages, review and test the patches.
> > 
> > The interesting things here are:
> >  - optimized memset and memcpy routines, ~20% boot time saving
> >  - support for cpu idling
> >  - adding support for l.swa and l.lwa atomic operations (in spec from 2014)
> >  - use atomics to implement: bitops, cmpxchg, futex, spinlocks
> >  - the atomics are in preparation for SMP support
> > 
> > Testing:
> > I have used the kselftests to validate the changes especially the futex
> > operations with the futex test. Other atomic operations are common so no
> > explicit testing.
> > 
> > Note for testers:
> > The l.swa and l.lwa emulation is broken in qemu openrisc port. I have sent
> > patches [1] to qemu-devel to fix the qemu issues.
> > 
> 
> Thanks a lot for the note. Cherry-picked and applied ...
> 
> Are you going to add the series to -next ? That would give it some automatic
> test exposure (including the various auto-builders).

Yes, I was planning to push to my next branch, but I wanted to make sure
I sent this note on qemu before pushing it because I was sure it would
break.

Also, as found by the build robots a late version toolchain would also
be required to build/test these.

Let me know if there is an issue or if you need any help with this.

:: or1k-musl-linux- chain ::

Get it here:
https://github.com/openrisc/or1k-gcc/tree/musl-5.4.0/gcc
  - build using
    https://github.com/openrisc/musl-cross
    (would suggest my pull request - will merge soon
     https://github.com/openrisc/musl-cross/pull/1)

OR

:: or1k-elf- chain ::

Get it here:
  https://github.com/openrisc/or1k-gcc/tree/or1k-5.4.0/gcc
  - build using baremetal/newlib
    https://github.com/openrisc/newlib
  - instructions
    http://openrisc.io/newlib/building.html

> Anyway, today's -next gets a warning traceback as attached. That happens even
> with the above mentioned patch applied to qemu.

Oh, I didnt see this.  I will look into it, thanks for highlighting. I
havent started testing -next yet.

-Stafford

> OpenRISC Linux -- http://openrisc.io
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:198 0xc02d758c
> static_key_slow_inc used before call to jump_label_init
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.10.0-rc3-next-20170113 #1
> Stack dump [0xc0385f3c]:
> sp + 00: 0xc0385f3c
> sp + 04: 0xc0385f60
> sp + 08: 0xc047a0b4
> sp + 12: 0xc0303662
> sp + 16: 0x00000000
> sp + 20: 0xc02d758c
> sp + 24: 0x00000009
> sp + 28: 0x000000c6
> sp + 32: 0xc0167bc0
> sp + 36: 0xc0385f68
> sp + 40: 0xc000b5d8
> sp + 44: 0x00000000
> sp + 48: 0x00000000
> sp + 52: 0xc0303662
> sp + 56: 0x000000c6
> sp + 60: 0xc02d758c
> sp + 64: 0xc0385f9c
> sp + 68: 0xc0385fb0
> sp + 72: 0xc0483954
> sp + 76: 0xc04839b0
> sp + 80: 0xc1fff1e0
> sp + 84: 0xc047a00c
> sp + 88: 0x00000000
> sp + 92: 0xc000b620
> sp + 96: 0xc030367f
> sp + 100: 0xc0385fb0
> sp + 104: 0xc0385fb0
> sp + 108: 0xc0483930
> sp + 112: 0xc02d758c
> sp + 116: 0xc02e1cc4
> sp + 120: 0x00000000
> sp + 124: 0x00000000
> sp + 128: 0xc03a6798
> sp + 132: 0xc0385fd8
> sp + 136: 0xc047a014
> sp + 140: 0xc047a02c
> sp + 144: 0xc03beb14
> sp + 148: 0xc1fff1e0
> sp + 152: 0xc03a68e0
> sp + 156: 0xc02e0070
> sp + 160: 0xc03b9e74
> sp + 164: 0xc03beb14
> sp + 168: 0xc0386000
> sp + 172: 0x00000000
> sp + 176: 0x00000000
> sp + 180: 0x00000000
> sp + 184: 0x00000000
> sp + 188: 0x00000000
> sp + 192: 0x00000000
> 
>  [<c02d758c>]
> 
>  [<c0167bc0>]
> 
>  [<c000b5d8>]
> 
>  [<c02d758c>]
> 
>  [<c000b620>]
> 
>  [<c02d758c>]
> 
>  [<c03a6798>]
> 
>  [<c03a68e0>]
> 
>  [<c03b9e74>]
> 
>  =======================
> ---[ end trace 0000000000000000 ]---
