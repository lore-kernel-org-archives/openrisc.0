From: Heiko Carstens <hca@linux.ibm.com>
Date: Sat, 31 Jul 2021 08:50:00 +0200
Subject: [OpenRISC] [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT
 in Kconfig
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
References: <20210731052233.4703-1-masahiroy@kernel.org>
 <20210731052233.4703-2-masahiroy@kernel.org>
Message-ID: <YQTymISw2nXxDSGu@osiris>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Jul 31, 2021 at 02:22:32PM +0900, Masahiro Yamada wrote:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
...
>  arch/s390/Kconfig             | 1 +
>  arch/s390/Kconfig.debug       | 3 ---

For s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
