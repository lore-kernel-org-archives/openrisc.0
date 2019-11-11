From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Nov 2019 11:33:50 +0100
Subject: [OpenRISC] [PATCH 01/21] arm: remove ioremap_cached
In-Reply-To: <20191029064834.23438-2-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
 <20191029064834.23438-2-hch@lst.de>
Message-ID: <CAK8P3a3xk-mQic84Cv7CYhm2DqDCyu69+qH=i8M=JoE3xkpM=g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Oct 29, 2019 at 7:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> No users of ioremap_cached are left, remove it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
