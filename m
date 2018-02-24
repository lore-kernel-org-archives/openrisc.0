From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 24 Feb 2018 13:55:13 -0800
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <1519414328.30443.29.camel@HansenPartnership.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop> <20180223171019.GA1125@roeck-us.net>
 <20180223181943.GF30522@ZenIV.linux.org.uk>
 <1519414328.30443.29.camel@HansenPartnership.com>
Message-ID: <de4b7d03-7682-24e1-f07e-6424e56a9665@roeck-us.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 02/23/2018 11:32 AM, James Bottomley wrote:
> On Fri, 2018-02-23 at 18:19 +0000, Al Viro wrote:
> [...]
>> IIRC, parisc/qemu stuff had been announced a while ago;
> 
> I have, but it didn't work sufficiently for me to either boot a kernel
> using system emulation or start an architecture container using user
> emulation.  I'll try again now that qemu has gone through several
> revisions.
> 

I can boot a parisc image to CLI using ToT qemu, ToT kernel built with
	make ARCH=parisc CROSS_COMPILE=hppa-linux-" defconfig
	make ARCH=parisc CROSS_COMPILE=hppa-linux-"

qemu command line:

qemu-system-hppa -nographic -monitor none -kernel vmlinux \
	--append "console=/dev/ttyS0 root=/dev/sda" \
	-drive file=rootfs.ext2,format=raw,if=scsi

I built the root file system using a modified buildroot based on 2018.02-rc2
with hppa support added.

Guenter
