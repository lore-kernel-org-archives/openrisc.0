From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Mon, 19 Sep 2016 17:27:19 +0100
Subject: [OpenRISC] [PATCH 5/7] openrisc: Support both old (or32) and
 new (or1k) toolchain
In-Reply-To: <alpine.LFD.2.20.1609200102541.2352@lianli.shorne-pla.net>
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
 <6933ccf2-69d9-89c8-e880-a6d5296af4f8@embecosm.com>
 <alpine.LFD.2.20.1609200102541.2352@lianli.shorne-pla.net>
Message-ID: <db88c929-06e9-72ab-5618-1b38f3069c4f@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/09/16 17:09, Stafford Horne wrote:
> 
> 
> On Mon, 19 Sep 2016, Jeremy Bennett wrote:
> 
> On 19/09/16 15:58, Stefan Wallentowitz wrote:
>>>> On 19.09.2016 16:35, Jonas Bonn wrote:
>>>> 
>>>>> The bigger question I would have at this point is the value
>>>>> of the code remaining upstream...  Five years ago, there
>>>>> was a promise to try to get the toolchain upstream within a
>>>>> year or two; to this day, I don't know that much progress
>>>>> has been made there so this architecture still requires a
>>>>> hodge-podge of tools from various sources to build.
>>>> 
>>>> Actually, there has been progress. All but one copyright
>>>> assignment have been collected and the last one blocks
>>>> everything. Don't know if there was any progress on this
>>>> since last ORCONF, but at least we have like nearly
>>>> up-to-date GCC for some time now.
> 
> Is there anything I can do to help unblock the last one (having
> been around longer than some, I know some of the old
> contributors).
> 
>> Hi Jeremy,
> 
>> As far as I can tell from SVN->Git history, the first changes I
>> can see are from "Giuseppe Scrivano" and "Peter Gavin" back in
>> 2011.  I am guessing the fsf assignments are in order with them.
> 
>> I would think that the one that Stefan mentioned is missing is
>> *Damjan* who started port. Are you in contact with him?

Hi Stafford,

I haven't seen him for some years, but I'm connected on LinkedIn. I
can ping him.

I presume you would like him to assign any copyright in the GNU tool
chain for OpenRISC?

Best wishes,


Jeremy

>> https://gcc.gnu.org/ml/gcc/1999-11n/msg00391.html - first contact
>> with gcc
> 
>> https://gcc.gnu.org/ml/gcc-patches/2002-02/msg01788.html -
>> further discussions
> 
>> I would leave it to Stefan for details.
> 
>>>> _______________________________________________ OpenRISC
>>>> mailing list OpenRISC at lists.librecores.org 
>>>> https://lists.librecores.org/listinfo/openrisc
>>>> 
> 
> 
> -- Tel:     +44 (1590) 610184 Cell:    +44 (7970) 676050 SkypeID:
> jeremybennett Twitter: @jeremypbennett Email:
> jeremy.bennett at embecosm.com Web:     www.embecosm.com PGP key:
> 1024D/BEF58172FB4754E1 2009-03-20
>> _______________________________________________ OpenRISC mailing
>> list OpenRISC at lists.librecores.org 
>> https://lists.librecores.org/listinfo/openrisc

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

iGMEARECACMFAlfgEeYcHGplcmVteS5iZW5uZXR0QGVtYmVjb3NtLmNvbQAKCRC+
9YFy+0dU4crgAKCTurydEQd1fKESpyf2ax2JmtB5RACfeyjovCkmP3P9MJXnCJ4u
SM0RDa8=
=sPoa
-----END PGP SIGNATURE-----

