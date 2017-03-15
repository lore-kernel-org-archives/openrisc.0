From: Stafford Horne <shorne@gmail.com>
Date: Wed, 15 Mar 2017 20:44:34 +0900
Subject: [OpenRISC] [PATCH 0/3] openrisc: various fixes
In-Reply-To: <cover.1486391219.git.shorne@gmail.com>
References: <cover.1486391219.git.shorne@gmail.com>
Message-ID: <CAAfxs75jPZN+kPEx2dESjXvw5dJf2peir7jv6xyfRuut=epd=g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Any comment on this series?

On Mon, Feb 6, 2017 at 11:38 PM, Stafford Horne <shorne@gmail.com> wrote:
> Hello,
>
> These are a few patches that have collected in the openrisc newlib
> repository on github over the last year.  Most issues were found
> when running the gdb test suite as I worked on getting that ready
> for upstream.
>
> I am working with Stefan Wallentowitz who has sent openrisc patches
> in the past.
>
> Olof Kindgren (1):
>   or1k: Make open reentrant
>
> Stafford Horne (2):
>   libgloss: or1k: If available call the init for init_array
>   libgloss: Remove duplicate definition of environ
>
>  libgloss/or1k/crt0.S     | 6 ++++++
>  libgloss/or1k/syscalls.c | 5 +----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> --
> 2.9.3
>
