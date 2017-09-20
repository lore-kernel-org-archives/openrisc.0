From: Stafford Horne <shorne@gmail.com>
Date: Wed, 20 Sep 2017 23:04:42 +0900
Subject: [OpenRISC] [PATCH] openrisc: dts: or1ksim: Add stdout-path
In-Reply-To: <CAMuHMdWwJ0VWCOfvLW9rWRq445XB3iPgk3VfHN_f9_eU4Lrjeg@mail.gmail.com>
References: <20170919140024.32563-1-shorne@gmail.com>
 <CAMuHMdWwJ0VWCOfvLW9rWRq445XB3iPgk3VfHN_f9_eU4Lrjeg@mail.gmail.com>
Message-ID: <20170920140442.GY2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Geert,

On Tue, Sep 19, 2017 at 06:49:48PM +0200, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Tue, Sep 19, 2017 at 4:00 PM, Stafford Horne <shorne@gmail.com> wrote:
> > During reviews of the OpenRISC SMP patch series it was suggested to add
> > stdout-path to the SMP dts file.  Add stdout-path to our other dts files
> > to be a good example.
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  arch/openrisc/boot/dts/or1ksim.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/openrisc/boot/dts/or1ksim.dts b/arch/openrisc/boot/dts/or1ksim.dts
> > index 5d4f9027afaf..ecc30968cbcb 100644
> > --- a/arch/openrisc/boot/dts/or1ksim.dts
> > +++ b/arch/openrisc/boot/dts/or1ksim.dts
> > @@ -7,6 +7,7 @@
> >
> >         chosen {
> >                 bootargs = "console=uart,mmio,0x90000000,115200";
> > +               stdout-path = &serial0;
> 
> I think that should be:
> 
> -               bootargs = "console=uart,mmio,0x90000000,115200";
> +               stdout-path = "serial0:115200";
> 
> If stdout-path is present, it will become the default console.
> All other UART parameters except for the serial speed are derived from
> the serial0 node (= serial at 90000000) in DT.

Thanks for the tip.  I have seen examples using alias `&serial0;` and using
the name directly `serio0:115200', but I guess I didnt really understand
what was going on.  I read through as much of the console initialization,
of, earlycon and printk code as I needed to refresh my memory on this...

It seems there are a few other issues here:
  - To use "serial0:115200" we will need an alias to the path (or specify
    the full path)
  - It looks like we can't use console= and stdout-path at the same time
  - We still need "earlycon" to define that we want to initialize early
    printk

I think updating to something like the below works, but its a few extra
lines:


diff --git a/arch/openrisc/boot/dts/or1ksim.dts b/arch/openrisc/boot/dts/or1ksim.dts
index ecc30968cbcb..37779a45947c 100644
--- a/arch/openrisc/boot/dts/or1ksim.dts
+++ b/arch/openrisc/boot/dts/or1ksim.dts
@@ -5,9 +5,13 @@
 	#size-cells = <1>;
 	interrupt-parent = <&pic>;
 
+	aliases {
+		uart0 = &serial0;
+	};
+
 	chosen {
-		bootargs = "console=uart,mmio,0x90000000,115200";
-		stdout-path = &serial0;
+		bootargs = "earlycon";
+		stdout-path = "uart0:115200";
 	};
 
 	memory at 0 {


The boot prompt before showed:

    Kernel command line: console=uart,mmio,0x90000000,115200
    earlycon: uart0 at MMIO 0x90000000 (options '115200')
    bootconsole [uart0] enabled

Now it shows:

    Kernel command line: earlycon
    earlycon: ns16550a0 at MMIO 0x90000000 (options '115200')
    bootconsole [ns16550a0] enabled

-Stafford
