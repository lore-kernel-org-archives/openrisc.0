From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 12 Sep 2017 00:37:12 +0200
Subject: [OpenRISC] [PATCH 10/13] openrisc: add simple_smp dts and
 defconfig for simulators
In-Reply-To: <37f0d48de4690694c18be3d32483dafee0730859.1504129273.git.shorne@gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
 <37f0d48de4690694c18be3d32483dafee0730859.1504129273.git.shorne@gmail.com>
Message-ID: <20170911223712.GA31546@amd>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu 2017-08-31 07:03:11, Stafford Horne wrote:
> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> 
> Simple enough to be compatible with simulation environments,
> such as verilated systems, QEMU and other targets supporting OpenRISC
> SMP.  This also supports our base FPGA SoC's if the cpu frequency is
> upped to 50Mhz.
> 
> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> [shorne at gmail.com: Added defconfig]
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/boot/dts/simple_smp.dts      | 58 ++++++++++++++++++++++++++
>  arch/openrisc/configs/simple_smp_defconfig | 66 ++++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 arch/openrisc/boot/dts/simple_smp.dts
>  create mode 100644 arch/openrisc/configs/simple_smp_defconfig
> 
> diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple_smp.dts
> new file mode 100644
> index 000000000000..47c54101baae
> --- /dev/null
> +++ b/arch/openrisc/boot/dts/simple_smp.dts
> @@ -0,0 +1,58 @@
> +/dts-v1/;
> +/ {
> +	compatible = "opencores,or1ksim";

You may want to add some comment on top, explaining what this
is... and perhaps link to some page documenting how to set up
qemu/FPGAs?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170912/6e69b8b1/attachment.sig>
