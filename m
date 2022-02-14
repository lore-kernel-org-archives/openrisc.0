From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 14 Feb 2022 09:01:10 -0800
Subject: [OpenRISC] [PATCH 03/14] nds32: fix access_ok() checks in
 get/put_user
In-Reply-To: <20220214163452.1568807-4-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-4-arnd@kernel.org>
Message-ID: <YgqK1ihlJvRFHJ9h@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 05:34:41PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The get_user()/put_user() functions are meant to check for
> access_ok(), while the __get_user()/__put_user() functions
> don't.
> 
> This broke in 4.19 for nds32, when it gained an extraneous
> check in __get_user(), but lost the check it needs in
> __put_user().

Can we follow the lead of MIPS (which this was originally copied
from I think) and kill the pointless __get/put_user_check wrapper
that just obsfucate the code?
