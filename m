From: Stafford Horne <shorne@gmail.com>
Date: Tue, 18 Jan 2022 20:48:17 +0900
Subject: [OpenRISC] architectures that still need to remove set_fs()
In-Reply-To: <20220118074836.GA20994@lst.de>
References: <20220118074836.GA20994@lst.de>
Message-ID: <YeapAai1NIuy0zV4@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi,

On Tue, Jan 18, 2022 at 08:48:36AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> you are in this list because your architecture still implements and
> uses address space overrides using set_fs(), which are deprecated and
> have been removed from all mainstream architecture ports.  To help
> cleanup the core kernel it would be great to make progress on removing
> set_fs entirely.
> 
> The following steps are required:
> 
>  (1) implement the __get_kernel_nofault and __put_kernel_nofault
>      helper to access kernel memory without page faults, replacing
>      the get/put_user under set_fs(KERNEL_DS) abuse.  Mips has a good
>      example for a trivial implementation for architectures that use
>      a common address space in commit 04324f44cb69

Also see commit 08ee3a009f49a which is preparation for removing set_fs/get_fs
this commit implements __get_kernel_nofault/__put_kernel_nofault for mips.

>  (2) remove any architecture specific use of such constructs.  This
>      only affects ia64 and sh.
>  (3) stop selecting the SET_FS and remove all the set_fs-related
>      infrastructure.  The above mips commit is a good guide once again.
> 
> Thanks!

I will look into this for OpenRISC.

-Stafford
