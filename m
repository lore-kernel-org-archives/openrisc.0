From: Kees Cook <keescook@chromium.org>
Date: Mon, 22 Jun 2020 17:44:52 -0700
Subject: [OpenRISC] [PATCH 16/17] arch: remove HAVE_COPY_THREAD_TLS
In-Reply-To: <20200622234326.906346-17-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-17-christian.brauner@ubuntu.com>
Message-ID: <202006221743.1BE5670@keescook>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jun 23, 2020 at 01:43:25AM +0200, Christian Brauner wrote:
> All architectures support copy_thread_tls() now, so remove the legacy
> copy_thread() function and the HAVE_COPY_THREAD_TLS config option. Everyone
> uses the same process creation calling convention based on
> copy_thread_tls() and struct kernel_clone_args. This will make it easier to
> maintain the core process creation code under kernel/, simplifies the
> callpaths and makes the identical for all architectures.
> [...]
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Massive CC list. ;) linux-arch@ may be sufficient.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
