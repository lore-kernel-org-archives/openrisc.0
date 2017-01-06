From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Fri, 6 Jan 2017 12:30:53 +0100
Subject: [OpenRISC] ubi_io_read: error -74 (ECC error)
In-Reply-To: <38f0cfac3dbe4ea89da84c7fbf667833@SGPMBX1023.APAC.bosch.com>
References: <38f0cfac3dbe4ea89da84c7fbf667833@SGPMBX1023.APAC.bosch.com>
Message-ID: <20170106123053.4a5ffabc@bbrezillon>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Raghavan,

On Fri, 6 Jan 2017 10:07:29 +0000
"Anurag Raghavan (RBEI/ETW11)" <Raghavan.Anurag@in.bosch.com> wrote:

> Hi All,
> 
> My appdata partition could not be mounted or where the partition was not able to be used. Anyone can help me to find out the root cause of this. What are the possibilities of this ubifs corruption. Any patched are available to fix this issue.

Can you please stop sending over and over the same message in the hope
that someone will magically solve the problem for you. Pinging
maintainers is accepted but not 3 times in 2 days.

> 
> I am using the kernel version-30.3.5

It's not even a valid kernel version (probably a kerne, and we'll need a
lot more than the 10 lines of log you provided to help you debug your
driver, like the boot logs, a reference to the kernel sources you're
using, after how much time this problem occurred...

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
> dpkg: error: unable to sync new file '/var/lib/dpkg/arch-new': Structure needs cleaning
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

