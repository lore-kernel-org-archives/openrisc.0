From: Marcus Swift <marcus_swift@crevinn.com>
Date: Mon, 24 Oct 2016 15:56:50 +0100
Subject: [OpenRISC] Nexys4DDR and OpenRISC
Message-ID: <CA+2xKH_FCLWPB_r=oP5OkCgttWrzWNeaz7bE0Gk5oos4LjQJGg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all,

I am new to OpenRISC and have been attempting to use FuseSOC to build a
system for the Nexys4DRR board.

I realize there is not a FuseSOC system set up in the official repository,
but I came across this and it looked promising: https://github.com/
andrzej-r/orpsoc-cores/tree/nexys4ddr/systems/nexys4ddr

I have been attempting to build this and I have run into several problems -
mostly I think with generating the cores using coregen and logicore.

*Error 1 - Using Coregen to generate project nexys4ddr_ddr2.cgp*

INFO:  Using Coregen to generate project nexys4ddr_ddr2.cgp
Release 14.7 - Xilinx CORE Generator P.20131013 (lin64)
Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
All runtime messages will be recorded in
/home/marcus/.cache/fusesoc/nexys4ddr_ddr2/coregen.log
INFO:encore:314 - Created non-GUI application for batch mode execution.
ERROR:sim:879 - Part 'xc6vlx75t-3ff484' is not valid for component
   'xilinx.com:ip:mig_7series:1.9'.
ERROR:sim:918 - Could not create instance of component MIG 7 Series v1.9.
ERROR: "coregen -r -b nexys4ddr_ddr2.xco -p nexys4ddr_ddr2.cgp" exited with
an error code.
ERROR: See stderr for details.


I cannot find the location of 'stderr' (unless it is /dev/stderr) and am
unsure of where to start with solving this error. If I rebuild the system
for a second time, this error does not occur but a new error arises.

*Error 2 - Using Xilinx Vivado to generate LogiCORE(tm) project
xilinx_mii_to_rmii.xci*

INFO:  Preparing xilinx_mii_to_rmii
INFO:  Using Xilinx Vivado to generate LogiCORE(tm) project
xilinx_mii_to_rmii.xci

****** Vivado v2016.2 (64-bit)
  **** SW Build 1577090 on Thu Jun  2 16:32:35 MDT 2016
  **** IP Build 1577682 on Fri Jun  3 12:00:54 MDT 2016
    ** Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.

source xilinx_mii_to_rmii.tcl
# create_project -force -in_memory xilinx_mii_to_rmii
# set_property target_language verilog [current_project]
# set_property part xc7a100tcsg324-1 [current_project]
# read_ip xilinx_mii_to_rmii.xci
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1704] No user IP repositories specified
INFO: [IP_Flow 19-2313] Loaded Vivado IP repository
'/opt/Xilinx/Vivado/2016.2/data/ip'.
# generate_target -force synthesis [get_files xilinx_mii_to_rmii.xci]
CRITICAL WARNING: [filemgmt 20-1365] Unable to generate target(s) for the
following file is locked: /home/marcus/.cache/fusesoc/
xilinx_mii_to_rmii/xilinx_mii_to_rmii.xci
Locked reason:
* IP definition 'Ethernet PHY MII to Reduced MII (2.0)' for IP
'xilinx_mii_to_rmii' has a different revision in the IP Catalog.
Please select 'Report IP Status' from the 'Tools/Report' menu or run Tcl
command 'report_ip_status' for more information.
INFO: [Common 17-206] Exiting Vivado at Mon Oct 24 14:11:34 2016...
The text leading up to this was:
--------------------------
|From a32b1c7380893e7ed890c19e8dd25bc66f226cb3 Mon Sep 17 00:00:00 2001
|From: Andrzej <ndrwrdck@gmail.com>
|Date: Thu, 17 Mar 2016 08:30:51 +0000
|Subject: [PATCH] Switched to work library
|
|---
| mii_to_rmii_v2_0/hdl/src/vhdl/mii_to_rmii.vhd      | 12 ++++++------
| mii_to_rmii_v2_0/hdl/src/vhdl/rmii_rx_agile.vhd    |  2 +-
| mii_to_rmii_v2_0/hdl/src/vhdl/rmii_rx_fixed.vhd    |  6 +++---
| mii_to_rmii_v2_0/hdl/src/vhdl/rmii_tx_agile.vhd    |  2 +-
| mii_to_rmii_v2_0/hdl/src/vhdl/rmii_tx_fixed.vhd    |  2 +-
| mii_to_rmii_v2_0/hdl/src/vhdl/rx_fifo.vhd          |  2 +-
| mii_to_rmii_v2_0/hdl/src/vhdl/rx_fifo_disposer.vhd |  2 +-
| mii_to_rmii_v2_0/hdl/src/vhdl/rx_fifo_loader.vhd   |  2 +-
| mii_to_rmii_v2_0/hdl/src/vhdl/srl_fifo.vhd         |  6 +++---
| 9 files changed, 18 insertions(+), 18 deletions(-)
| mode change 100755 => 100644 mii_to_rmii_v2_0/hdl/src/vhdl/mii_to_rmii.vhd
| mode change 100755 => 100644 mii_to_rmii_v2_0/hdl/src/vhdl/
rmii_rx_agile.vhd
| mode change 100755 => 100644 mii_to_rmii_v2_0/hdl/src/vhdl/
rmii_rx_fixed.vhd
| mode change 100755 => 100644 mii_to_rmii_v2_0/hdl/src/vhdl/
rmii_tx_agile.vhd
| mode change 100755 => 100644 mii_to_rmii_v2_0/hdl/src/vhdl/
rmii_tx_fixed.vhd
| mode change 100755 => 100644 mii_to_rmii_v2_0/hdl/src/vhdl/rx_fifo.vhd
| mode change 100755 => 100644 mii_to_rmii_v2_0/hdl/src/vhdl/
rx_fifo_disposer.vhd
| mode change 100755 => 100644 mii_to_rmii_v2_0/hdl/src/vhdl/
rx_fifo_loader.vhd
| mode change 100755 => 100644 mii_to_rmii_v2_0/hdl/src/vhdl/srl_fifo.vhd
|
|diff --git a/mii_to_rmii_v2_0/hdl/src/vhdl/mii_to_rmii.vhd
b/mii_to_rmii_v2_0/hdl/src/vhdl/mii_to_rmii.vhd
|old mode 100755
|new mode 100644
|index f8d34fa..ba59ec0
|--- a/mii_to_rmii_v2_0/hdl/src/vhdl/mii_to_rmii.vhd
|+++ b/mii_to_rmii_v2_0/hdl/src/vhdl/mii_to_rmii.vhd
--------------------------
File to patch:


When building the* '**xilinx_mii_to_rmii' *core, LogiCORE requests many
patches. I gives me the opportunity to enter the location of a file which
is a patch for the core. From looking at the source directory which I
linked to earlier it might be easier to see what is going on: (
https://github.com/andrzej-r/orpsoc-cores/tree/nexys4ddr/
cores/xilinx_mii_to_rmii)

If anyone could point me in the right direction on getting an OpenRISC SOC
to run on the nexys4ddr or in troubleshooting the above problems I would be
very grateful!

Thanks

Marcus
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20161024/3ff32fee/attachment.html>
