From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 30 Oct 2019 11:39:46 +0100 (CET)
Subject: [OpenRISC] [PATCH 08/21] x86: Clean up ioremap()
In-Reply-To: <20191029064834.23438-9-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
 <20191029064834.23438-9-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1910301139330.19226@nanos.tec.linutronix.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, 29 Oct 2019, Christoph Hellwig wrote:

> Use ioremap() as the main implemented function, and defines
> ioremap_nocache() as a deprecated alias of ioremap() in
> preparation of removing ioremap_nocache() entirely.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
