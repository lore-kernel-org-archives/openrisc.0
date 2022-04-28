From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Thu, 28 Apr 2022 13:16:51 +0200
Subject: [OpenRISC] [Qemu-devel] [PATCH 2/7] target/openrisc: add
 shutdown logic
In-Reply-To: <YmnaDUpVI5ihgvg6@zx2c4.com>
References: <cover.1492384862.git.shorne@gmail.com>
 <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
 <YmmA4li384azQ2i9@zx2c4.com>
 <CAFEAcA9FZZzzZJaCHrepni+5oUELxW1TtZ3gZHxSUdfKdx+ghQ@mail.gmail.com>
 <Ymm6K3DjesAZR0OY@antec> <YmnaDUpVI5ihgvg6@zx2c4.com>
Message-ID: <Ymp3owBiSQIimgSy@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hey again,

On Thu, Apr 28, 2022 at 02:04:29AM +0200, Jason A. Donenfeld wrote:
> By the way, would this also help the reboot case? That's
> `reboot(RB_AUTOBOOT);`, which does:
> 
> machine_restart() ->
>   do_kernel_restart() ->
>     atomic_notifier_chain_register(&restart_handler_list, nb) ->
>       ???
> 
> As far as I can tell, nothing is wired into the reboot case for
> OpenRISC. Is this something that could be fixed in the kernel without
> having to patch QEMU? If so, then I could effectively get shutdown for
> my CI with the -no-reboot option, which is what I'm already doing for a
> few platforms.

I added 13 for this: https://lists.librecores.org/pipermail/openrisc/2022-April/003884.html

When you go add these nops to the specification, please remember to add
one for reboot too. Then, once that kernel code is merged and the
specification published, it'll be sensible to add shutdown and reboot
support to QEMU, per Peter's description.

Jason
