From: Stafford Horne <shorne@gmail.com>
Date: Thu, 31 Aug 2017 22:05:10 +0900
Subject: [OpenRISC] [PATCH 10/13] openrisc: add simple_smp dts and
 defconfig for simulators
In-Reply-To: <20170831104110.GD15031@leverpostej>
References: <cover.1504129273.git.shorne@gmail.com>
 <37f0d48de4690694c18be3d32483dafee0730859.1504129273.git.shorne@gmail.com>
 <20170831104110.GD15031@leverpostej>
Message-ID: <20170831130510.GC2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Aug 31, 2017 at 11:41:10AM +0100, Mark Rutland wrote:
> On Thu, Aug 31, 2017 at 07:03:11AM +0900, Stafford Horne wrote:
> > From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > 
> > Simple enough to be compatible with simulation environments,
> > such as verilated systems, QEMU and other targets supporting OpenRISC
> > SMP.  This also supports our base FPGA SoC's if the cpu frequency is
> > upped to 50Mhz.
> > 
> > Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > [shorne at gmail.com: Added defconfig]
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  arch/openrisc/boot/dts/simple_smp.dts      | 58 ++++++++++++++++++++++++++
> >  arch/openrisc/configs/simple_smp_defconfig | 66 ++++++++++++++++++++++++++++++
> >  2 files changed, 124 insertions(+)
> >  create mode 100644 arch/openrisc/boot/dts/simple_smp.dts
> >  create mode 100644 arch/openrisc/configs/simple_smp_defconfig
> > 
> > diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple_smp.dts
> > new file mode 100644
> > index 000000000000..47c54101baae
> > --- /dev/null
> > +++ b/arch/openrisc/boot/dts/simple_smp.dts
> > @@ -0,0 +1,58 @@
> > +/dts-v1/;
> > +/ {
> > +	compatible = "opencores,or1ksim";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	interrupt-parent = <&pic>;
> > +
> > +	chosen {
> > +		bootargs = "console=uart,mmio,0x90000000,115200";
> > +	};
> 
> Any reason this isn't using stdout-path?

I didn't know about stdout-path.  I will add it.

> > +
> > +	memory at 0 {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x02000000>;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		cpu at 0 {
> > +			compatible = "opencores,or1200-rtlsvn481";
> > +			reg = <0>;
> > +			clock-frequency = <20000000>;
> > +		};
> > +		cpu at 1 {
> > +			compatible = "opencores,or1200-rtlsvn481";
> > +			reg = <1>;
> > +			clock-frequency = <20000000>;
> > +		};
> > +	};
> 
> No enable-method or similar?
> 
> Is your SMP bringup/teardown architected?

There is no configurable enable-method yet.  The current SMP bringup method
is described in the architecture manual (SMP still under review).  If you
have any pointers that would be great.  See section 10.4

  https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf

In brief, Currently for SMP bringup both CPU's are expected to reset
directly to the startup vectors.  The main CPU (coreid == 0) will start
initialization where the secondary cpu's either spin or sleep until
signalled by the main CPU.

Original patch had cpu's spinning, but after [8/13] secondary cpus will go
into Doze mode.

> 
> > +
> > +	ompic: ompic {
> > +		compatible = "ompic";
> 
> This needs a vendor prefix.

This has also been brought up on [5/13], the question of vendor was
anticipated and I discussed with Stefan before sending the patch.
OpenRISC is not part of opencores any longer and this ompic was definitely
not implemented with an existing vendor in mind.

Perhaps we can just call it openrisc,ompic.  I will comment more on the
other thread.

Thanks for the review.

-Stafford
