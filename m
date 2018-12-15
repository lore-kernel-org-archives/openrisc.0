From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 14 Dec 2018 22:30:18 -0800
Subject: [OpenRISC] [PATCH 3/6] sparc: remove the sparc32_dma_ops
	indirection
In-Reply-To: <20181208174115.16237-4-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-4-hch@lst.de>
Message-ID: <20181215063018.GA11415@roeck-us.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Dec 08, 2018 at 09:41:12AM -0800, Christoph Hellwig wrote:
> There is no good reason to have a double indirection for the sparc32
> dma ops, so remove the sparc32_dma_ops and define separate dma_map_ops
> instance for the different IOMMU types.
> 

Except maybe this:

scsi host0: esp
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
scsi target0:0:0: Beginning Domain Validation
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]

and so on, until qemu is terminated. This is seen with all sparc32
qemu emulations. Reverting the patch fixes the problem.

Guenter
