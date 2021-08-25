From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Tue, 24 Aug 2021 20:49:37 -0700 (PDT)
Subject: [OpenRISC] [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT
 in Kconfig
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
Message-ID: <mhng-fae2ea79-c261-4e5d-8eae-21e60810a957@palmerdabbelt-glaptop>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, 30 Jul 2021 22:22:32 PDT (-0700), masahiroy at kernel.org wrote:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/Kconfig            | 4 +---

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
