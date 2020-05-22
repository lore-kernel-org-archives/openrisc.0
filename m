From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 22 May 2020 16:54:27 +0100
Subject: [OpenRISC] [PATCH 09/29] arm64: use asm-generic/cacheflush.h
In-Reply-To: <20200515143646.3857579-10-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
 <20200515143646.3857579-10-hch@lst.de>
Message-ID: <20200522155426.GI26492@gaia>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, May 15, 2020 at 04:36:26PM +0200, Christoph Hellwig wrote:
> ARM64 needs almost no cache flushing routines of its own.  Rely on
> asm-generic/cacheflush.h for the defaults.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
