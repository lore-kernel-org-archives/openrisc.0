Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465563043CF
	for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082986; cv=none; b=qX2U/zIYJjbFAT6RU8A8a+VnBYiht/s5OdMFNj7i+Fi7E8XjDxzKLspjFMo0oT9zQg9I9BO5W2I+uKRcTfKQxuCXNZySwndJar3pMJEEKeByqEJtjfZNrJldJPkeOukEiUBRU/AgTJNF5wZ9qVZY2B36esE8a7tgbr50mGjuXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082986; c=relaxed/simple;
	bh=f9vnFO3ZAr0ROjj4iO2mIyqQF6HfJIBfN6MUQuNhK9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3SKwLhvd1FGa08t9akGxEBF9/scEVLAk2sTgGFFFIuBBhDvM5ATsVPrePZllp+prEW8QBhh1QT07vvpVk8YwY1aZ62uA6K/xxN/3p/Zu/UKpxhwilhBEp3gyQNBWjlQn50u2bOZKzF2SVr74C+JDuNcirMRzWVr6fw9nqVuaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5597a426807so551535e0c.2
        for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 10:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766082981; x=1766687781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUIzj6tuJEWWz1NJlvcpUJodOdc/whg25y/XKksTcLU=;
        b=NIs9Qzh/YsTe1lKVHBQkCYgloSdc85FFHpt0yNog5+X5TOirEyWwEo7/qZ4p3Vq0M8
         l37Eb/sMpWGdBOFH1YlAuLMEziN02FmMhVjVZq+8Y7Igx/vRDDEvTCLk746RtnDs5glG
         RyCKrI024i5g5rLZDGDINez0/8Hiv3lEXbLYy+aZPFzRqdmmyO4HVBheFW79l0msCh/d
         ALpE1J5uJ6e8oBgUj8aIed4m9+tuXMnOuhRd0ukI793A0WI7yTGp/2heAp9ojh58R5TO
         gmQm/nwYI34B6uHCSjsb9hzkgXJcyx8eky0oNhQZsFF3NHpdfuhaxxnxVJbr6V0hghfq
         Qb6w==
X-Forwarded-Encrypted: i=1; AJvYcCVBvhq1zCbt7nT/3w8sIYUuQEHjqM/36Sc8c57tFWBLAKtvGdK85jPmkvrXFQmXoqz07spZUzll2Wsgeg8wMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1MgIku/ri840H65GpjwP8JcxlYeFeQIvTHkPwc4RBOtnBhCke
	rQ1I3v8s4xJhSAbN4B+/l2NgwS6OhK7jS/bbc91yg7vgpZhUJUAySPcWQSRb4mq2
X-Gm-Gg: AY/fxX7+v8dQrG9De7QbVe+alsLNvG7NWnwMdykO8Hn3axyWCT2bQMD7EAeJlS5n5V4
	L4NFYdZ2d/LNsqJgffaGlxsmpLRmwnUetQuBd9SHS5tUXJFsCH9rdH7yZzZJb2yp5ReVAy2pOZM
	k9ERhB983RSK6zVZNo0IoLUPCKBWaSWIMJBneBzM5oWMFJ8idDdwkdmrVvp9i1IJB59aeJQp41a
	dF/x+CNy4WROjlktOAcqdgfH37v9V13ShKhfedFjqHlG7YgGsNPgVE/v9wrIs2xemizSGwWHyKS
	UYGy700Et/PidrjI0MVtIrhoInqlQu+owhl1YNDTNw0ENw9uRe/npNhjfjc0q4K0yXJYXQnpdYP
	p69F5JTlt7gNTv0rea/MhXy9RVxlvcQzzzy/Wy89ffQ2+Dd8XXynn1nKJJkveqzcrTCHJiSM6l1
	2a0z7QPEllppdtLJ0ZW9k9XgO+dxUUnLB60AGfIHUPAoeNLs32FQTeT46ICUOK/98=
X-Google-Smtp-Source: AGHT+IHcyBF4CdljOYK9cDoBJbbYtw9aQhhvz74Zfh6sY2P2z7d+UUpWgXExLmWN5pIFU73PWUgO8Q==
X-Received: by 2002:a05:6122:1d0b:b0:55b:305b:4e29 with SMTP id 71dfb90a1353d-5615befda3dmr227062e0c.21.1766082981366;
        Thu, 18 Dec 2025 10:36:21 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d132be6sm1623e0c.12.2025.12.18.10.36.20
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 10:36:20 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5597a426807so551515e0c.2
        for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 10:36:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXfajC7l6GTtLnZ8ORvgn9UCnQoLAdfx2ma37DDqZC8Jvdrh+9o+hZAiS23/2QwPOfb3CP6vZpMV64qXh4+w==@vger.kernel.org
