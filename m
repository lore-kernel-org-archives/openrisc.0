From: Olof Kindgren <olof.kindgren@gmail.com>
Date: Wed, 23 Aug 2017 07:36:16 +0200
Subject: [OpenRISC] (no subject)
In-Reply-To: <CA+S6h7S=mpfw_YemQ95aw5RH7jOwm2k-JMsGUk-5i-CjBiUkAA@mail.gmail.com>
References: <CA+S6h7S=mpfw_YemQ95aw5RH7jOwm2k-JMsGUk-5i-CjBiUkAA@mail.gmail.com>
Message-ID: <CAKaYPCNLb_8AW+D3n1AForW73QUR-6Ngs=HTXzzG3cebhTumuQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Aug 22, 2017 at 5:10 PM, Kais JALLOULI <kais.jallouli@enit.utm.tn>
wrote:

> Hi all  ,
> I am a student and I want to use the cpu openrisc or1200.I have a question
> and I wish you repond me. Please  there   is any simple makefile example
> for or1200 without using it as SoC? I am grateful for help.
> Thanks a lot.
>
>
>
> <https://mailtrack.io/> Sent with Mailtrack
> <https://mailtrack.io/install?source=signature&lang=en&referral=kais.jallouli@enit.utm.tn&idSignature=22>
>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>
>
Hi,

First of all I would recommend you to use mor1kx instead of or1200 as
mor1kx is a more modern replacement with better code, more features and
likely less bugs. If you need to use or1200 anyway for some reason, that's
fine too

I'm not sure what kind of makefile you need. For example, are you looking
at integrating the CPU in a larger project, run simulations or perform
stand-alone ASIC synthesis?

For the two first cases I would recommend you to use FuseSoC (
https://github.com/olofk/fusesoc). With FuseSoC you can easily build a
larger system from existing components. There is also a small simulation
SoC for both or1200 (or1200-generic) and mor1kx (mor1kx-generic). I know
you said that you don't want a SoC, but you will at least need some kind of
memory to store program/data and likely a UART for output, which is exactly
what is included in the simulation systems.

Hope this helps as a starting point

//Olof
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170823/70804c5b/attachment.html>
