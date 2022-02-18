From: Christoph Hellwig <hch@lst.de>
Date: Fri, 18 Feb 2022 07:35:49 +0100
Subject: [OpenRISC] [PATCH v2 14/18] lib/test_lockup: fix kernel pointer
 check for separate address spaces
In-Reply-To: <20220216131332.1489939-15-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-15-arnd@kernel.org>
Message-ID: <20220218063549.GJ22576@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 16, 2022 at 02:13:28PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> test_kernel_ptr() uses access_ok() to figure out if a given address
> points to user space instead of kernel space. However on architectures
> that set CONFIG_ALTERNATE_USER_ADDRESS_SPACE, a pointer can be valid
> for both, and the check always fails because access_ok() returns true.
> 
> Make the check for user space pointers conditional on the type of
> address space layout.

What is this code even trying to do?  It looks extremly broken.
