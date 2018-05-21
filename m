From: Stafford Horne <shorne@gmail.com>
Date: Mon, 21 May 2018 19:50:54 +0900
Subject: [OpenRISC] OpenRISC GCC porting, hello world working
In-Reply-To: <20180519095449.GD3652@lianli.shorne-pla.net>
References: <20180516000411.GA3652@lianli.shorne-pla.net>
 <4a01e543-dccc-ea9e-ed05-b0f903ff42ff@twiddle.net>
 <20180518220944.GB3652@lianli.shorne-pla.net>
 <8c935284-acda-aea4-5a47-01af6223a219@twiddle.net>
 <20180519095449.GD3652@lianli.shorne-pla.net>
Message-ID: <20180521105054.GK3652@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

Another update on the GCC port

Richard has reached out to me and has already fixed many cases and added a few
optimizations over the weekend.  The core of gcc backend is looking good and
already looks to have some features the old port didn't.

A few highlights:
  - Remapping of registers to get around storing 64-bit temporaries accross
    function calls  (GCC needs temp/callee saved registers to be adjacent, but
    openrisc's are odd/even)
  - varargs/pass by reference conventions matching old port
  - implemented nested functions
  - implemented sibcall handling (tailcall optimizations)
  - Many other fixups

From my milestone 2 list almost everything is complete.  Next he will be looking
at -fpic.

                === gcc Summary ===

# of expected passes            91749
# of unexpected failures        72
# of unexpected successes       3
# of expected failures          211
# of unresolved testcases       16
# of unsupported tests          2630
/home/shorne/work/gnu-toolchain/build-gcc/gcc/xgcc  version 9.0.0 20180426
(experimental) (GCC)

-Stafford
