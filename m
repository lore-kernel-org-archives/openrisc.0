From: jallouli kais <jalloulikais@yahoo.fr>
Date: Wed, 19 Jul 2017 10:49:28 +0000 (UTC)
Subject: [OpenRISC] OpenRISC Digest, Vol 17, Issue 4
In-Reply-To: <mailman.1.1500458401.15711.openrisc@lists.librecores.org>
References: <mailman.1.1500458401.15711.openrisc@lists.librecores.org>
Message-ID: <1979566711.437787.1500461368182@mail.yahoo.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

https://openrisc.io/software  
For building a  software, OpenRISC is supported by a 32-bit GNUtoolchain offering C and C++ support. The toolchain is available inseveral forms, depending on your use case.   
   -  or1k-elf for bare metal use, based on thenewlib library. 
   -  or1k-linux-uclibc for Linux application use, based on theuClibc-ng library. 
   -  or1k-linux-musl also for Linux applicationuse, based on the musl library. (recommended over uClibc) 
   -  or1k-rtems for building software that runs onthe RTEMS operating system.

 Should I instal the  gnu toolchain for compilation ?

 

    Le Mercredi 19 juillet 2017 12h00, "openrisc-request at lists.librecores.org" <openrisc-request@lists.librecores.org> a écrit :
 

 Send OpenRISC mailing list submissions to
    openrisc at lists.librecores.org

To subscribe or unsubscribe via the World Wide Web, visit
    https://lists.librecores.org/listinfo/openrisc
or, via email, send a message with subject or body 'help' to
    openrisc-request at lists.librecores.org

You can reach the person managing the list at
    openrisc-owner at lists.librecores.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of OpenRISC digest..."


Today's Topics:

  1. Re: OpenRISC Digest, Vol 17, Issue 3 (jallouli kais)
  2. Re: Dev Digest, Vol 14, Issue 5 (Philipp Wagner)
  3. Re: Dev Digest, Vol 14, Issue 5 (jallouli kais)
  4. Re: Dev Digest, Vol 14, Issue 5 (Philipp Wagner)


----------------------------------------------------------------------

Message: 1
Date: Tue, 18 Jul 2017 10:31:32 +0000 (UTC)
From: jallouli kais <jalloulikais@yahoo.fr>
To: "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
Subject: Re: [OpenRISC] OpenRISC Digest, Vol 17, Issue 3
Message-ID: <1515347566.3785337.1500373892651@mail.yahoo.com>
Content-Type: text/plain; charset="utf-8"

I know that mor1kx is more perfermant than or1200. But I chose or1200 since it contains a dsp block. Does mor1kx contain a dsp?I just want to test it on an example c soft to verify its working.Can you help me. I am a debutant.I want to use it later in order to integrate it in network on chip 

    Le Mardi 18 juillet 2017 12h00, "openrisc-request at lists.librecores.org" <openrisc-request@lists.librecores.org> a écrit :
 

 Send OpenRISC mailing list submissions to
    openrisc at lists.librecores.org

To subscribe or unsubscribe via the World Wide Web, visit
    https://lists.librecores.org/listinfo/openrisc
or, via email, send a message with subject or body 'help' to
    openrisc-request at lists.librecores.org

You can reach the person managing the list at
    openrisc-owner at lists.librecores.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of OpenRISC digest..."


Today's Topics:

  1. Re: [Librecores Developers] OpenRISC or1200 (Philipp Wagner)


----------------------------------------------------------------------

Message: 1
Date: Mon, 17 Jul 2017 23:45:22 +0200
From: Philipp Wagner <lists@philipp-wagner.com>
To: dev@lists.librecores.org, openrisc at lists.librecores.org
Subject: Re: [OpenRISC] [Librecores Developers] OpenRISC or1200
Message-ID: <a67530d0-9bdb-237d-86d9-c83f5f1f04a5@philipp-wagner.com>
Content-Type: text/plain; charset=utf-8

Hi,

I've forwarded your mail to the correct mailing list, please reply to
that one.

Am 15.07.2017 um 13:47 schrieb jallouli kais:
> 
> Hello I download the RTL code of openrisc or1200.I run at
> https://openrisc.io
> <https://openrisc.io/>

The most recent (and recommended) implementation of or1k is mor1kx. You
can find the source code here: https://github.com/openrisc/mor1kx

>  but I dont undestand how I can simulate the openrisc. If so, how can I
> do that?

