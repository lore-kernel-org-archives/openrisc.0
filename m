From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 21 Oct 2019 10:23:03 +0200 (CEST)
Subject: [OpenRISC] [PATCH 08/21] x86: clean up ioremap
In-Reply-To: <20191017174554.29840-9-hch@lst.de>
References: <20191017174554.29840-1-hch@lst.de>
 <20191017174554.29840-9-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1910211019540.1904@nanos.tec.linutronix.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, 17 Oct 2019, Christoph Hellwig wrote:

Please change the subject to:

       x86/mm: Cleanup ioremap()

> Use ioremap as the main implemented function, and defined

ioremap() please

s/defined/define/

> ioremap_nocache to it as a deprecated alias.

ioremap_nocache() as a deprecated alias of ioremap().

Aside of that this lacks any form of rationale. Please add some WHY to it.

Should this go with your larger series or can this be picked up
independently?

Thanks,

	tglx
