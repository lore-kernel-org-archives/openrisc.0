From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 11 Jan 2017 07:48:03 +0100
Subject: [OpenRISC] [PATCH 2/9] Move dma_ops from archdata into struct
	device
In-Reply-To: <20170111005648.14988-3-bart.vanassche@sandisk.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-3-bart.vanassche@sandisk.com>
Message-ID: <20170111064803.GB26893@kroah.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jan 10, 2017 at 04:56:41PM -0800, Bart Van Assche wrote:
> Several RDMA drivers, e.g. drivers/infiniband/hw/qib, use the CPU to
> transfer data between memory and PCIe adapter. Because of performance
> reasons it is important that the CPU cache is not flushed when such
> drivers transfer data. Make this possible by allowing these drivers to
> override the dma_map_ops pointer. Additionally, introduce the function
> set_dma_ops() that will be used by a later patch in this series.

When you say things like "additionally", that's a huge flag that this
needs to be split up into multiple patches.  No need to add
set_dma_ops() here in this patch.

And I'd argue that it should be dma_ops_set(), and dma_ops_get(), just
to keep the namespace sane, but that's probably a different set of
patches...

thanks,

greg k-h
