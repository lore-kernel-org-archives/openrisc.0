From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Sun, 29 Dec 2019 16:42:54 +0100
Subject: [OpenRISC] [PATCH 0/4] use mmgrab
Message-ID: <1577634178-22530-1-git-send-email-Julia.Lawall@inria.fr>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Mmgrab was introduced in commit f1f1007644ff ("mm: add new mmgrab()
helper") and most of the kernel was updated to use it. Update a few
remaining files.

---

 arch/openrisc/kernel/smp.c          |    2 +-
 drivers/misc/cxl/context.c          |    2 +-
 drivers/vfio/pci/vfio_pci_nvlink2.c |    2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
