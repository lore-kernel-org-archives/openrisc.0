From: Philipp Wagner <lists@philipp-wagner.com>
Date: Mon, 17 Jul 2017 23:45:22 +0200
Subject: [OpenRISC] [Librecores Developers] OpenRISC or1200
In-Reply-To: <2103336191.1199046.1500119251927@mail.yahoo.com>
References: <2103336191.1199046.1500119251927.ref@mail.yahoo.com>
 <2103336191.1199046.1500119251927@mail.yahoo.com>
Message-ID: <a67530d0-9bdb-237d-86d9-c83f5f1f04a5@philipp-wagner.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

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

>  but I dont undestand how I can simulate the openrisc. If so, how can I
> do that?

How do you want to simulate? In Verilator? Or in Icarus?

> I want juste to simulate it.how can I run the testbench. how can I
> simulate a hello word C program

If you just want to simulate a C program, you can also have a look at an
instruction set simulator, such as https://github.com/openrisc/or1ksim.

Philipp
