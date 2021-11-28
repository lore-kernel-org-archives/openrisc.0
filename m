From: Julius Baxter <juliusbaxter@gmail.com>
Date: Sun, 28 Nov 2021 14:25:06 +1100
Subject: [OpenRISC] FPU licensing request
Message-ID: <CAF6YiZ5=4+bGKipC0-cScNsd2s+4PGwTchXAJTtETF47AukpLQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Jidan,

I'm getting in touch because I want to ask your permission to
relicense some of your FPU code.

I ported your VHDL FPU design to Verilog many years ago (2010 I think)
and it's since been included in the mor1kx OpenRISC CPU project by
Andrey Bacherov (CC'ed).

Example: https://github.com/openrisc/mor1kx/blob/master/rtl/verilog/pfpu32/pfpu32_addsub.v

It's currently got what looks like a permissive licence (as you can
see in the link above) but I would like to ask if we can relicense the
code under the CERN OHL V2 weakly permissive licence.

In summary, this licence is a file-level copyright for hardware
designs. The FAQ on CERN's site about the OHL is great for explaning
what the OHL v2 is what the W variant means:
https://ohwr.org/project/cernohl/wikis/faq#q-what-are-all-these-suffixes

This would only apply to this copy of the source. It does not affect
the other copies which are out there on the internet. I only ask this
for consistency across the mor1kx CPU project.

Your permission to do this would be greatly appreciated.

Happy to answer any other questions you have.

Cheers,
Julius
