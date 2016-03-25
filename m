From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Fri, 25 Mar 2016 12:18:10 +0000
Subject: [OpenRISC] [PATCH] openrisc: Add optimized memcpy routine
In-Reply-To: <alpine.LFD.2.20.1603250632270.5619@lianli.shorne-pla.net>
References: <1458570567-11596-1-git-send-email-shorne@gmail.com>
 <1458570567-11596-2-git-send-email-shorne@gmail.com>
 <56F22181.5020205@southpole.se>
 <alpine.LFD.2.20.1603250632270.5619@lianli.shorne-pla.net>
Message-ID: <56F52C82.8060905@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/03/16 22:06, Stafford Horne wrote:

<snip>

> This reply took me some time because I was spending the last few
> days looking into GCC. The openrisc GCC back end seems to need a
> rewrite before it can be upstreamed due to copyright issues. But we
> are still maintaining the port and keeping it up to date with
> upstream.

Hi Stafford,

I thought BlueCmd had resolved almost all of the copyright issues, by
talking to most of the copyright holders. So I didn't think there was
much that needed rewriting. Certainly there is no restriction to
anything done by Joern Rennecke (amylaar) as part of the major work he
did on GCC 4.5.1 a few years ago.

I don't think Joern is on this mailing list, but I'm sure he'll be
happy to review any OpenRISC GCC work.

Best wishes,


Jeremy

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

iEYEARECAAYFAlb1LIIACgkQvvWBcvtHVOG5qACgiAWUC/vU8Z9qkapBtujAIHVx
wpwAnjoidh1Pkz7lgnmfjVlyXkas6iXW
=7ZAg
-----END PGP SIGNATURE-----

