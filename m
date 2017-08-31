From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 31 Aug 2017 11:41:10 +0100
Subject: [OpenRISC] [PATCH 10/13] openrisc: add simple_smp dts and
 defconfig for simulators
In-Reply-To: <37f0d48de4690694c18be3d32483dafee0730859.1504129273.git.shorne@gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
 <37f0d48de4690694c18be3d32483dafee0730859.1504129273.git.shorne@gmail.com>
Message-ID: <20170831104110.GD15031@leverpostej>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Aug 31, 2017 at 07:03:11AM +0900, Stafford Horne wrote:
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
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&pic>;
> +
> +	chosen {
> +		bootargs = "console=uart,mmio,0x90000000,115200";
> +	};

Any reason this isn't using stdout-path?

> +
> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x02000000>;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu at 0 {
> +			compatible = "opencores,or1200-rtlsvn481";
> +			reg = <0>;
> +			clock-frequency = <20000000>;
> +		};
> +		cpu at 1 {
> +			compatible = "opencores,or1200-rtlsvn481";
> +			reg = <1>;
> +			clock-frequency = <20000000>;
> +		};
> +	};

No enable-method or similar?

Is your SMP bringup/teardown architected?

> +
> +	ompic: ompic {
> +		compatible = "ompic";

This needs a vendor prefix.

Thanks,
Mark.
