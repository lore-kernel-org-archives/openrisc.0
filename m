From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 6 Feb 2022 10:42:46 +0100
Subject: [OpenRISC] [PATCH] openrisc: remove CONFIG_SET_FS
In-Reply-To: <20220206013648.3491865-1-shorne@gmail.com>
References: <20220206013648.3491865-1-shorne@gmail.com>
Message-ID: <CAMuHMdW2bxEtaYaLN28xk2uc=OV0ecUy-N_+Ay193gZq4nH0jw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

Thanks for your patch!

On Sun, Feb 6, 2022 at 2:37 AM Stafford Horne <shorne@gmail.com> wrote:
> Remove the address space override API set_fs() used for User Mode Linux.

Note: this doesn't have anything to do with UML...

> User address space is now limited to TASK_SIZE.
>
> To support this we implement and wire in __get_kernel_nofault and
> __set_kernel_nofault.
>
> The function user_addr_max is removed as there is a default definition
> provided when CONFIG_SET_FS is not used.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
