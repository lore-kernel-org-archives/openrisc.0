From: Christoph Hellwig <hch@lst.de>
Date: Wed, 27 May 2020 07:10:11 +0200
Subject: [OpenRISC] [PATCH] media: omap3isp: Shuffle cacheflush.h and
 include mm.h
In-Reply-To: <20200527043426.3242439-1-natechancellor@gmail.com>
References: <20200515143646.3857579-7-hch@lst.de>
 <20200527043426.3242439-1-natechancellor@gmail.com>
Message-ID: <20200527051011.GB16317@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 26, 2020 at 09:34:27PM -0700, Nathan Chancellor wrote:
> After mm.h was removed from the asm-generic version of cacheflush.h,
> s390 allyesconfig shows several warnings of the following nature:

Hmm, I'm pretty sure I sent the same fix a few days ago in response to
a build bot report.  But if that didn't get picked up I'm fine with
your version of it as well of course:

Acked-by: Christoph Hellwig <hch@lst.de>
