From: David Laight <David.Laight@ACULAB.COM>
Date: Sat, 8 May 2021 11:42:13 +0000
Subject: [OpenRISC] [RFC 02/12] openrisc: always use unaligned-struct
 header
In-Reply-To: <20210507220813.365382-3-arnd@kernel.org>
References: <20210507220813.365382-1-arnd@kernel.org>
 <20210507220813.365382-3-arnd@kernel.org>
Message-ID: <7f2ca7e366a444108932c4c3bb95c2f9@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann
> Sent: 07 May 2021 23:08
...
> I don't know how the loads/store perform compared to the shift version
> on a particular microarchitecture, but my guess is that the shifts
> are better.

What does the nios use?
Shifts generate reasonable code for put_unaligned() but
they get horrid for get_unaligned().

On the nios writing the 4 bytes to memory and reading back
a 32bit value should generate shorter faster code.
You do need to generate 4 byte loads, 4 bytes stores, 32bit load.
(The load will cause a stall if the data is needed for one
of the next two instructions, and there is a (undocumented)
stall between a write and read to the same memory area.
The shift version requires 3 shifts and 3 ors - but I think
gcc makes a bigger pig's breakfast of it.)

OTOH I'm not sure anyone in their right mind would run Linux on nios.
It is a soft cpu for the altera (now intel) fpgas.
We use them with 4k code and sub 64k data for real time processing.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

