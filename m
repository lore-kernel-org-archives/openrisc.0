From: Christoph Hellwig <hch@lst.de>
Date: Tue, 18 Jan 2022 08:48:36 +0100
Subject: [OpenRISC] architectures that still need to remove set_fs()
Message-ID: <20220118074836.GA20994@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all,

you are in this list because your architecture still implements and
uses address space overrides using set_fs(), which are deprecated and
have been removed from all mainstream architecture ports.  To help
cleanup the core kernel it would be great to make progress on removing
set_fs entirely.

The following steps are required:

 (1) implement the __get_kernel_nofault and __put_kernel_nofault
     helper to access kernel memory without page faults, replacing
     the get/put_user under set_fs(KERNEL_DS) abuse.  Mips has a good
     example for a trivial implementation for architectures that use
     a common address space in commit 04324f44cb69
 (2) remove any architecture specific use of such constructs.  This
     only affects ia64 and sh.
 (3) stop selecting the SET_FS and remove all the set_fs-related
     infrastructure.  The above mips commit is a good guide once again.

Thanks!
