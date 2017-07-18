From: Philipp Wagner <lists@philipp-wagner.com>
Date: Tue, 18 Jul 2017 17:57:53 +0200
Subject: [OpenRISC] Dev Digest, Vol 14, Issue 5
In-Reply-To: <59124735.4203645.1500392970520@mail.yahoo.com>
References: <mailman.3.1500372002.20804.dev@lists.librecores.org>
 <59124735.4203645.1500392970520@mail.yahoo.com>
Message-ID: <c880cd71-edc3-8d9e-00c6-e8ffcd00b340@philipp-wagner.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

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
