From: jallouli kais <jalloulikais@yahoo.fr>
Date: Tue, 18 Jul 2017 10:31:32 +0000 (UTC)
Subject: [OpenRISC] OpenRISC Digest, Vol 17, Issue 3
In-Reply-To: <mailman.1.1500372002.20804.openrisc@lists.librecores.org>
References: <mailman.1.1500372002.20804.openrisc@lists.librecores.org>
Message-ID: <1515347566.3785337.1500373892651@mail.yahoo.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

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
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170718/413e4c67/attachment.html>
