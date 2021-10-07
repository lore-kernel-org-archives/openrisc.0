From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 7 Oct 2021 07:53:01 +0000
Subject: [OpenRISC] [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
In-Reply-To: <20211006212728.GM10333@gate.crashing.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-7-robh@kernel.org> <YV4KkAC2p9D4yCnH@antec>
 <20211006212728.GM10333@gate.crashing.org>
Message-ID: <c81b9c01650e487785b02f6562791556@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Segher Boessenkool
> Sent: 06 October 2021 22:27
> 
> On Thu, Oct 07, 2021 at 05:44:00AM +0900, Stafford Horne wrote:
> > You have defined of_get_cpu_hwid to return u64, will this create compiler
> > warnings when since we are storing a u64 into a u32?
> >
> > It seems only if we make with W=3.
> 
> Yes.  This is done by -Wconversion, "Warn for implicit conversions that
> may alter a value."
> 
> > I thought we usually warned on this.

The microsoft compiler does - best to turn all those warnings off.

> This warning is not in -Wall or -Wextra either, it suffers too much from
> false positives.  It is very natural to just ignore the high bits of
> modulo types (which is what "unsigned" types *are*).  Or the bits that
> "fall off" on a conversion.  The C standard makes this required
> behaviour, it is useful, and it is the only convenient way of getting
> this!

I've also seen a compiler convert:
	struct->char_member = (char)(int_val & 0xff);
into:
	reg = int_val;
	reg &= 0xff; // for the & 0xff
	reg &= 0xff; // for the cast
	struct->char_member = low_8bits(reg);

You really don't want the extra noise.

I'll bet that (char)int_val is actually an arithmetic expression.
So its type will be 'int'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

