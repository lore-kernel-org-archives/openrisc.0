From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Tue, 11 Oct 2016 22:23:50 +0300
Subject: [OpenRISC] OpenRISC isa changes proposal
Message-ID: <CAFukJ-C7TYtzkszLZEMSgS=io6NnyLcX5mOzq=kZGHH7M1w7_A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi, everyone!

I've been looking at openrisc isa recently, especially at orvdx part and
have some ideas to improve it.

First of all, there is no ORVDX32 extention and I don't see why shouldn't
we have it? It would not be very efficient, but why not?

Next one is related to vector instructions encoding. Let's say there are 2
types of vector instructions: the ones who operate on bytes and another
operate on vector. To distinguish them it would be useful to assume the
byte ones have LSB of 0 and 1 for halves. To do that we have to slightly
tune the encoding: i.e. make lv.avg.b and lv.avg.h be encoded with 0x38 and
0x39 respectively, instead of 0x39 and 0x3a. I could provide suggested list
of changes.

Thanks for attention.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20161011/d9af975e/attachment.html>
