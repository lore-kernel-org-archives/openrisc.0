From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Sat, 4 Jun 2016 22:50:36 +0300
Subject: [OpenRISC] l.bf instruction issue
In-Reply-To: <CAPnaeVAZkj6XtbiArJ0d6gKphnSR=CoXYCimjoy=2N5uc+H3sw@mail.gmail.com>
References: <CAPnaeVAZkj6XtbiArJ0d6gKphnSR=CoXYCimjoy=2N5uc+H3sw@mail.gmail.com>
Message-ID: <CADzBsGPkWW12+TDMF7g6CyaWuf60h=tJEHqfQa3_MKAokYKHzA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Jun 4, 2016 at 9:08 PM, Javier <javieralso@gmail.com> wrote:
> Hello everybody.
>
> I'm relatively new with OR1K architecture and I would need some help with a
> problem I'm experiencing.
>
> At the moment, I'm developing a small robotic project using a DEO Nano board
> and fusesoc. I managed to synthetise the SoC adding a self-made module and
> seems to work OK, but during debuging, I noticed something that I don't know
> whether can be a bug.
>
> When the core (mor1k) executes the instruction l.bf (or l.bnf) and the flag
> is set (or cleared in the case of l.bnf), the processor doesn't branch to
> the target address after executing the instruction in the delay slot.
>
> This happens sometimes, not all the times.
>

Can you provide some more precise information on when this happens?

> Is this a bug?
>
> For your reference, I tried with mor1k 3.1, 4.1 and master. or1ksim works
> fine, but not the implementation.
>

Is this with or without your modifications? what do they do?
Does this only happen when you run on FPGA or can you reproduce in
simulations (e.g. with verilator)?

