From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sun, 6 Sep 2020 02:22:28 +0200
Subject: [OpenRISC] [PATCH v2 3/3] openrisc: Fix issue with get_user for
 64-bit values
In-Reply-To: <20200905213408.GI3562056@lianli.shorne-pla.net>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-4-shorne@gmail.com>
 <20200905135714.74bsr5h423k7guw4@ltop.local>
 <20200905213408.GI3562056@lianli.shorne-pla.net>
Message-ID: <20200906002228.mrbs7pdyrf5ooi3c@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Sep 06, 2020 at 06:34:08AM +0900, Stafford Horne wrote:
> On Sat, Sep 05, 2020 at 03:57:14PM +0200, Luc Van Oostenryck wrote:
> > On Sat, Sep 05, 2020 at 10:19:35PM +0900, Stafford Horne wrote:
> > 
> > Hi,
> > 
> > The change for 64-bit get_user() looks good to me.
> > But I wonder, given that openrisc is big-endian, what will happen
> > you have the opposite situation:
> > 	u32 *ptr;
> > 	u64 val;
> > 	...
> > 	get_user(val, ptr);
> > 
> > Won't you end with the value in the most significant part of
> > the register pair?
> 
> Hi Luc,
> 
> The get_user function uses the size of the ptr to determine how to do the load ,
> so this case would not use the 64-bit pair register logic.  I think it should be
> ok, the end result would be the same as c code:
> 
>   var = *ptr;

Hi,

Sorry to insist but both won't give the same result.
The problem comes from the output part of the asm: "=r" (x).

The following code:
	u32 getp(u32 *ptr)
	{
		u64 val;
		val = *ptr;
		return val;
	}
will compile to something like:
	getp:
		l.jr	r9
		l.lwz	r11, 0(r3)

The load is written to r11, which is what is returned. OK.

But the get_user() code with a u32 pointer *and* a u64 destination
is equivalent to something like:
	u32 getl(u32 *ptr)
	{
		u64 val;

		asm("l.lwz %0,0(%1)" : "=r"(val) : "r"(ptr));
		return val;
	}
and this compiles to:
	getl:
		l.lwz	r17,0(r3)
		l.jr	r9
		l.or	r11, r19, r19

The load is written to r17 but what is returned is the content of r19.
Not good.

I think that, in the get_user() code:
* if the pointer is a pointer to a 64-bit quantity, then variable
  used in as the output in the asm needs to be a 64-bit variable
* if the pointer is a pointer to a 32-bit quantity, then variable
  used in as the output in the asm needs to be a 64-bit variable
At least one way to guarantee this is to use a temporary variable
that matches the size of the pointer.

-- Luc
