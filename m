From: Doug Evans <dje@google.com>
Date: Wed, 18 Oct 2017 13:54:07 -0700
Subject: [OpenRISC] [PATCH v6 6/6] sim: testsuite: add testsuite for
	or1k sim
In-Reply-To: <20171018204150.GB2694@lianli.shorne-pla.net>
References: <001a114f5b1a3f96ef055bd80203@google.com>
 <20171018204150.GB2694@lianli.shorne-pla.net>
Message-ID: <CADPb22T9Rn-2y1rTyaF0AVFFmwf-GvFOBp9UwR55AnzkDjLkOQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 18, 2017 at 1:41 PM, Stafford Horne <shorne@gmail.com> wrote:
> On Wed, Oct 18, 2017 at 08:23:12PM +0000, Doug Evans wrote:
>> Stafford Horne writes:
>>  > From: Peter Gavin <pgavin@gmail.com>
>>  >
>>  > This is the testsuite for the or1k sim, it tests running many of the
>>  > basic architecture instructions on the openrisc sim.
>>  >
>>  > sim/testsuite/sim/or1k/ChangeLog:
>>  >
>>  > 2017-10-04  Peter Gavin  <pgavin@gmail.com>
>>  >        Stafford Horne <shorne@gmail.com>
>>  >
>>  >    * add.S: New file.
>>  >    * alltests.exp: New file.
>>  >    * and.S: New file.
>>  >    * basic.S: New file.
>>  >    * div.S: New file.
>>  >    * ext.S: New file.
>>  >    * find.S: New file.
>>  >    * flag.S: New file.
>>  >    * fpu.S: New file.
>>  >    * jump.S: New file.
>>  >    * load.S: New file.
>>  >    * mac.S: New file.
>>  >    * mfspr.S: New file.
>>  >    * mul.S: New file.
>>  >    * or.S: New file.
>>  >    * or1k-asm-test-env.h: New file.
>>  >    * or1k-asm-test-helpers.h: New file.
>>  >    * or1k-asm-test.h: New file.
>>  >    * or1k-asm.h: New file.
>>  >    * or1k-test.ld: New file.
>>  >    * ror.S: New file.
>>  >    * shift.S: New file.
>>  >    * spr-defs.h: New file.
>>  >    * sub.S: New file.
>>  >    * xor.S: New file.
>>  >
>>  > sim/testsuite/ChangeLog:
>>  >
>>  > 2017-01-20  Stafford Horne  <shorne@gmail.com>
>>  >        Peter Gavin  <pgavin@gmail.com>
>>  >
>>  >    * testsuite/configure: Regenerated.
>>
>> Missing change to testsuite/configure.tgt?
>
> I dont think there is a testsuite/configure.tgt.  The configure.ac sources
> ../configure.tgt.  That is from 3/6.  Maybe we could argue that the
> testsuite/configure regen goes into that patch, but I think it makes sense
> here.

Righto. The patch is fine. I missed the change in 3/6.
