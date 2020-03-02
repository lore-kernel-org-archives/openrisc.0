From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 2 Mar 2020 08:43:18 +0100
Subject: [OpenRISC] [PATCH v2 1/3] openrisc: Convert copy_thread to
 copy_thread_tls
In-Reply-To: <20200301213851.8096-2-shorne@gmail.com>
References: <20200301213851.8096-1-shorne@gmail.com>
 <20200301213851.8096-2-shorne@gmail.com>
Message-ID: <20200302074318.oekwyowoej5777cn@wittgenstein>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Mar 02, 2020 at 06:38:49AM +0900, Stafford Horne wrote:
> This is required for clone3 which passes the TLS value through a
> struct rather than a register.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
