From: Stefan Wallentowitz <stefan@wallentowitz.de>
Date: Sat, 19 Mar 2016 13:30:32 +0100
Subject: [OpenRISC] OpenRISC RTEMS
In-Reply-To: <56D49EF1.2050104@oarcorp.com>
References: <56D49EF1.2050104@oarcorp.com>
Message-ID: <56ED4668.2070408@wallentowitz.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Joel, Hi Hesham,

(included the new mailing list)

I am currently in the process of releasing prebuilt RTEMS toolchains
for OpenRISC. We have started a tutorial repository for multiple
targets and want to distribute baremetal, Linux and RTEMS examples
with it.

For that I am bumping the GCC version to 4.9.3 and GDB to 7.9. I am
adopting the patching mechanism that Hesham also used in RSB, but I
found a critical difference during the build.

Joel supplied the RTEMS patch here:
https://github.com/openrisc/or1k-gcc/commit/1ee8ef4190f85934479fa00abbc29e164af80f00
In the target macros elfos.h is missing:
https://github.com/openrisc/or1k-gcc/commit/1ee8ef4190f85934479fa00abbc29e164af80f00#diff-fb3f1781891204d8e51adc85578e9a19R2179
Hesham's build includes elfos.h:
https://github.com/heshamelmatary/or1k-rtems/blob/master/patches/gcc-4.8.2-or1k-rtems.diff#L5701

After applying an or1k patch to GCC from our development branch, the
critical part is the ASM_OUTPUT_ASCII macro:
https://github.com/openrisc/or1k-gcc/blob/or1k-4.9.3/gcc/config/or1k/or1k.h#L1022

The function used there is only defined in the ARM port, hence I think
this is an artifact. In our standard builds the macro is overwritten
by elfos.h.

I think the default fix is to include elfos.h in the target macros,
but I was wondering if something speaks against it. Is it a decision
to keep it out, Joel?

Sorry, I am not an expert on this stuff.

Best,
Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlbtRmgACgkQuMYtsrn2U9wqyACfeEO2qA/R+DXo1cNXdZlTctwf
mekAnRfjaHXcuanNMrKODCUa7XbJP8Wf
=xINJ
-----END PGP SIGNATURE-----

