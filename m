From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Wed, 16 May 2018 09:35:52 +0100
Subject: [OpenRISC] OpenRISC GCC porting, hello world working
In-Reply-To: <20180516000411.GA3652@lianli.shorne-pla.net>
References: <20180516000411.GA3652@lianli.shorne-pla.net>
Message-ID: <ca9c3bf6-a196-9b31-149a-ffb3c6723e32@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/05/18 01:04, Stafford Horne wrote:
> Hi All,
> 
> As you may know, from the last e-mail discussion [0] I have taken
> the option to start a new port.
> 
> After about 4 months of development on the OpenRISC GCC port [1]
> rewrite I have hit my first major milestone, the "Hello World"
> program is working. Over those 4 months I spent about 2 months
> working on my from scratch dummy SMH port then 2 months to get the
> OpenRISC port to this stage.

Hi Stafford,

Congratulations on the progress.

I think you are OK to try upstreaming after all the milestone 2 items
and with just C support. In general it is easy to get a smaller patch
upstream and then extend it. The key thing will to be eliminate all
those FAIL, XPASS and UNRESOLVED regressions. Deadline for stage 1 of
the 9.1 release will be some time in October/November.

If you have any changes to generic code, you should upstream them as
separate patches. If they are not specific to OpenRISC, you can do
them straightaway, otherwise you will need to submit them in parallel
with the OpenRISC port, explaining that they are needed to support
OpenRISC.

When you are close to submitting the patch, I suggest you prompt Joern
Rennecke to see if he will review your code.

BTW, the GNU Cauldron is in the UK this year.

  https://gcc.gnu.org/wiki/cauldron2018

Hope you might be able to make it. Certainly a good place to bend the
ears of potential reviewers!

Best wishes,


Jeremy
> 
> Next Steps
> 
> There are still many todo items before this will be ready for
> general use, including:
> 
> Milestone 2 items * Investigate and Fix test suite failures, see
> below * Write OpenRISC specific test cases * Ensure all memory
> layout and calling conventions are within spec * Ensure sign
> extending, overflow, and carry flag arithmetic is correct * Fix
> issues with GDB debugging target remote is working OK, target sim
> is having issues. * Implement stubbed todo items * Support for C++,
> I haven't even tried to compile it yet
> 
> Milestone 3 items * Support for position independent code (PIC) *
> Support for thread local storage (TLS) * Support for floating point
> instructions (FPU) * Support for Atomic Builtins
> 
> Somewhere between milestone 2 and 3 I will start to work on getting
> the port reviewed on the GCC and OpenRISC mailing lists. If anyone
> wants to review right now please feel free to send feedback.
> 
> Testsuite Results
> 
> === gcc Summary ===
> 
> # of expected passes            84301 # of unexpected failures
> 5096 # of unexpected successes       3 # of expected failures
> 211 # of unresolved testcases       2821 # of unsupported tests
> 2630 /home/shorne/work/gnu-toolchain/build-gcc/gcc/xgcc  version
> 9.0.0 20180426 (experimental) (GCC
> 
> FYI, I have just published an update on my blog too [2].
> 
> -Stafford
> 
> [0]
> https://lists.librecores.org/pipermail/openrisc/2018-January/000958.html
>
> 
[1] https://github.com/stffrdhrn/gcc/tree/or1k-port
> [2]
> https://stffrdhrn.github.io/software/embedded/openrisc/2018/05/16/openrisc_gcc_status_update.html
>
> 
_______________________________________________
> OpenRISC mailing list OpenRISC at lists.librecores.org 
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

iEYEARECAAYFAlr77WgACgkQvvWBcvtHVOErCQCeJ0gdesApPCifzRdXXWAhG29w
iSkAnj8BO+GoBTsJyqaMvrhDRI6CUwm0
=v+Fh
-----END PGP SIGNATURE-----
