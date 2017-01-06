From: Anurag Raghavan (RBEI/ETW11) <Raghavan.Anurag@in.bosch.com>
Date: Fri, 6 Jan 2017 10:07:29 +0000
Subject: [OpenRISC] ubi_io_read: error -74 (ECC error)
Message-ID: <38f0cfac3dbe4ea89da84c7fbf667833@SGPMBX1023.APAC.bosch.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

My appdata partition could not be mounted or where the partition was not able to be used. Anyone can help me to find out the root cause of this. What are the possibilities of this ubifs corruption. Any patched are available to fix this issue.

I am using the kernel version-30.3.5
Any kernel patches are available to solve this issue...??

Error logs:

[    1.797141] UBI error: ubi_io_read: error -74 (ECC error) while reading 253952 bytes from PEB 445:8192, read 253952 bytes
[    1.808274] UBIFS error (pid 491): ubifs_scan: corrupt empty space at LEB 489:233760
[    1.816037] UBIFS error (pid 491): ubifs_scanned_corruption: corruption at LEB 489:233760
[    1.828660] UBIFS error (pid 491): ubifs_scan: LEB 489 scanning failed
[    1.835215] UBIFS warning (pid 491): ubifs_ro_mode: switched to read-only mode, error -117
[    1.843502] UBIFS error (pid 491): make_reservation: cannot reserve 58 bytes in jhead 2, error -117
[    1.852569] UBIFS error (pid 491): do_writepage: cannot write page 0 of inode 76584, error -117
dpkg: error: unable to sync new file '/var/lib/dpkg/arch-new': Structure needs cleaning

Best regards

Raghavan Anurag
RBEI/ETW1  

Tel. +91(422)667-4001 | Mobil 9986968950