How do you want to simulate? In Verilator? Or in Icarus?

> I want juste to simulate it.how can I run the testbench. how can I
> simulate a hello word C program

If you just want to simulate a C program, you can also have a look at an
instruction set simulator, such as https://github.com/openrisc/or1ksim.

Philipp


------------------------------

Subject: Digest Footer

_______________________________________________
OpenRISC mailing list
OpenRISC at lists.librecores.org
https://lists.librecores.org/listinfo/openrisc


------------------------------

End of OpenRISC Digest, Vol 17, Issue 3
***************************************


  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170718/413e4c67/attachment-0001.html>

------------------------------

Message: 2
Date: Tue, 18 Jul 2017 17:57:53 +0200
From: Philipp Wagner <lists@philipp-wagner.com>
To: jallouli kais <jalloulikais@yahoo.fr>,
    openrisc at lists.librecores.org
Subject: Re: [OpenRISC] Dev Digest, Vol 14, Issue 5
Message-ID: <c880cd71-edc3-8d9e-00c6-e8ffcd00b340@philipp-wagner.com>
Content-Type: text/plain; charset=utf-8

[Please reply to the openrisc mailing list.]

Hello,

Am 18.07.2017 um 17:49 schrieb jallouli kais:
> I know that mor1kx is more perfermant than or1200. But I chose or1200
> since it contains a dsp block. Does mor1kx contain a dsp?

what do you mean by a "dsp block"? It's a CPU, after all. The
performance is pretty similar IIRC, 1 cycle per instruction for most
instructions.

> I just want to test it on an example c soft to verify its working.
> Can you help me. I am a debutant.

In this case, us or1ksim.

> I want to use it later in order to integrate it in network on chip

If you are looking for a system including a NoC you could have a look at
OpTiMSoC (https://optimsoc.org).

Philipp


------------------------------

Message: 3
Date: Tue, 18 Jul 2017 16:09:34 +0000 (UTC)
From: jallouli kais <jalloulikais@yahoo.fr>
To: "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
    "lists at philipp-wagner.com" <lists@philipp-wagner.com>
Subject: Re: [OpenRISC] Dev Digest, Vol 14, Issue 5
Message-ID: <1400400087.4242525.1500394174858@mail.yahoo.com>
Content-Type: text/plain; charset="utf-8"

For the NoC,we have our NoC.For testing a soft c code;  I  must installing  his toolchain ?Thanks 

    Le Mardi 18 juillet 2017 17h57, Philipp Wagner <lists@philipp-wagner.com> a écrit :
 

 [Please reply to the openrisc mailing list.]

Hello,

Am 18.07.2017 um 17:49 schrieb jallouli kais:
> I know that mor1kx is more perfermant than or1200. But I chose or1200
> since it contains a dsp block. Does mor1kx contain a dsp?

what do you mean by a "dsp block"? It's a CPU, after all. The
performance is pretty similar IIRC, 1 cycle per instruction for most
instructions.

> I just want to test it on an example c soft to verify its working.
> Can you help me. I am a debutant.

In this case, us or1ksim.

> I want to use it later in order to integrate it in network on chip

If you are looking for a system including a NoC you could have a look at
OpTiMSoC (https://optimsoc.org).

Philipp


  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170718/b6805fc0/attachment-0001.html>

------------------------------

Message: 4
Date: Wed, 19 Jul 2017 10:47:33 +0200
From: Philipp Wagner <lists@philipp-wagner.com>
To: "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
Subject: Re: [OpenRISC] Dev Digest, Vol 14, Issue 5
Message-ID: <17abb4a9-1a49-d1b7-04e5-79ca4f28d197@philipp-wagner.com>
Content-Type: text/plain; charset=utf-8; format=flowed

Hi,

On 07/18/2017 06:09 PM, jallouli kais wrote:
> For testing a soft c code;  I  must installing  his toolchain ?

What do you mean by "his toolchain"? For information how to use or1ksim, 
see https://github.com/openrisc/tutorials/tree/master/or1ksim and many 
other resources on the Internet.

Philipp


------------------------------

Subject: Digest Footer

_______________________________________________
OpenRISC mailing list
OpenRISC at lists.librecores.org
https://lists.librecores.org/listinfo/openrisc


------------------------------

End of OpenRISC Digest, Vol 17, Issue 4
***************************************


   
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170719/8c92fb0b/attachment-0001.html>
