From: BAndViG <bandvig@mail.ru>
Date: Sun, 11 Feb 2018 17:03:43 +0300
Subject: [OpenRISC] Problem with Marvell PHY connection to ETHOC
Message-ID: <CCDCD6D7A3674361AF43E1531DF60BFA@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello all!
I'm continue plying with Linux4 on Atlys SoC. And it looks like there is 
problem with connection Marvell's PHY to ETHOC.
Initially my device tree had Ethernet node in the form:

eth0: ethoc at 92000000 {
  compatible = "opencores,ethoc";
  device_type = "network";
  reg = <0x92000000 0x100>;
  interrupts = <4>;
  local-mac-address = [ 00 12 34 56 78 9a ];
};

Linux boot messages (related to ETHOC and PHYs):

/* begin */

Registering platform device 'Fixed MDIO bus.0'. Parent at platform
device: 'Fixed MDIO bus.0': device_add
bus: 'platform': add device Fixed MDIO bus.0
device: 'fixed-0': device_add
libphy: Fixed MDIO Bus: probed
bus: 'mdio_bus': add driver Marvell 88E1101
bus: 'mdio_bus': add driver Marvell 88E1112
bus: 'mdio_bus': add driver Marvell 88E1111
bus: 'mdio_bus': add driver Marvell 88E1118
bus: 'mdio_bus': add driver Marvell 88E1121R
bus: 'mdio_bus': add driver Marvell 88E1318S
bus: 'mdio_bus': add driver Marvell 88E1145
bus: 'mdio_bus': add driver Marvell 88E1149R
bus: 'mdio_bus': add driver Marvell 88E1240
bus: 'mdio_bus': add driver Marvell 88E1116R
bus: 'mdio_bus': add driver Marvell 88E1510
bus: 'mdio_bus': add driver Marvell 88E1540
bus: 'mdio_bus': add driver Marvell 88E1545
bus: 'mdio_bus': add driver Marvell 88E3016
bus: 'mdio_bus': add driver Marvell 88E6390
bus: 'platform': add driver ethoc
bus: 'platform': driver_probe_device: matched device 92000000.ethoc with 
driver ethoc
bus: 'platform': really_probe: probing driver ethoc with device 
92000000.ethoc
devices_kset: Moving 92000000.ethoc to end of list
device: 'ethoc-mdio--1': device_add
device: 'ethoc-mdio--1:00': device_add
bus: 'mdio_bus': add device ethoc-mdio--1:00
device: 'ethoc-mdio--1:01': device_add

/* skip similar messages for  ethoc-mdio--1:01 ... 1:1e */

device: 'ethoc-mdio--1:1f': device_add
bus: 'mdio_bus': add device ethoc-mdio--1:1f
libphy: ethoc-mdio: probed
driver: 'Generic PHY': driver_bound: bound to device 'ethoc-mdio--1:00'
device: 'eth0': device_add
driver: 'ethoc': driver_bound: bound to device '92000000.ethoc'
bus: 'platform': really_probe: bound device 92000000.ethoc to driver ethoc

/* end */

It looks incorrectly because:
1) ETHOC is connected to Marvell 88E1111 PHY on  Atlys board
2) PHY MDIO address = 00111 (from Atlys reference manual)

As the result:
  ifconfig eth0 inet 192.168.2.100 netmask 255.255.255.0 &
(from init.d) reports "ethoc 92000000.ethoc eth0: Link is Down" and 
networking applications (like ping) don't work.

If I understand correctly the two MDIO buses are registered
1) device 'Fixed MDIO bus.0'. Parent at platform
2) "ethoc-mdio" which is internal for ETHOC

And I need to describe that Marvell's PHY is connected to "ethoc-mdio" 
rather than to 'Fixed MDIO bus.0'.
After some investigation I tried the variant:

eth0: ethoc at 92000000 {
  compatible = "opencores,ethoc";
  device_type = "network";
  reg = <0x92000000 0x100>;
  interrupts = <4>;
  local-mac-address = [ 00 12 34 56 78 9a ];
  phy-handle = <&ethphy>;

  mdio {
    #address-cells = <1>;
    #size-cells = <0>;

    ethphy: ethernet-phy at 7 {
      /* Marvell 88E1111 */
      compatible = "ethernet-phy-id0141.0cc0",
                   "ethernet-phy-ieee802.3-c22";
      device_type = "ethernet-phy";
      reg = <0x7>;
    };
  };
};

However the result was the same.

How should I describe "ethoc-mdio" in device tree correctly?

BR
Andrey Bacherov


