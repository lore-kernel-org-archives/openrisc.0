From: Jakob Viketoft <jakob.viketoft@aacmicrotec.com>
Date: Sat, 4 Feb 2017 20:33:45 +0000
Subject: [OpenRISC] Linux openrisc init code...
Message-ID: <D90E780DD5090A4F9AEBC859615CED770106727209@OXYGEN.aacmicrotec.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hello!

I've already left dealing with Linux on openrisc, but your recent posts sparked a remembrance of couple of bug fixes I've made locally, I might as well share and you can do with that info as you please. :)

First off is the very initial code in arch/openrisc/head.S:
As I recall it, r0 isn't actually tied to zero explicitly and the current init code fails in e.g. a simulator. I'd like to change the CLEAR_GPR method to use l.movhi instead and also explicitly clear r0 before using that in any instruction.

The second one I can't find anymore in linux-next, whether it's been removed completely or was only part of Jonas' tree I can't tell, but I thought I'd share anyway. There was a rule to create a dtb-image suitable for u-boot, but it gave the wrong jump-to address in the kernel. Originally it says 0x100 which is reset and which will clear the dtb argument given by u-boot. I corrected this to 0x400000 to be able to do the handover between u-boot and the kernel using different dtb-images based on the board.

Best regards,

       /Jakob


Jakob Viketoft
Senior Engineer in RTL and embedded software

ÅAC Microtec AB
Dag Hammarskjölds väg 48
SE-751 83 Uppsala, Sweden

T: +46 702 80 95 97
http://www.aacmicrotec.com
