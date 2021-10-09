From: Stafford Horne <shorne@gmail.com>
Date: Sat, 9 Oct 2021 16:03:20 +0900
Subject: [OpenRISC] OpenRISC Proposal - Tininess Before Rounding
Message-ID: <CAAfxs75J8NTsQtOKav1oSYLF2C-QKPbTYE=E=6fbS6hPO=TsOg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

I just posted a new architecture proposal for openrisc here. Please
let me know there are any concerns.  I will be updating GCC to match
the "Tininess Before Rounding" behavior.

http://openrisc.io/proposals/p18-fpu-tininess

Contents
 Tininess Before Rounding (P18) 2021-10-09

The IEEE standard allows specifying how detecting of tininess occurs.
Tininess detection is how underflow exceptions are triggered. There
are two allows two method for detecting tininess one is before
rounding and the other being after rounding.

All FPU operations in an implementation be consistent in how this is
implemented to be compliant.

As BAndViG has already update the implementations on Mor1kx and
Marocchino to match the before rounding behavior; we propose that
OpenRISC specifies:
   - Tininess to be detected before rounding

This will require changes to:
  - The SPEC
       Section 4.12 Floating Point Control Status Register, extend to
explain how for underflow OpenRISC follows the tininess detection
before rounding policy for all operations..

  - GCC (currently set to tininess after rounding), Glibc (updated to
tininess before rounding)
  - Qemu to specify tininess to be detected before rounding.
  - Other simulators (sim, or1ksim).
  - *Note* Mor1kx and Marocchino verilog cores are already updated.

-Stafford
