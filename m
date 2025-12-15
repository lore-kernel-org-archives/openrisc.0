Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB34B327BF5;
	Mon, 15 Dec 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817926; cv=none; b=UX2H3IUa/BlxHts2wQfk9xUBlRPKCIky4H2akCR35uaUbSZYvf+zWoYZvk2FQL11xqJ16p4TpsCJIjOtur4e/ADhRUKE7finGc8KKXNJYf8TI/NcdMUC+j+shNYJmZuwoNDeGBanIs0bgUUfkbgRRfgzCO7hfvGTm81+ElPuHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817926; c=relaxed/simple;
	bh=1f1aViFkOFAmJQE/TCKhkD4MI6Aus6s/Jv4bow266SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVdDT/xcFkoeX2MdkObXJHM7F1Fo2LkVfR0ioYabGlLehNDQjfDKgFOf22Kl59LVczCnDqbJOOzbXF6DMu/5uv2eZXfo906Hv8hZjU7Dot/JjKvhYcDrcY5Gvx1bSlCqzksfE1+RybKUWCmzryMcDNwnOnk0kCEouo4YDVGnQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFKhdELY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFKhdELY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ABBC4CEF5;
	Mon, 15 Dec 2025 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765817926;
	bh=1f1aViFkOFAmJQE/TCKhkD4MI6Aus6s/Jv4bow266SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFKhdELYpljcXVRwJ5lHk3bzov1j7FKsszVnM+OoM5+2V08j0Xul0BIK+kQDy3QSr
	 KEWxQsyXtjRmUSkRjB04pZ/SVo4i3RZPVlwCi45+AW2eIG6L6WbCrADWdVlVQwSBZX
	 Utu7Qnf9bvUSlrXA3d3vsgosRL7sOa41wQ5Zz/uVzAueAyc3xy3AZqpVZljiX2sJDC
	 eLPw6WrV/MPjnlDTlwea6lo96BYpsGRi2Ii5kkZeSgf62UNDqoh5AvJO+23FPMuCq6
	 9hNTYjzmT8T+CpweZ7wy/JRAh2DwRTdvM62ZVaLXpZBGimwc+PbSvCSOENSD8A8Mk/
	 tg5vzVS7Zkk5Q==
Date: Mon, 15 Dec 2025 16:58:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Masahiro Yamada <masahiroy@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] openrisc: dts: Split simple smp dts to dts and dtsi
Message-ID: <20251215-graffiti-baritone-4eb0a9f58ab6@spud>
References: <20251214180158.3955285-1-shorne@gmail.com>
 <20251214180158.3955285-5-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0sV9EhkQWCfdz+K/"
Content-Disposition: inline
In-Reply-To: <20251214180158.3955285-5-shorne@gmail.com>


--0sV9EhkQWCfdz+K/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 06:01:44PM +0000, Stafford Horne wrote:
> Split out the common memory, CPU and PIC definitions of the simple SMP
> system to a DTSI file which we will later use for our De0 Nano multicore
> board device tree.  We also take this opportunity to swich underscores
> to dashes as that seems to be the more common convention for DTS files.
>=20
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/boot/dts/simple-smp.dts         | 25 +++++++++++++++++++
>  .../dts/{simple_smp.dts =3D> simple-smp.dtsi}   | 12 ++++-----
>  arch/openrisc/configs/simple_smp_defconfig    |  2 +-
>  3 files changed, 32 insertions(+), 7 deletions(-)
>  create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
>  rename arch/openrisc/boot/dts/{simple_smp.dts =3D> simple-smp.dtsi} (89%)
>=20
> diff --git a/arch/openrisc/boot/dts/simple-smp.dts b/arch/openrisc/boot/d=
ts/simple-smp.dts
> new file mode 100644
> index 000000000000..174c2613c419
> --- /dev/null
> +++ b/arch/openrisc/boot/dts/simple-smp.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "simple_smp.dtsi"
> +
> +/ {
> +	model =3D "Simple SMP Board";
> +};
> +
> +&cpu0 {
> +	clock-frequency =3D <20000000>;
> +};
> +
> +&cpu1 {
> +	clock-frequency =3D <20000000>;
> +};
> +
> +&serial0 {
> +	clock-frequency =3D <20000000>;
> +};
> +
> +&enet0 {
> +	status =3D "okay";
> +};
> diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/d=
ts/simple-smp.dtsi
> similarity index 89%
> rename from arch/openrisc/boot/dts/simple_smp.dts
> rename to arch/openrisc/boot/dts/simple-smp.dtsi
> index 71af0e117bfe..92770bb6fcf7 100644
> --- a/arch/openrisc/boot/dts/simple_smp.dts
> +++ b/arch/openrisc/boot/dts/simple-smp.dtsi
> @@ -1,4 +1,3 @@
> -/dts-v1/;
>  / {
>  	compatible =3D "opencores,or1ksim";
>  	#address-cells =3D <1>;
> @@ -22,15 +21,15 @@ memory@0 {
>  	cpus {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			compatible =3D "opencores,or1200-rtlsvn481";
>  			reg =3D <0>;
> -			clock-frequency =3D <20000000>;
> +			clock-frequency =3D <0>;

Delete these lines, don't set them to zero please.

>  		};
> -		cpu@1 {
> +		cpu1: cpu@1 {
>  			compatible =3D "opencores,or1200-rtlsvn481";
>  			reg =3D <1>;
> -			clock-frequency =3D <20000000>;
> +			clock-frequency =3D <0>;
>  		};
>  	};
> =20
> @@ -57,7 +56,7 @@ serial0: serial@90000000 {
>  		compatible =3D "opencores,uart16550-rtlsvn105", "ns16550a";
>  		reg =3D <0x90000000 0x100>;
>  		interrupts =3D <2>;
> -		clock-frequency =3D <20000000>;
> +		clock-frequency =3D <0>;
>  	};
> =20
>  	enet0: ethoc@92000000 {
> @@ -65,5 +64,6 @@ enet0: ethoc@92000000 {
>  		reg =3D <0x92000000 0x800>;
>  		interrupts =3D <4>;
>  		big-endian;
> +		status =3D "disabled";
>  	};
>  };
> diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/c=
onfigs/simple_smp_defconfig
> index 6008e824d31c..db77c795225e 100644
> --- a/arch/openrisc/configs/simple_smp_defconfig
> +++ b/arch/openrisc/configs/simple_smp_defconfig
> @@ -20,7 +20,7 @@ CONFIG_SLUB=3Dy
>  CONFIG_SLUB_TINY=3Dy
>  CONFIG_MODULES=3Dy
>  # CONFIG_BLOCK is not set
> -CONFIG_BUILTIN_DTB_NAME=3D"simple_smp"
> +CONFIG_BUILTIN_DTB_NAME=3D"simple-smp"
>  CONFIG_SMP=3Dy
>  CONFIG_HZ_100=3Dy
>  CONFIG_OPENRISC_HAVE_SHADOW_GPRS=3Dy
> --=20
> 2.51.0
>=20

--0sV9EhkQWCfdz+K/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUA+QQAKCRB4tDGHoIJi
0oXUAP9ZgLXM4jIgjjO4eXOSYrpVbxUajhu2uveCxGDb8xKmMAEAoHLqmECO3vR4
PfFqWCKa/YlVBOQltjV8qYq56ZeavQc=
=Xui6
-----END PGP SIGNATURE-----

--0sV9EhkQWCfdz+K/--
