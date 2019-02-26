From: BAndViG <bandvig@mail.ru>
Date: Tue, 26 Feb 2019 22:25:07 +0300
Subject: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
In-Reply-To: <20190201215417.GY3235@lianli.shorne-pla.net>
References: <CAAfxs76ysqzXWnJH02eDe0vSCLvuqwdwwKNiQoQV7Kfst4_mNw@mail.gmail.com>
 <CAKaYPCMtPDaXMRS9jmGijv2SGFP9LkUA51LFWmvtufWH7GnXLg@mail.gmail.com>
 <37FCFC974D464083BD1071538AD0EAFD@BAndViG>
 <CAF6YiZ6j=GbTG_G-q2=KYf6Nc-kACgGvxbtRMBjaRdQd8oi08A@mail.gmail.com>
 <20190201215417.GY3235@lianli.shorne-pla.net>
Message-ID: <D036467FCCAF4D23A7566ED09E17825B@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all

I've created MAROCCHINO new repo under my GitHub account 
(https://github.com/bandvig/or1k_marocchino) as a demo version.
Pay attention that monitors still have "mor1kx_" prefix and or1k_marocchino_cpu 
instance still called "mor1kx_cpu" to maintain compatibility with current 
verification infrastructure.
Please, make comments and proposals.
I'm planning to continue development in the repo as its structure will be 
approved. Btw, I'm not sure that it should be forked into OR organization. I 
think it would be clearer to create new repo and fill it. I could do that by 
myself If I've got write access to OR organization account (not sure). Or 
anybody welcome to do that.

WBR
Andrey


From: Stafford Horne
Sent: Saturday, February 02, 2019 12:54 AM
To: Julius Baxter
Cc: BAndViG ; Olof Kindgren ; Openrisc ; Philipp Wagner ; Stefan Wallentowitz
Subject: Re: [OpenRISC] [RFC] Splitting out Marocchino to new Repo

I changed the name of the instance to mor1kx_cpu to be able to use the
mor1x_monitor without any changes when switching core implementations during
testing.

I think the right way to do monitoring will be to use the new traceport_*
signals to monitor processor execution (there is already an implementation of
monitor that does that).  The traceport implementation will not require
inspecting internal signals as is done with the current mor1kx_monitor.

Its here:
  bench/verilog/mor1kx_monitor.v           - traditional monitor
  bench/verilog/mor1kx_traceport_monitor.v - traceport_based monitor
...

-Stafford

