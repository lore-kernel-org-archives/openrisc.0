From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 27 Feb 2020 13:21:47 +0100
Subject: [OpenRISC] [PATCH 2/3] openrisc: Enable the clone3 syscall
In-Reply-To: <20200226225625.28935-3-shorne@gmail.com>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-3-shorne@gmail.com>
Message-ID: <20200227122147.rnpzcy7rjexgy6yx@wittgenstein>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 27, 2020 at 07:56:24AM +0900, Stafford Horne wrote:
> Enable the clone3 syscall for OpenRISC.  We use the generic version.
> 
> This was tested with the clone3 test from selftests.  Note, for all
> tests to pass it required enabling CONFIG_NAMESPACES which is not
> enabled in the default kernel config.

For OpenRISC, I assume. Hm, maybe we should fix the tests to skip when
CONFIG_NAMESPACES is not enabled.

> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
