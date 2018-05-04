From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Fri, 4 May 2018 08:39:41 +0100
Subject: [OpenRISC] GSoC 2018: Create a generic debug interface for
 soft-CPU core (or1k) and connect it to GDB- Shivam Aggarwal
In-Reply-To: <CAC5Ld+_tkTie=MnMEytcNerFeh8ZCw+njDV6JG-NQr=YKSn9aA@mail.gmail.com>
References: <CAC5Ld+_tkTie=MnMEytcNerFeh8ZCw+njDV6JG-NQr=YKSn9aA@mail.gmail.com>
Message-ID: <b7046ff3-3571-80f9-d9b8-1c10915a06f9@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/05/18 07:17, SHIVAM AGGARWAL wrote:
> Hi everyone,
> 
> 
> I am Shivam Aggarwal and have been selected for Google Summer of
> Code 2018 to work with TimVideos. for the project “Create a generic
> debug interface for soft-CPU core (or1k) and connect it to GDB”.

Hi Shivam,

Good luck with your project. You may find some of the Embecosm
Application Notes on interfacing hardware to GDB useful (in particular
EAN4)

  https://www.embecosm.com/resources/appnotes

You should think in particular about how multicore debug will work,
and the implications for your GDB server implementation. You'll need
to be able to support all-stop and non-stop modes, and hence
asynchronous debugging.

Best wishes,


Jeremy
> 
> 
> Project Description
> 
> The aim of this project is to create a run-control debug system for
> soft CPU core (or1k) used in HDMI2USB/LiteX firmware and add GDB to
> the system using Open SoC Debug Project.
> 
> 
> The Open SoC Debug (OSD) is an extensible, modular specification
> which enhances SoCs with debug and tracing functionality.
> Currently, it supports trace debugging and provides internal system
> access. As part of this project, run-control debugging specific
> module, i.e. CDM module and gdb-server bridge will be added to OSD.
> This will allow us to temporarily suspend the software execution on
> the SoC. The control over the execution flow is then handed over to
> GDB (GNU Debugger).
> 
> The second phase of the project is to integrate the OpenSoCDebug
> into HDMI2USB/Litex firmware. It will help in debugging the running
> code on Litex firmware, eg. issues encountered while running Linux
> on the real hardware.
> 
> 
> Project Proposal
> 
> https://docs.google.com/document/d/1M21W42uv5V8WvFqq2yd9UiY7CVC8CUBYiLz9Zh2wg64/edit?usp=sharing
>
> 
> 
> GSoC Progress Blog
> 
> https://gsoc2018timvideos.wordpress.com/
> 
> 
> RSS feed
> 
> https://gsoc2018timvideos.wordpress.com/feed/
> 
> 
> Github
> 
> https://github.com/shivmgg
> 
> 
> About me
> 
> I am Shivam Aggarwal, sophomere at IIIT Delhi. My interests
> include embedded systems, tinkering with hardware (mostly FPGAs)
> and Digital Design. My hobbies include graphic designing (posters,
> logos, T-shirts, etc.) and playing cricket. I am also a big Marvel
> fan.
> 
> 
> Contact Details
> 
> Mobile No.8800703950
> 
> Email Id : shivam16195 at iiitd.ac.in
> <mailto:shivam16195@iiitd.ac.in>
> 
> shivam280398 at gmail.com <mailto:shivam280398@gmail.com>
> 
> IRC: shivm28
> 
> 
> 
> *-Shivam Aggarwal*
> 
> 
> _______________________________________________ OpenRISC mailing
> list OpenRISC at lists.librecores.org 
> https://lists.librecores.org/listinfo/openrisc
> 

- -- 
Tel:     +44 (1590) 610184
Cell:    +44 (7970) 676050
SkypeID: jeremybennett
Twitter: @jeremypbennett
Email:   jeremy.bennett at embecosm.com
Web:     www.embecosm.com
PGP key: 1024D/BEF58172FB4754E1 2009-03-20
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlrsDj0ACgkQvvWBcvtHVOGcAwCdFTjtqx1eu/ckHwlGgOmY3Hmx
GsgAoJAQSsYxYb+ChulGY8HW1UkdObap
=/KMy
-----END PGP SIGNATURE-----
