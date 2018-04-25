From: Helge Deller <deller@gmx.de>
Date: Wed, 25 Apr 2018 23:07:57 +0200
Subject: [OpenRISC] [PATCH 22/22] parisc: use generic dma_noncoherent_ops
In-Reply-To: <20180425072105.GA12308@lst.de>
References: <20180420080313.18796-1-hch@lst.de>
 <20180420080313.18796-23-hch@lst.de>
 <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de> <20180425072105.GA12308@lst.de>
Message-ID: <84d9e1ac-86c3-6f2e-377f-2be44783b933@gmx.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 25.04.2018 09:21, Christoph Hellwig wrote:
> On Sat, Apr 21, 2018 at 07:43:46PM +0200, Helge Deller wrote:
>> This patch breaks a 32bit kernel on a B160L machine (PA7300LC CPU, "pcxl2").
>> After applying this patch series the lasi82956 network driver works unreliable. 
>> NIC gets IP, but ping doesn't work.
>> See drivers/net/ethernet/i825xx/lasi_82596.c, it uses dma*sync() functions.
> 
> Just to confirm:  Without the series it is known to actually work?

Yes.
I reverted this series from my tree, rebuilt, and then the issue was gone.
I won't be able to test again earlier than next week.

Helge
