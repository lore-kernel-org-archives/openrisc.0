From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Aug 2018 06:53:09 +0900
Subject: [OpenRISC] OpenRISC Port Submission
Message-ID: <20180823215309.GH9742@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Since February this year I have been working on an OpenRISC clean room rewrite.

  http://stffrdhrn.github.io/software/embedded/openrisc/2018/02/03/openrisc_gcc_rewrite.html

As per the article, the old port had issues with some of the owners signing over
FSF copyright.  To get around this I discussed options with the group and in the
end I opted for a clean room rewrite.

The new code base has been written by me and more recently Richard Henderson.  I
trust that both of us have our FSF GCC copyright's in place.

# Question

How should I go about submitting the port for review?  Should I split libgcc and
gcc into separate patches?  i.e. One patch mail for ChangeLog?  Or would you
prefer a single patch mail?  The patch size is around 150k.

Sorry, I understand its a big patch.

# Testing

We have been running the GCC testsuite with newlib and musl libc.  The results
are good.  See results published in a test build/release here:

 - https://github.com/stffrdhrn/gcc/releases/tag/or1k-9.0.0-20180730

# Early Review

If you are interested in reviewing online I have pushed:

 - https://github.com/stffrdhrn/gcc/commits/or1k-port-1

To build this requires some of the latest binutils patches submitted here:

 - https://gcc.gnu.org/ml/gcc-patches/2018-08/msg01506.html
 - git tree: https://github.com/stffrdhrn/binutils-gdb/tree/or1k-6

-Stafford
