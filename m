From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Apr 2022 10:19:15 +0100
Subject: [OpenRISC] [Qemu-devel] [PATCH 2/7] target/openrisc: add
 shutdown logic
In-Reply-To: <Ymm6K3DjesAZR0OY@antec>
References: <cover.1492384862.git.shorne@gmail.com>
 <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
 <YmmA4li384azQ2i9@zx2c4.com>
 <CAFEAcA9FZZzzZJaCHrepni+5oUELxW1TtZ3gZHxSUdfKdx+ghQ@mail.gmail.com>
 <Ymm6K3DjesAZR0OY@antec>
Message-ID: <CAFEAcA-vPRHLPUi1ELET8eNMdZHk3Ftp35QmjZ2NX8B_ytiVfg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, 27 Apr 2022 at 23:27, Stafford Horne <shorne@gmail.com> wrote:
> Yes, this is what was brought up before.  At that time semihosting was mentioned
> and I tried to understand what it was but didn't really understand it as a general
> concept.  Is this something arm specific?

QEMU uses "semihosting" for the general concept of a syscall-like
ABI provided by the model that allows guest code written to use it
to access some facilities as if it were a program running on the host
rather than running on bare metal. (I think the term derives originally
from the Arm term for this kind of functionality, but the concept is
not Arm-specific.)

Arm defines an ABI which looks basically like a set of syscalls:
code sets up some registers and executes a specific SVC or HLT
or other magic instruction, and the implementation is supposed to
then act on that. You can do things like "open file", "read file",
"exit", etc.
 https://github.com/ARM-software/abi-aa/blob/main/semihosting/semihosting.rst
The idea is that simulators and also debug stubs or debuggers can
implement this, and then bare-metal code can be written to use it,
mainly for debugging and test case purposes.

The risc-v folks decided they needed similar functionality, and
that the easiest way to do this was to align with the Arm specification
and document the risc-v specific bits:
https://github.com/riscv/riscv-semihosting-spec

Some other architectures have an equivalent thing but which isn't
the same set of functions as the Arm version; eg the nios2 version
is documented here:
https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;a=blob;f=libgloss/nios2/nios2-semi.txt;hb=HEAD

> Since the qemu or1k-sim defines our "simulator", I suspect I could add a
> definition of our simulator ABI to the OpenRISC architecture specification.  The
> simulation uses of l.nop N as ABI hooks is a de-facto standard for OpenRISC.
> From the way you describe this now I take it if we document this as a
> architecture simulation ABI the patch would be accepted.

If it's something that (a) is documented officially somewhere and
(b) everybody is using consistently (ie guest code such as GNU newlib,
QEMU, other simulators, etc), then yes, that's OK. It sounds like
you just need to write down the details of your de-facto standard
to turn it into a de-jure one :-)

We would want to guard it behind the existing semihosting command
line option, rather than having it enabled all the time, but that
part should be straightforward.

-- PMM
