From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Sun, 4 Apr 2021 20:46:04 +0200
Subject: [OpenRISC] [PATCH] Documentation: Add qemu instructions for
 OpenRISC
In-Reply-To: <20210304210747.3679483-1-shorne@gmail.com>
References: <20210304210747.3679483-1-shorne@gmail.com>
Message-ID: <bd106f14-c773-a4a8-2f43-2e269f4f04e4@pengutronix.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Sascha,

On 04.03.21 22:07, Stafford Horne wrote:
> Most developers have qemu and rather not download and install the
> or1ksim.  Also, this adds details on how to get a openrisc toolchain.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

I don't see this in next.

> ---
>  Documentation/boards/openrisc.rst | 68 +++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/boards/openrisc.rst b/Documentation/boards/openrisc.rst
> index f9d67f965..34586b4a7 100644
> --- a/Documentation/boards/openrisc.rst
> +++ b/Documentation/boards/openrisc.rst
> @@ -1,6 +1,74 @@
>  OpenRISC
>  ========
>  
> +Optaining an OpenRISC toolchain

Could you fix up s/Optaining/Obtaining/ while at it?

Cheers,

Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
