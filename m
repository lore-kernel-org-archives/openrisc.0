From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Thu, 25 Jun 2020 10:26:58 +0200
Subject: [OpenRISC] [PATCH 17/17] arch: rename copy_thread_tls() back to
 copy_thread()
In-Reply-To: <20200622234326.906346-18-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-18-christian.brauner@ubuntu.com>
Message-ID: <20200625082658.GC6319@alpha.franken.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jun 23, 2020 at 01:43:26AM +0200, Christian Brauner wrote:
> Now that HAVE_COPY_THREAD_TLS has been removed, rename copy_thread_tls()
> back simply copy_thread(). It's a simpler name, and doesn't imply that only
> tls is copied here. This finishes an outstanding chunk of internal process
> creation work since we've added clone3().
> [..]
>  arch/mips/kernel/process.c       | 2 +-

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
