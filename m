From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Mon, 19 Sep 2016 16:36:18 +0100
Subject: [OpenRISC] [PATCH 5/7] openrisc: Support both old (or32) and
 new (or1k) toolchain
In-Reply-To: <bb977e99-dbb4-d602-373b-8f3bfb73b796@wallentowitz.de>
References: <1474036985-20981-1-git-send-email-shorne@gmail.com>
 <1474036985-20981-6-git-send-email-shorne@gmail.com>
 <8ef63a71-81ed-2a0c-e204-666f7fba5e4c@roeck-us.net>
 <alpine.LFD.2.20.1609191459410.2354@lianli.shorne-pla.net>
 <94c3ee37-19f7-de94-9b61-bc1c06a84d72@roeck-us.net>
 <alpine.LFD.2.20.1609191807160.2352@lianli.shorne-pla.net>
 <e4b7075b-a1f7-74b1-ca62-4f3d2058fe97@roeck-us.net>
 <alpine.LFD.2.20.1609192247170.2352@lianli.shorne-pla.net>
 <57DFF797.7090400@southpole.se>
 <bb977e99-dbb4-d602-373b-8f3bfb73b796@wallentowitz.de>
Message-ID: <6933ccf2-69d9-89c8-e880-a6d5296af4f8@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/09/16 15:58, Stefan Wallentowitz wrote:
> On 19.09.2016 16:35, Jonas Bonn wrote:
> 
>> The bigger question I would have at this point is the value of
>> the code remaining upstream...  Five years ago, there was a
>> promise to try to get the toolchain upstream within a year or
>> two; to this day, I don't know that much progress has been made
>> there so this architecture still requires a hodge-podge of tools
>> from various sources to build.
> 
> Actually, there has been progress. All but one copyright assignment
> have been collected and the last one blocks everything. Don't know
> if there was any progress on this since last ORCONF, but at least
> we have like nearly up-to-date GCC for some time now.

Is there anything I can do to help unblock the last one (having been
around longer than some, I know some of the old contributors).

Best wishes,


Jeremy

> 
> Cheers, Stefan
> 
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
Version: GnuPG v2

iGMEARECACMFAlfgBfIcHGplcmVteS5iZW5uZXR0QGVtYmVjb3NtLmNvbQAKCRC+
9YFy+0dU4fbcAKCBzSWPJ1diLz+0SLg4CpEwqBzOoACdF0y4LSTM/vBsqEFVDWN/
nnkYeZ8=
=52x5
-----END PGP SIGNATURE-----

