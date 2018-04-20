From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Apr 2018 10:02:51 +0200
Subject: [OpenRISC] =?utf-8?q?=28no_subject=29?=
Message-ID: <20180420080313.18796-1-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

To: iommu@lists.linux-foundation.org
Cc: linux-arch at vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: linux-alpha at vger.kernel.org
Cc: linux-snps-arc at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-c6x-dev at linux-c6x.org
Cc: linux-hexagon at vger.kernel.org
Cc: linux-m68k at lists.linux-m68k.org
Cc: nios2-dev at lists.rocketboards.org
Cc: openrisc at lists.librecores.org
Cc: linux-parisc at vger.kernel.org
Cc: linux-sh at vger.kernel.org
Cc: sparclinux at vger.kernel.org
Cc: linux-xtensa at linux-xtensa.org
Cc: linux-kernel at vger.kernel.org
Subject: [RFC] common non-cache coherent direct dma mapping ops

Hi all,

this series continues consolidating the dma-mapping code, with a focus
on architectures that do not (always) provide cache coherence for DMA.
Three architectures (arm, mips and powerpc) are still left to be
converted later due to complexity of their dma ops selection.

The dma-noncoherent ops calls the dma-direct ops for the actual
translation of streaming mappins and allow the architecture to provide
any cache flushing required for cpu to device and/or device to cpu
ownership transfers.  The dma coherent allocator is for now still left
entirely to architecture supplied implementations due the amount of
variations.  Hopefully we can do some consolidation for them later on
as well.

A lot of architectures are currently doing very questionable things
in their dma mapping routines, which are documented in the changelogs
for each patch.  Please review them very careful and correct me on
incorrect assumptions.

Because this series sits on top of two previously submitted series
a git tree might be useful to actually test it.  It is provided here:

    git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent
