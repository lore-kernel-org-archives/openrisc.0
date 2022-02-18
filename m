From: Christoph Hellwig <hch@lst.de>
Date: Fri, 18 Feb 2022 07:29:44 +0100
Subject: [OpenRISC] [PATCH v2 07/18] nios2: drop access_ok() check from
 __put_user()
In-Reply-To: <20220216131332.1489939-8-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-8-arnd@kernel.org>
Message-ID: <20220218062944.GE22576@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 16, 2022 at 02:13:21PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Unlike other architectures, the nios2 version of __put_user() has an
> extra check for access_ok(), preventing it from being used to implement
> __put_kernel_nofault().
> 
> Split up put_user() along the same lines as __get_user()/get_user()

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
