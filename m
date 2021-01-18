From: Stafford Horne <shorne@gmail.com>
Date: Tue, 19 Jan 2021 06:29:17 +0900
Subject: [OpenRISC] Fwd: Re: [PATCH v5] net: can: Introduce MEN
 16Z192-00 CAN controller driver
In-Reply-To: <ea134d96-0856-62af-ea19-f6e0c2d80c90@duagon.com>
References: <81bbd71a-ff79-9f15-753a-d47b36b91756@pengutronix.de>
 <ea134d96-0856-62af-ea19-f6e0c2d80c90@duagon.com>
Message-ID: <20210118212917.GI2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Mon, Jan 18, 2021 at 09:09:04PM +0100, Abhijeet Badurkar wrote:
> ﻿
> Hello,
> 
> i am getting sparse warning regarding iounmap implementation of openrisc architecture for my CAN driver patch. Is there any specific reason why iounmap of openrisc doesn't have __iomem annnotation? Could you please suggest a fix for this?

Hello,

Sorry I missed this patch as I didn't recognize the subject.

You could send a patch for iounmap if you like.  Otherwise I can get around to
it in a few days.

The patch would be something like:

--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -77,7 +77,7 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long
size)
 }
 EXPORT_SYMBOL(ioremap);
 
-void iounmap(void *addr)
+void iounmap(void __iomem *addr)
 {
        /* If the page is from the fixmap pool then we just clear out
         * the fixmap mapping.


> Thx.
> 
> Abhijeet
> 
> 
> 
> M. Sc.
> Abhijeet Badurkar
> Software Engineering 
> Business Unit Computing Systems, duagon
> 
> duagon Germany GmbH
> Neuwieder Straße 1-7
> 90411 Nürnberg
> Deutschland
> Phone		+49 911 99 33 5 - 219
> www.duagon.com
> 
> duagon Germany GmbH - Geschäftsführer: Dr. Michael Goldbach - Mathias Kamolz - Kalina Scott - Handelsregister/Trade Register AG Nürnberg HRB 5540
> 
> This message and/or attachments may be privileged or confidential. If you are not the intended recipient, you are hereby notified that you have received this transmittal in error; any review, dissemination, or copying is strictly prohibited. If you received this transmittal in error, please notify us immediately by reply and immediately delete this message and all its attachments. Thank you.
> -------- Forwarded Message --------
> Subject: Re: [PATCH v5] net: can: Introduce MEN 16Z192-00 CAN controller driver
> Date: Fri, 16 Oct 2020 09:55:36 +0200
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> To: kernel test robot <lkp@intel.com>, Abhijeet Badurkar <abhijeet.badurkar@duagon.com>, wg at grandegger.com
> CC: kbuild-all at lists.01.org, linux-kernel at vger.kernel.org, linux-can at vger.kernel.org, andreas.geissler at duagon.com, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc at lists.librecores.org
> 
> * PGP Signed by an unknown key
> 
> On 10/16/20 1:49 AM, kernel test robot wrote:
> > Hi Abhijeet,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on 549738f15da0e5a00275977623be199fbbf7df50]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Abhijeet-Badurkar/net-can-Introduce-MEN-16Z192-00-CAN-controller-driver/20201005-192132
> > base:    549738f15da0e5a00275977623be199fbbf7df50
> > config: openrisc-randconfig-s031-20201015 (attached as .config)
> > compiler: or1k-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.3-rc1-dirty
> >         # https://github.com/0day-ci/linux/commit/267876771a434b2be3278c2c87d36146c0fac77d
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Abhijeet-Badurkar/net-can-Introduce-MEN-16Z192-00-CAN-controller-driver/20201005-192132
> >         git checkout 267876771a434b2be3278c2c87d36146c0fac77d
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 
> 
> I think it's the openrisc arch to blame^w ask here, since their iounmap doesn't
> have __iomem annotation.
> 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > "sparse warnings: (new ones prefixed by >>)"
> >>> drivers/net/can/men_z192_can.c:1057:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[assigned] dev_base @@
> >>> drivers/net/can/men_z192_can.c:1057:17: sparse:     expected void *addr
> >>> drivers/net/can/men_z192_can.c:1057:17: sparse:     got void [noderef] __iomem *[assigned] dev_base
> >>> drivers/net/can/men_z192_can.c:1071:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *dev_base @@
> >    drivers/net/can/men_z192_can.c:1071:21: sparse:     expected void *addr
> >>> drivers/net/can/men_z192_can.c:1071:21: sparse:     got void [noderef] __iomem *dev_base
> > 
> > vim +1057 drivers/net/can/men_z192_can.c
> > 
> >    962	
> >    963	static int men_z192_probe(struct mcb_device *mdev,
> >    964				  const struct mcb_device_id *id)
> >    965	{
> >    966		struct device *dev = &mdev->dev;
> >    967		struct men_z192 *priv;
> >    968		struct net_device *ndev;
> >    969		void __iomem *dev_base;
> >    970		struct resource *mem;
> >    971		u32 timebase;
> >    972		int ret = 0;
> >    973		int irq;
> >    974	
> >    975		mem = mcb_request_mem(mdev, dev_name(dev));
> >    976		if (IS_ERR(mem)) {
> >    977			dev_err(dev, "failed to request device memory");
> >    978			return PTR_ERR(mem);
> >    979		}
> >    980	
> >    981		dev_base = ioremap(mem->start, resource_size(mem));
> >    982		if (!dev_base) {
> >    983			dev_err(dev, "failed to ioremap device memory");
> >    984			ret = -ENXIO;
> >    985			goto out_release;
> >    986		}
> >    987	
> >    988		irq = mcb_get_irq(mdev);
> >    989		if (irq <= 0) {
> >    990			ret = -ENODEV;
> >    991			goto out_unmap;
> >    992		}
> >    993	
> >    994		ndev = alloc_candev(sizeof(struct men_z192), 0);
> >    995		if (!ndev) {
> >    996			dev_err(dev, "failed to allocat the can device");
> >    997			ret = -ENOMEM;
> >    998			goto out_unmap;
> >    999		}
> >   1000	
> >   1001		ndev->netdev_ops = &men_z192_netdev_ops;
> >   1002		ndev->irq = irq;
> >   1003		ndev->flags |= IFF_ECHO;
> >   1004	
> >   1005		priv = netdev_priv(ndev);
> >   1006		priv->ndev = ndev;
> >   1007		priv->dev = dev;
> >   1008	
> >   1009		priv->mem = mem;
> >   1010		priv->dev_base = dev_base;
> >   1011		priv->regs = priv->dev_base + MEN_Z192_REGS_OFFS;
> >   1012	
> >   1013		timebase = readl(&priv->regs->timebase);
> >   1014		if (!timebase) {
> >   1015			dev_err(dev, "invalid timebase configured (timebase=%d)\n",
> >   1016				timebase);
> >   1017			ret = -EINVAL;
> >   1018			goto out_free_candev;
> >   1019		}
> >   1020	
> >   1021		priv->can.clock.freq = timebase;
> >   1022		priv->can.bittiming_const = &men_z192_bittiming_const;
> >   1023		priv->can.do_set_mode = men_z192_set_mode;
> >   1024		priv->can.do_get_berr_counter = men_z192_get_berr_counter;
> >   1025		priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
> >   1026					       CAN_CTRLMODE_3_SAMPLES |
> >   1027					       CAN_CTRLMODE_LOOPBACK;
> >   1028	
> >   1029		spin_lock_init(&priv->lock);
> >   1030	
> >   1031		netif_napi_add(ndev, &priv->napi, men_z192_poll,
> >   1032			       NAPI_POLL_WEIGHT);
> >   1033	
> >   1034		skb_queue_head_init(&priv->echoq);
> >   1035	
> >   1036		mcb_set_drvdata(mdev, ndev);
> >   1037		SET_NETDEV_DEV(ndev, dev);
> >   1038	
> >   1039		ndev->ethtool_ops = &men_z192_ethtool_ops;
> >   1040	
> >   1041		ret = men_z192_register(ndev);
> >   1042		if (ret) {
> >   1043			dev_err(dev, "failed to register CAN device");
> >   1044			goto out_free_candev;
> >   1045		}
> >   1046	
> >   1047		devm_can_led_init(ndev);
> >   1048	
> >   1049		dev_info(dev, "MEN 16z192 CAN driver successfully registered\n");
> >   1050	
> >   1051		return 0;
> >   1052	
> >   1053	out_free_candev:
> >   1054		netif_napi_del(&priv->napi);
> >   1055		free_candev(ndev);
> >   1056	out_unmap:
> >> 1057		iounmap(dev_base);
> >   1058	out_release:
> >   1059		mcb_release_mem(mem);
> >   1060		return ret;
> >   1061	}
> >   1062	
> >   1063	static void men_z192_remove(struct mcb_device *mdev)
> >   1064	{
> >   1065		struct net_device *ndev = mcb_get_drvdata(mdev);
> >   1066		struct men_z192 *priv = netdev_priv(ndev);
> >   1067	
> >   1068		unregister_candev(ndev);
> >   1069		netif_napi_del(&priv->napi);
> >   1070	
> >> 1071		iounmap(priv->dev_base);
> >   1072		mcb_release_mem(priv->mem);
> >   1073	
> >   1074		free_candev(ndev);
> >   1075	}
> >   1076	
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
> > 
> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
> 
> 
> * Unknown Key
> * 0xFAEDEFA9
> 
>  
