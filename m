From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 15 Feb 2022 00:31:52 +0000
Subject: [OpenRISC] [PATCH 05/14] uaccess: add generic __{get,
 put}_kernel_nofault
In-Reply-To: <20220214163452.1568807-6-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-6-arnd@kernel.org>
Message-ID: <Ygr0eAA+ZR1eX0wb@zeniv-ca.linux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 05:34:43PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All architectures that don't provide __{get,put}_kernel_nofault() yet
> can implement this on top of __{get,put}_user.
> 
> Add a generic version that lets everything use the normal
> copy_{from,to}_kernel_nofault() code based on these, removing the last
> use of get_fs()/set_fs() from architecture-independent code.

I'd put the list of those architectures (AFAICS, that's alpha, ia64,
microblaze, nds32, nios2, openrisc, sh, sparc32, xtensa) into commit
message - it's not that hard to find out, but...

And AFAICS, you've missed nios2 - see
#define __put_user(x, ptr) put_user(x, ptr)
in there.  nds32 oddities are dealt with earlier in the series, this
one is not...
