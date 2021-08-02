From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 2 Aug 2021 11:03:57 -0700
Subject: [OpenRISC] [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT
 in Kconfig
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
References: <20210731052233.4703-1-masahiroy@kernel.org>
 <20210731052233.4703-2-masahiroy@kernel.org>
Message-ID: <CAMo8BfLDjw71xiCDo8uk4pQFuOzqAoak0k3R4YJDnRsA2hoCtw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jul 30, 2021 at 10:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  arch/xtensa/Kconfig           | 4 +---

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
-- 
Thanks.
-- Max
