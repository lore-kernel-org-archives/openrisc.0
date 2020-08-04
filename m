From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 4 Aug 2020 22:48:08 +0200
Subject: [OpenRISC] [PATCH 3/6] openrisc: uaccess: Use static inline
 function in access_ok
In-Reply-To: <20200804042354.3930694-4-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
 <20200804042354.3930694-4-shorne@gmail.com>
Message-ID: <20200804204808.ttgkwrievzn5aoqd@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Aug 04, 2020 at 01:23:51PM +0900, Stafford Horne wrote:
> As suggested by Linus when reviewing commit 9cb2feb4d21d
> ("arch/openrisc: Fix issues with access_ok()") last year; making
> __range_ok an inline function also fixes the used twice issue that the
> commit was fixing.  I agree it's a good cleanup.  This patch addresses
> that as I am currently working on the access_ok macro to fixup sparse
> annotations in OpenRISC.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Look good to me.

-- Luc
