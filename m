From: Rieger, David <david.rieger@student.kit.edu>
Date: Mon, 16 Jan 2017 15:50:50 +0000
Subject: [OpenRISC] Clang does not understand .word directive in crt0.S
 in newlib source
In-Reply-To: <8952702f-a3f2-d170-56b8-e74e14a439b3@embecosm.com>
References: <bc71a06a3bf94b40b2adcdc8f816199f@kit-msx-25.kit.edu>,
 <8952702f-a3f2-d170-56b8-e74e14a439b3@embecosm.com>
Message-ID: <1484581850913.79528@student.kit.edu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Jeremy,

Good to know, thanks a lot!

David
________________________________________
From: OpenRISC <openrisc-bounces@lists.librecores.org> on behalf of Jeremy Bennett <jeremy.bennett@embecosm.com>
Sent: Monday, January 16, 2017 3:08 PM
To: openrisc@lists.librecores.org
Subject: Re: [OpenRISC] Clang does not understand .word directive in crt0.S in newlib source

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/01/17 11:24, Rieger, David wrote:
> Hello everyone
>
> I am trying to compile newlib using clang/LLVM 3.8.1 with the or1k
> target. However, compilation fails on
> newlib-source/libgloss/or1k/crt0.S with clang complaining it does
> not know the ".word" assembler directive:
>
> ../newlib-source/libgloss/or1k/crt0.S:83:19: error: unknown
> directive _or1k_stack_size: .word 8192 ^
> ../newlib-source/libgloss/or1k/crt0.S:84:29: error: unknown
> directive _or1k_exception_stack_size: .word 8192
>
> Any help in how I can fix this so clang compiles the file would be
> greatly appreciated.

Hi David,

Looks like your assembler is broken. One option is to not use the
integrated assembler, but instead use the standalone assembler from
the GNU tool chain.

Rather than using .int as in your following message, you might like to
use .2byte or .4byte which are more explicit about their exact meaning.

HTH,


Jeremy

>
> Thanks David
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

iEYEARECAAYFAlh80+cACgkQvvWBcvtHVOGEzgCdGgCz8sgYXSwvaFhzNwyN7qaH
TK0AoIYilwmJVT2vs5utnBoHsRWSHLeA
=+eDh
-----END PGP SIGNATURE-----
_______________________________________________
OpenRISC mailing list
OpenRISC at lists.librecores.org
https://lists.librecores.org/listinfo/openrisc
