From: Stafford Horne <shorne@gmail.com>
Date: Sun, 5 Feb 2017 17:43:59 +0900
Subject: [OpenRISC] Linux openrisc init code...
In-Reply-To: <D90E780DD5090A4F9AEBC859615CED770106727209@OXYGEN.aacmicrotec.local>
References: <D90E780DD5090A4F9AEBC859615CED770106727209@OXYGEN.aacmicrotec.local>
Message-ID: <20170205084359.GD32144@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hello Jakob,

On Sat, Feb 04, 2017 at 08:33:45PM +0000, Jakob Viketoft wrote:
> Hello!
> 
> I've already left dealing with Linux on openrisc, but your recent posts sparked a remembrance of couple of bug fixes I've made locally, I might as well share and you can do with that info as you please. :)

I see, any comments or history lessons are appreciated.

> First off is the very initial code in arch/openrisc/head.S:
> As I recall it, r0 isn't actually tied to zero explicitly and the current init code fails in e.g. a simulator. I'd like to change the CLEAR_GPR method to use l.movhi instead and also explicitly clear r0 before using that in any instruction.

I haven't seen this fail before, and I haven't seen a patch before.
Nevertheless, you are right, the architecture doc clearly says:

  R0 should always hold a zero value. It is the responsibility of
  software to initialize it. (This differs from architecture version 0
  which commented on implementation and that it should never be used as a
  destination register – this is no longer specified.)

I also had a look through the mor1kx code and I cant see any place that
r0 is tied to ground, its just another address in the register file.

I will fix it. Thanks.

> The second one I can't find anymore in linux-next, whether it's been removed completely or was only part of Jonas' tree I can't tell, but I thought I'd share anyway. There was a rule to create a dtb-image suitable for u-boot, but it gave the wrong jump-to address in the kernel. Originally it says 0x100 which is reset and which will clear the dtb argument given by u-boot. I corrected this to 0x400000 to be able to do the handover between u-boot and the kernel using different dtb-images based on the board.

I haven't seen any patches related to this either. While we are at it here
is the start code from head.S:

  .org 0x2000
        __HEAD
        .global _start
  _start:
        /* save kernel parameters */
        l.or    r25,r0,r3       /* pointer to fdt */

        /*
         * ensure a deterministic start
         */

        l.ori   r3,r0,0x1
        l.mtspr r0,r3,SPR_SR

        CLEAR_GPR(r1)
        CLEAR_GPR(r2)
        CLEAR_GPR(r3)


As you see above, we accept r3 as a pointer to the dtb image. It is not
cleared.  But, I am not clear where or what you would correct to 0x400000.

Where was the rule to create the u-boot dtb-image? A build option? A
code path?

I haven't really looked into using a bootloader for my own setup yet so
I don't really know all of the details of how it would work.  Do you
perhaps have some example of another cpu that has this setup?

-Stafford

> Best regards,
>
>        /Jakob
> 
> 
> Jakob Viketoft
> Senior Engineer in RTL and embedded software
> 
> ÅAC Microtec AB
> Dag Hammarskjölds väg 48
> SE-751 83 Uppsala, Sweden
> 
> T: +46 702 80 95 97
> http://www.aacmicrotec.com
