From: Stefan Wallentowitz <stefan@wallentowitz.de>
Date: Sat, 19 Mar 2016 16:15:21 +0100
Subject: [OpenRISC] OpenRISC RTEMS
In-Reply-To: <56ED6894.7060009@oarcorp.com>
References: <56D49EF1.2050104@oarcorp.com> <56ED4668.2070408@wallentowitz.de>
 <56ED6894.7060009@oarcorp.com>
Message-ID: <56ED6D09.8010207@wallentowitz.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19.03.2016 15:56, Joel Sherrill wrote:

> Without testing, my first impression is that the target fragment
> for or1k should  look like this:

> or1k*-*-rtems*) tm_file="${tm_file} dbxelf.h elfos.h
> newlib-stdint.h ${cpu_type}/elf.h" tm_file="${tm_file}
> newlib-stdint.h or1k/rtems.h rtems.h" extra_parts="crti.o
> crtbegin.o crtend.o crtn.o" ;;
> 

Excellent. I was hoping so, I have already tested something similar
before and will push a release for the tools today.

Have a nice weekend!

Best,
Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlbtbQkACgkQuMYtsrn2U9ytcgCdEZqvn9srrinyBW+jS/tLrfug
LHEAn0v72OtAVvnOGUDO1ZCFuZ9/Y9Mz
=KLCW
-----END PGP SIGNATURE-----

