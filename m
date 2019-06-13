From: Stafford Horne <shorne@gmail.com>
Date: Thu, 13 Jun 2019 22:00:51 +0900
Subject: [OpenRISC] GSoC 2019 : mor1kx CI
In-Reply-To: <CAF69Gooae0PKYQYTLaB=r5u8AG0_Rxk5qhXXr-YppoKAm0h_vQ@mail.gmail.com>
References: <CAF69Gooae0PKYQYTLaB=r5u8AG0_Rxk5qhXXr-YppoKAm0h_vQ@mail.gmail.com>
Message-ID: <20190613130051.GK2358@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jun 13, 2019 at 04:29:13PM +0530, Nancy Chauhan wrote:
> Hello Stafford ,
> 
> This week I am working on creating jenkinsfile for Librecores-ci in mor1kx
> and I wanted  to keep in discussion with you for next goals of having Yosys
> and GCC/GDB .
> As per discussion with oleg today the best way for  having yosys would be
> to invoke it from FuseSoC , e.g. by defining it in
> https://github.com/openrisc/mor1kx/blob/master/mor1kx.core#L79 .
> Stafford can you please give me more refernce on it .

Hello,

I would suggest finding an example project using yosys and fusesoc.  Olof's serv
is probably a good candiate see:

  https://github.com/olofk/serv/blob/master/serv.core

Notice he uses the `icestorm` tool which is actually yosys.  You can read the
docs for fusesoc.  If you get stuck its usually its easy to get far by reading
the code too as its not too complicated.

  https://github.com/olofk/fusesoc - fusesoc frontend (we use api2)
  https://fusesoc.readthedocs.io/en/latest/index.html - docs

Its probably easiest for you try to to create an icestore tool build, copying
what is in serv and see what happens.

--

Step 2 for yosys

The icestorm will do both synthesis and place and routei (pnr).  We really just
need synthesis to get the resource usage.  But I guess it doesn't hurt to do pnr
as well.

Also, note yosys supports synthesizing for different FPGA targets see
http://www.clifford.at/yosys/documentation.html, there is:

  - synth_intel
  - synth_xilinx
  - synth_ice40
  - etc.

Ideally we would like to synthesize for a few different target FPGAs to track
for resource usage regressions across more cases.  But, currently fusesoc only
support synth_ice40.

It may mean we need to patch fusesoc and or edalize.
https://github.com/olofk/edalize.  Edalize is the backend for fusesoc which does
the actual calls to the EDA tools (like yosys).  In edalize source code I can
see there are backends for:

 - icestorm - as documented in fusesoc
 - trellis - yosys synth_ecp5

We could work with the fusesoc team to add, xilinx/intel backends as well.
Also, note there is a branch where Olof started working on a no PNR backend:

  https://github.com/olofk/edalize/tree/icestorm-pnr-none/edalize

CCed fusesoc team and openrisc team.

-Stafford
