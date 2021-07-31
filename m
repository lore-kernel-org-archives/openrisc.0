From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Sat, 31 Jul 2021 23:12:38 +0000
Subject: [OpenRISC] [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT
 in Kconfig
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
References: <20210731052233.4703-1-masahiroy@kernel.org>
 <20210731052233.4703-2-masahiroy@kernel.org>
Message-ID: <1036d104-44c1-b162-2262-973226628be2@synopsys.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 7/30/21 10:22 PM, Masahiro Yamada wrote:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>   arch/arc/Kconfig              | 4 +---
> [snip..]


Acked-by: Vineet Gupta <vgupta@synopsys.com>   #arch/arc

