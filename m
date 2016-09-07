From: Olof Kindgren <olof.kindgren@gmail.com>
Date: Wed, 7 Sep 2016 12:00:08 +0200
Subject: [OpenRISC] Access a de0_nano JP2 header pin
In-Reply-To: <CAAfxs75k6PATH63xh3FaW8qUcs+J63HSv2Y_DW1yABE-JaUp5A@mail.gmail.com>
References: <CAFoY_wzY6nT86JY95PaS7oRbQSU427tOZ02GhyDgS_dD7YcKoQ@mail.gmail.com>
 <CAAfxs75k6PATH63xh3FaW8qUcs+J63HSv2Y_DW1yABE-JaUp5A@mail.gmail.com>
Message-ID: <CAKaYPCPFRh0AHeikC8byyB+4u-V_7pWhOwh=5cFWRMpBM8j7Nw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Sep 7, 2016 at 1:31 AM, Stafford Horne <shorne@gmail.com> wrote:
> Hello,
>
> If you are using the de0 nano system from orpsoc-cores you should be able to
> see a memory mapped gpio controller at address 0x91000000.  That is
> connected to LEDs, you can see that looking data/pinmaps.tcl.
>
> To connect to jp2 just create another wishbone slave like that but connected
> to jp2.  You will need to regenerate the wishbone interconnect using the
> wishbone Perl script or something similar.
>
> In the programming side, you write to the registers in the gpio controller
> just by doing memory accesses.
>
> See an example here
> https://github.com/openrisc/tutorials/blob/master/sw/timer/timer.c
>
> -Stafford
>
>
> On 7 Sep 2016 1:04 a.m., "Manaar Alam" <alam.manaar@gmail.com> wrote:
>>
>> Hello,
>>
>> I am trying to build a bare-metal application to access a specific pin in
>> JP2 header. I want to set that pin to logic 1 on a given condition. Can you
>> help me how to do it?
>>
>> --
>> Manaar Alam,
>> Junior Research Fellow,
>> Secured Embedded Architecture Laboratory (SEAL),
>> Department of Computer Science and Engineering,
>> Indian Institute of Technology, Kharagpur,
>> West Bengal, India.
>>
>> _______________________________________________
>> OpenRISC mailing list
>> OpenRISC at lists.librecores.org
>> https://lists.librecores.org/listinfo/openrisc
>>
>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>

An even easier option, if you're not interested in the LEDs would be
just move on of the pins in the GPIO interface to a pin on the JP2
header.

For example change this line in data/pinmap.tcl
set_location_assignment PIN_A15 -to gpio0_io[0]
to use some other pin than A15

Then you can just write to the GPIO controller that is hooked up to
0x91000000 on the memory map

//Olof

