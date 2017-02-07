From: Jakob Viketoft <jakob.viketoft@aacmicrotec.com>
Date: Tue, 7 Feb 2017 01:03:59 +0000
Subject: [OpenRISC] Linux openrisc init code...
In-Reply-To: <20170206132820.GE32144@lianli.shorne-pla.net>
References: <D90E780DD5090A4F9AEBC859615CED770106727209@OXYGEN.aacmicrotec.local>
 <20170205084359.GD32144@lianli.shorne-pla.net>
 <24B059156D2D4E54AAF93CA262AA7986@BAndViG>,
 <20170206132820.GE32144@lianli.shorne-pla.net>
Message-ID: <D90E780DD5090A4F9AEBC859615CED770106727BD1@OXYGEN.aacmicrotec.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi Andrey and Stafford,

Sorry for my late reply, a trip to Japan with some jet lag got in the way. 

>> About Linux and U-Boot
>> Currently I use quite old U-Boot and Linux versions. Both downloaded long
>> time ago from openrisc.org when the site was operable. In particular, I also
>> use Jonas' tree Linux sources.
>> After Linux build I do two things:
>> 1) Convert vmlinux (which is ELF originally) to bin.
>> 2) Create U-Boot image with command:
>> mkimage -n 'Linux for OpenRISC' -A or1k -O linux -T kernel -C none -a 0 -e
>> 0x100 -d vmlinux.bin ~/tftpshare/vmlinux.ubi

Yes, this is what I'm talking about. By giving the boot address as 0x100, the kernel wasn't able to use the dtb before since it used r3 and r4 to compute the address of the _start vector (in head.S). In linux-next, I can see this has been changed to r13 and r15 and you shouldn't need to worry about this anymore. My address of 0x400000 was due to an internal setup with several different images (and dtb's) in flash. Anyway, ignore the rumble of old times. :)

>Thanks, this is good to know.  I guess then you have uboot running on
>your board with an ethernet connection ahd the image is pulled down over
>ethernet during boot.

Flash in our case, allows us to have a generic image, but different dtb's on different boards.

Best regards,

       /Jakob

Jakob Viketoft
Senior Engineer in RTL and embedded software

ÅAC Microtec AB
Dag Hammarskjölds väg 48
SE-751 83 Uppsala, Sweden

T: +46 702 80 95 97
http://www.aacmicrotec.com
