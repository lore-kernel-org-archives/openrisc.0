From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 14 Feb 2022 09:02:13 -0800
Subject: [OpenRISC] [PATCH 04/14] x86: use more conventional access_ok()
 definition
In-Reply-To: <20220214163452.1568807-5-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org>
Message-ID: <YgqLFYqIqkIsNC92@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 05:34:42PM +0100, Arnd Bergmann wrote:
> +#define __range_not_ok(addr, size, limit)	(!__access_ok(addr, size))
> +#define __chk_range_not_ok(addr, size, limit)	(!__access_ok((void __user *)addr, size))

Can we just kill these off insted of letting themm obsfucate the code?
