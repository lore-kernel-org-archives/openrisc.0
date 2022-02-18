From: Christoph Hellwig <hch@lst.de>
Date: Fri, 18 Feb 2022 07:25:29 +0100
Subject: [OpenRISC] [PATCH v2 03/18] nds32: fix access_ok() checks in
 get/put_user
In-Reply-To: <20220216131332.1489939-4-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-4-arnd@kernel.org>
Message-ID: <20220218062529.GB22576@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 16, 2022 at 02:13:17PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The get_user()/put_user() functions are meant to check for
> access_ok(), while the __get_user()/__put_user() functions
> don't.
> 
> This broke in 4.19 for nds32, when it gained an extraneous
> check in __get_user(), but lost the check it needs in
> __put_user().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
