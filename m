From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jun 2020 09:38:42 +0200
Subject: [OpenRISC] [PATCH 17/17] arch: rename copy_thread_tls() back to
 copy_thread()
In-Reply-To: <20200622234326.906346-18-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-18-christian.brauner@ubuntu.com>
Message-ID: <CAMuHMdV4QW+srkzkCTWs9CQGhxPo3y9E02AJ=4K89mMqoxYkzA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jun 23, 2020 at 1:47 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Now that HAVE_COPY_THREAD_TLS has been removed, rename copy_thread_tls()
> back simply copy_thread(). It's a simpler name, and doesn't imply that only
> tls is copied here. This finishes an outstanding chunk of internal process
> creation work since we've added clone3().

> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

>  arch/m68k/kernel/process.c       | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
