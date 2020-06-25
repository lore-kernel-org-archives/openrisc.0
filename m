From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Thu, 25 Jun 2020 10:25:58 +0200
Subject: [OpenRISC] [PATCH 16/17] arch: remove HAVE_COPY_THREAD_TLS
In-Reply-To: <20200622234326.906346-17-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-17-christian.brauner@ubuntu.com>
Message-ID: <20200625082558.GB6319@alpha.franken.de>
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
> [..] 
>  arch/mips/Kconfig          |  1 -

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
