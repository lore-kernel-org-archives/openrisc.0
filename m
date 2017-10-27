From: Rob Herring <robh@kernel.org>
Date: Thu, 26 Oct 2017 22:18:33 -0500
Subject: [OpenRISC] [PATCH 3/3] openrisc: dts: Add OpenRISC platform SoC
In-Reply-To: <20171022024641.28478-4-shorne@gmail.com>
References: <20171022024641.28478-1-shorne@gmail.com>
 <20171022024641.28478-4-shorne@gmail.com>
Message-ID: <20171027031833.g6zrlewszok4vksx@rob-hp-laptop>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Oct 22, 2017 at 11:46:41AM +0900, Stafford Horne wrote:
> Add devicetree binding documentation for the OpenRISC platform
> opencores,or1ksim.  This is the main OpenRISC reference platform
> supporting multiple FPGA SoC's.
> 
> This format is based on some of the mips binding docs as we have
> similar requirements.
> 
> Also, update maintainers so openrisc related binding changes are visible
> to the openrisc team.

Your subject is wrong because this is not a dts patch. Use 
"dt-bindings: openrisc: ..."

> 
> Suggested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  .../bindings/openrisc/opencores/or1ksim.txt        | 39 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/openrisc/opencores/or1ksim.txt

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

