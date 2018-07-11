From: Stafford Horne <shorne@gmail.com>
Date: Wed, 11 Jul 2018 23:49:43 +0900
Subject: [OpenRISC] GCC testing and dynamic linker
Message-ID: <20180711144943.GA9742@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Richard,

I was able to finally figure out how to get the GCC tests for the musl toolchain
to work under qemu.  I think I am able to pretty much reproduce the results you
have seen:

                  === gcc Summary ===

    # of expected passes            95846
    # of unexpected failures        8
    # of expected failures          266
    # of unresolved testcases       1
    # of unsupported tests          2405
    /opt/crossbuild/linux-musl/musl-cross-make/build/local/or1k-linux-musl/obj_gcc/gcc/xgcc
    version 9.0.0 20180426 (experimental) (GCC)


                === g++ Summary ===

    # of expected passes            110759
    # of unexpected failures        12
    # of expected failures          489
    # of unsupported tests          5234
    /opt/crossbuild/linux-musl/musl-cross-make/build/local/or1k-linux-musl/obj_gcc/gcc/testsuite/g++/../../xg++
    version 9.0.0 20180426 (experimental) (GCC)

For others, my site.exp is here:

  https://github.com/stffrdhrn/or1k-utils

I am hoping to get the testing setup as part of my continuous integration build.


I have a question, I noticed in `gcc\config\or1k\linux.h` you have put:

  #define MUSL_DYNAMIC_LINKER  "/lib/ld.so.1"

It seems musl produces the file as `ld-musl-or1k.so.1`.  Do you mind if I change
it?

-Stafford