X-Received: by 2002:a05:6122:7cd:b0:559:6e78:a434 with SMTP id
 71dfb90a1353d-5615bbb613fmr287845e0c.0.1766082979838; Thu, 18 Dec 2025
 10:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217080843.70621-1-shorne@gmail.com> <20251217080843.70621-3-shorne@gmail.com>
In-Reply-To: <20251217080843.70621-3-shorne@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Dec 2025 19:36:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVCY=5UypK65Ver6UZM_m6DZuw9mhfANMx4+Y6PgNAdmA@mail.gmail.com>
X-Gm-Features: AQt7F2re0c6O1zn3_Tpesl3XSo6xjfJa4z8L5_DxCBrXJH-PmZ5isCD3kETTmI4
Message-ID: <CAMuHMdVCY=5UypK65Ver6UZM_m6DZuw9mhfANMx4+Y6PgNAdmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] openrisc: dts: Add de0 nano config and devicetree
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stafford,

On Wed, 17 Dec 2025 at 09:23, Stafford Horne <shorne@gmail.com> wrote:
> The de0 nano from Terasic is an FPGA board that we use in the OpenRISC
> community to test OpenRISC configurations.  Add a base configuration for
> the board that runs an OpenRISC CPU at 50Mhz with 32MB ram, UART for
> console and some GPIOs for LEDs and switches.
>
> There is an older version of this floating around that defines all of
> the hardware on the board including SPI's, flash devices, sram, ADCs
> etc.  Eventually it would be good to get the full version upstream
> but for now I think a minimal board is good to start with.
>
> Link: https://openrisc.io/tutorials/de0_nano/
> Link: https://github.com/olofk/de0_nano
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/openrisc/boot/dts/de0-nano-common.dtsi
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x00000000 0x02000000>;
> +       };
> +
> +       leds: leds {

Move this up (or down), before (or after) all nodes with unit addresses?

> +               compatible = "gpio-leds";
> +               status = "okay";

Missing blank line.

> +               led-heartbeat {
> +                       gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
> +                       color = <LED_COLOR_ID_GREEN>;
> +                       function = LED_FUNCTION_HEARTBEAT;
> +                       linux,default-trigger = "heartbeat";
> +                       label = "heartbeat";
> +               };
> +       };
> +
> +       gpio0: gpio@91000000 {
> +               compatible = "opencores,gpio", "brcm,bcm6345-gpio";
> +               reg = <0x91000000 0x1>, <0x91000001 0x1>;
> +               reg-names = "dat", "dirout";
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               status = "okay";

"okay" is the default, so you could drop this line.

> +       };
> +
> +       gpio1: gpio@92000000 {
> +               compatible = "opencores,gpio", "brcm,bcm6345-gpio";
> +               reg = <0x92000000 0x1>, <0x92000001 0x1>;
> +               reg-names = "dat", "dirout";
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               status = "disabled";
> +       };
> +};

> --- /dev/null
> +++ b/arch/openrisc/boot/dts/de0-nano.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "de0-nano-common.dtsi"
> +
> +/ {
> +       model = "Terasic DE0 Nano";
> +       compatible = "opencores,or1ksim";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&pic>;
> +
> +       aliases {
> +               uart0 = &serial0;
> +       };
> +
> +       chosen {
> +               bootargs = "earlycon";

Do you need this?

> +               stdout-path = "uart0:115200";
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;

Missing blank line.

> +               cpu@0 {
> +                       compatible = "opencores,or1200-rtlsvn481";
> +                       reg = <0>;
> +                       clock-frequency = <50000000>;
> +               };
> +       };
> +
> +       /*
> +        * OR1K PIC is built into CPU and accessed via special purpose
> +        * registers.  It is not addressable and, hence, has no 'reg'
> +        * property.
> +        */
> +       pic: pic {
> +               compatible = "opencores,or1k-pic";
> +               #interrupt-cells = <1>;
> +               interrupt-controller;
> +       };
> +
> +       serial0: serial@90000000 {
> +               compatible = "opencores,uart16550-rtlsvn105", "ns16550a";
> +               reg = <0x90000000 0x100>;
> +               interrupts = <2>;
> +               clock-frequency = <50000000>;
> +       };
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
