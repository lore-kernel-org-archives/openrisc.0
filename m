From: Wesley Sneijers <wsneijers@famsneijers.nl>
Date: Mon, 7 May 2018 10:53:45 +0200
Subject: [OpenRISC] problems debugging
Message-ID: <2809101268-5468@mail.famsneijers.nl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Dear all,

For a graduate project I am implementing the mor1kx espresso. It will be used as a PTP time component in a larger design. The system will be implemented on a FPGA and contains the mor1kx espresso (release 4.1), 32Kb on-chip RAM and a PTP hardware component. The HDL components themselves are all working. However I've hit quite a wall when trying to debug the system using openocd and GDB. I am able to load the executable and run them on target. Also setting breakpoints works. However reading out variables and locals doesn't.

To be more precise it tries to read the variables and locals but at the wrong address. The on-chip ram is located at 0x0. I have already setup register R1 as stack-pointer (0x8000) and validated the stack working correctly. However GDB tries to read the variables at address 0xFFFFFFF0 (for example). I assume GDB also reads the stack-pointer from R1 and calculates the correct addresses from it (please correct me if i'm wrong). When I look at the register values (using info reg in GDB) they appear to be all zero. I am sure their not (checked in hardware). Could this be the problem? If so is this a common problem (I don't know where to look anymore).

I already tried several versions of openocd (0.10, 0.9.0, 0.7), the mor1kx (4.1, 4.0, latest) and the advanced debug interface (3.1.0, latest version). Any pointers you can give are greatly appreciated!

Thanks,

Wesley Sneijers
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180507/e170d4bc/attachment.html>
