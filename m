From: SHIVAM AGGARWAL <shivam16195@iiitd.ac.in>
Date: Fri, 4 May 2018 11:47:24 +0530
Subject: [OpenRISC] GSoC 2018: Create a generic debug interface for soft-CPU
 core (or1k) and connect it to GDB- Shivam Aggarwal
Message-ID: <CAC5Ld+_tkTie=MnMEytcNerFeh8ZCw+njDV6JG-NQr=YKSn9aA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi everyone,

I am Shivam Aggarwal and have been selected for Google Summer of Code 2018
to work with TimVideos. for the project “Create a generic debug interface
for soft-CPU core (or1k) and connect it to GDB”.

Project Description

The aim of this project is to create a run-control debug system for soft
CPU core (or1k) used in HDMI2USB/LiteX firmware and add GDB to the system
using Open SoC Debug Project.

The Open SoC Debug (OSD) is an extensible, modular specification which
enhances SoCs with debug and tracing functionality. Currently, it supports
trace debugging and provides internal system access. As part of this
project, run-control debugging specific module, i.e. CDM module and
gdb-server bridge will be added to OSD. This will allow us to temporarily
suspend the software execution on the SoC. The control over the execution
flow is then handed over to GDB (GNU Debugger).

The second phase of the project is to integrate the OpenSoCDebug into
HDMI2USB/Litex firmware. It will help in debugging the running code on
Litex firmware, eg. issues encountered while running Linux on the real
hardware.

Project Proposal

https://docs.google.com/document/d/1M21W42uv5V8WvFqq2yd9UiY7CVC8CUBYiLz9Zh2wg64/edit?usp=sharing

GSoC Progress Blog

https://gsoc2018timvideos.wordpress.com/

RSS feed

https://gsoc2018timvideos.wordpress.com/feed/

Github

https://github.com/shivmgg

About me

I am Shivam Aggarwal, sophomere at IIIT Delhi. My interests include
embedded systems, tinkering with hardware (mostly FPGAs) and Digital
Design. My hobbies include graphic designing (posters, logos, T-shirts,
etc.) and playing cricket. I am also a big Marvel fan.

Contact Details

Mobile No. 8800703950

Email Id : shivam16195 at iiitd.ac.in

        shivam280398 at gmail.com

IRC: shivm28


*-Shivam Aggarwal*
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180504/544a4183/attachment-0001.html>
