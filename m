From: Stafford Horne <shorne@gmail.com>
Date: Sun, 19 Feb 2017 16:21:03 +0900
Subject: [OpenRISC] GCC 5.4.0 Release and Binaries
Message-ID: <20170219072103.GA2379@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

We have released an updated version of the gcc 5.4.0 toolchain with
x86_64 binaries for easy consumption. The new version, tagged
or1k-5.4.0-20170218 is available on our github release page.

Get them now at:

  https://github.com/openrisc/or1k-gcc/releases/tag/or1k-5.4.0-20170218

There are 3 different binaries to choose from:

 - newlib - this is the baremetal toolchain good for running c code
   directly on the openrisc cpu without an operating system
 - musl - this is our main supported linux capable libc toolchain good for
   compiling applications to run on linux
 - nolib - this is a special build used for building kernels (like linux),
   this is specifically used by the kbuild linux build robots.

We have released full toolchain binaries with the following versions:

 - GCC 5.4.0     (from openrisc/or1k-gcc)
 - Binutils 2.26 (from upstream tarballs)
 - Newlib 2.4.0  (from openrisc/newlib)
 - Musl 1.1.16   (from upstream tarballs)

# Change Log #

This is mostly just a rebase and version bump release. Notable updates
for OpenRISC include.

 - Update to GCC 5.4.0 to allow building toolchain on newer gcc compilers.
 - Newlib patches to fix issue with environ and c++ pointed out during gdb
   testing.

# Note on GDB #

This release does not currently contain any GDB binaries. This is
because I am currently in progress of getting openrisc GDB
fully pushed to upsteam and the is under review.

For details watch for updates here on the OpenRISC mailing list as well as on
my upstream preparation branch here (beware of rebases):

 https://github.com/stffrdhrn/binutils-gdb.git or1k-upstream

Please let me know if you have any issues.

-Stafford
