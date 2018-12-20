From: hch@lst.de <hch@lst.de>
Date: Thu, 20 Dec 2018 18:37:17 +0100
Subject: [OpenRISC] ensure dma_alloc_coherent always returns zeroed
	memory
In-Reply-To: <20181220144604.GA18034@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
 <20181219165939.GA26087@lst.de> <1545316369.14089.20.camel@synopsys.com>
 <20181220143415.GA17726@lst.de> <1545316759.14089.22.camel@synopsys.com>
 <20181220144604.GA18034@lst.de>
Message-ID: <20181220173717.GA20939@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Btw, can you try wit the very latests dma-mapping-for-next tree
which has a new fix from Thierry Reding that might be related.
