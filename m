From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Sat, 15 Oct 2016 15:57:04 +0100
Subject: [OpenRISC] OpenRISC isa changes proposal
In-Reply-To: <CAFukJ-C7TYtzkszLZEMSgS=io6NnyLcX5mOzq=kZGHH7M1w7_A@mail.gmail.com>
References: <CAFukJ-C7TYtzkszLZEMSgS=io6NnyLcX5mOzq=kZGHH7M1w7_A@mail.gmail.com>
Message-ID: <c1120129-7537-31b2-394b-c1c09720bb76@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/10/16 20:23, Alexey Baturo wrote:
> Hi, everyone!
> 
> I've been looking at openrisc isa recently, especially at orvdx
> part and have some ideas to improve it.
> 
> First of all, there is no ORVDX32 extention and I don't see why 
> shouldn't we have it? It would not be very efficient, but why not?
> 
> Next one is related to vector instructions encoding. Let's say
> there are 2 types of vector instructions: the ones who operate on
> bytes and another operate on vector. To distinguish them it would
> be useful to assume the byte ones have LSB of 0 and 1 for halves.
> To do that we have to slightly tune the encoding: i.e. make
> lv.avg.b and lv.avg.h be encoded with 0x38 and 0x39 respectively,
> instead of 0x39 and 0x3a. I could provide suggested list of
> changes.

Hi Alexey,

I wish you well with this project. Although the original spec included
a set of vector instructions, I don't remember anyone ever
implementing them. IIRC they were never added to Or1ksim either.

So you should have plenty of scope to refine the details of the spec.

Best wishes,


Jeremy

> 
> Thanks for attention.
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

iGMEARECACMFAlgCQ8AcHGplcmVteS5iZW5uZXR0QGVtYmVjb3NtLmNvbQAKCRC+
9YFy+0dU4ZGNAJ4upMBOQjcVz1fCAjEmeWUJLHZl/QCdENfZzxvYn6awIWkiog0i
A6C0o1U=
=l6UW
-----END PGP SIGNATURE-----

