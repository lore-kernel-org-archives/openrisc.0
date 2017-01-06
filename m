From: Anurag Raghavan (RBEI/ETW11) <Raghavan.Anurag@in.bosch.com>
Date: Fri, 6 Jan 2017 11:58:40 +0000
Subject: [OpenRISC] ubi_io_read: error -74 (ECC error)
In-Reply-To: <20170106123053.4a5ffabc@bbrezillon>
References: <38f0cfac3dbe4ea89da84c7fbf667833@SGPMBX1023.APAC.bosch.com>
 <20170106123053.4a5ffabc@bbrezillon>
Message-ID: <92e442e55f2b4826a12bd4b74c6fb3ca@SGPMBX1023.APAC.bosch.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Sorry Boris, by mistake it happened.

I am attaching my full log here.  This issue is happening very rarely. I am using mfg-tool to flash. I am recreating this issue by continuously flashing the partition.
And my kernel version is 3.0.35

Best regards

Raghavan Anurag
RBEI/ETW1  

Tel. +91(422)667-4001 | Mobil 9986968950



-----Original Message-----
From: linux-mtd [mailto:linux-mtd-bounces at lists.infradead.org] On Behalf Of Boris Brezillon
Sent: Friday, January 06, 2017 5:01 PM
To: Anurag Raghavan (RBEI/ETW11) <Raghavan.Anurag@in.bosch.com>
Cc: linux-mips at linux-mips.org; alsa-devel at alsa-project.org; linux-ia64 at vger.kernel.org; linux-doc at vger.kernel.org; airlied at linux.ie; linux-fbdev at vger.kernel.org; dri-devel at lists.freedesktop.org; linux-mtd at lists.infradead.org; sparclinux at vger.kernel.org; linux-arch at vger.kernel.org; linux-s390 at vger.kernel.org; linux-am33-list at redhat.com; linux-c6x-dev at linux-c6x.org; linux-rdma at vger.kernel.org; linux-hexagon at vger.kernel.org; linux-sh at vger.kernel.org; coreteam at netfilter.org; fcoe-devel at open-fcoe.org; xen-devel at lists.xenproject.org; linux-snps-arc at lists.infradead.org; linux-media at vger.kernel.org; uclinux-h8-devel at lists.sourceforge.jp; linux-xtensa at linux-xtensa.org; arnd at arndb.de; linux-kbuild at vger.kernel.org; adi-buildroot-devel at lists.sourceforge.net; linux-raid at vger.kernel.org; linux-m68k at lists.linux-m68k.org; openrisc at lists.librecores.org; Nicolas Dichtel <nicolas.dichtel@6wind.com>; linux-metag at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-nfs at vger.kernel.org; linux-cris-kernel at axis.com; linux-parisc at vger.kernel.org; netdev at vger.kernel.org; linux-mmc at vger.kernel.org; linux-kernel at vger.kernel.org; linux-spi at vger.kernel.org; mmarek at suse.com; netfilter-devel at vger.kernel.org; linux-alpha at vger.kernel.org; nios2-dev at lists.rocketboards.org; linuxppc-dev at lists.ozlabs.org; davem at davemloft.net
Subject: Re: ubi_io_read: error -74 (ECC error)

Hi Raghavan,

On Fri, 6 Jan 2017 10:07:29 +0000
"Anurag Raghavan (RBEI/ETW11)" <Raghavan.Anurag@in.bosch.com> wrote:

> Hi All,
> 
> My appdata partition could not be mounted or where the partition was not able to be used. Anyone can help me to find out the root cause of this. What are the possibilities of this ubifs corruption. Any patched are available to fix this issue.

Can you please stop sending over and over the same message in the hope that someone will magically solve the problem for you. Pinging maintainers is accepted but not 3 times in 2 days.

> 
> I am using the kernel version-30.3.5

It's not even a valid kernel version (probably a kerne, and we'll need a lot more than the 10 lines of log you provided to help you debug your driver, like the boot logs, a reference to the kernel sources you're using, after how much time this problem occurred...

> Any kernel patches are available to solve this issue...??

What's your NAND controller? It seems related to a NAND driver issue.

Regards,

Boris

> 
> Error logs:
> 
> [    1.797141] UBI error: ubi_io_read: error -74 (ECC error) while reading 253952 bytes from PEB 445:8192, read 253952 bytes
> [    1.808274] UBIFS error (pid 491): ubifs_scan: corrupt empty space at LEB 489:233760
> [    1.816037] UBIFS error (pid 491): ubifs_scanned_corruption: corruption at LEB 489:233760
> [    1.828660] UBIFS error (pid 491): ubifs_scan: LEB 489 scanning failed
> [    1.835215] UBIFS warning (pid 491): ubifs_ro_mode: switched to read-only mode, error -117
> [    1.843502] UBIFS error (pid 491): make_reservation: cannot reserve 58 bytes in jhead 2, error -117
> [    1.852569] UBIFS error (pid 491): do_writepage: cannot write page 0 of inode 76584, error -117
> dpkg: error: unable to sync new file '/var/lib/dpkg/arch-new': 
> Structure needs cleaning
> 
> Best regards
> 
> Raghavan Anurag
> RBEI/ETW1
> 
> Tel. +91(422)667-4001 | Mobil 9986968950
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: serial_logs.txt
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170106/a77adc4e/attachment-0001.txt>
