From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Apr 2022 19:47:33 +0100
Subject: [OpenRISC] [Qemu-devel] [PATCH 2/7] target/openrisc: add
 shutdown logic
In-Reply-To: <YmmA4li384azQ2i9@zx2c4.com>
References: <cover.1492384862.git.shorne@gmail.com>
 <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
 <YmmA4li384azQ2i9@zx2c4.com>
Message-ID: <CAFEAcA9FZZzzZJaCHrepni+5oUELxW1TtZ3gZHxSUdfKdx+ghQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, 27 Apr 2022 at 18:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey Stafford,
>
> On Mon, Apr 17, 2017 at 08:23:51AM +0900, Stafford Horne wrote:
> > In openrisc simulators we use hooks like 'l.nop 1' to cause the
> > simulator to exit.  Implement that for qemu too.
> >
> > Reported-by: Waldemar Brodkorb <wbx@openadk.org>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
>
> I'm curious as to why this never got merged. I noticed I'm entirely able
> to shutdown or to reboot (which is mostly what I care about) Linux from
> OpenRISC. It just hangs.

This kind of thing needs to be either:
 (1) we're modelling real hardware and that real hardware has a
device or other mechanism guest code can prod to cause a power-off
or reboot. Then we model that device, and guest code triggers a
shutdown or reboot exactly as it would on the real hardware.
 (2) there is an architecturally defined ABI for simulators, debug
stubs, etc, that includes various operations typically including
an "exit the simulator" function. (Arm semihosting is an example
of this.) In that case we can implement that functionality,
guarded by and controlled by the appropriate command line options.
(This is generally not as nice as option 1, because the guest code
has to be compiled to have support for semihosting and also because
turning it on is usually also giving implicit permission for the
guest code to read and write arbitrary host files, etc.)

Either way, undocumented random hacks aren't a good idea, which
is why this wasn't merged.

thanks
-- PMM
