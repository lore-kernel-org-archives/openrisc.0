From: Christoph Hellwig <hch@lst.de>
Date: Mon, 24 Feb 2020 11:44:40 -0800
Subject: [OpenRISC] provide in-place uncached remapping for dma-direct v2
Message-ID: <20200224194446.690816-1-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all,

this series provides support for remapping places uncached in-place in
the generic dma-direct code, and moves openrisc over from its own
in-place remapping scheme.  The arm64 folks also had interest in such
a scheme to avoid problems with speculating into cache aliases.

Also all architectures that always use small page mappings for the
kernel and have non-coherent DMA should look into enabling this
scheme, as it is much more efficient than the vmap remapping.

Changes since v1:
 - share the arch hook for inline remap and uncached segment support
