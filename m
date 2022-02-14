From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 14 Feb 2022 17:10:05 +0000
Subject: [OpenRISC] [PATCH 03/14] nds32: fix access_ok() checks in
 get/put_user
In-Reply-To: <YgqK1ihlJvRFHJ9h@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-4-arnd@kernel.org> <YgqK1ihlJvRFHJ9h@infradead.org>
Message-ID: <8a6e309687d647e3aef8a88bdb0922af@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig
> Sent: 14 February 2022 17:01
> 
> On Mon, Feb 14, 2022 at 05:34:41PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The get_user()/put_user() functions are meant to check for
> > access_ok(), while the __get_user()/__put_user() functions
> > don't.
> >
> > This broke in 4.19 for nds32, when it gained an extraneous
> > check in __get_user(), but lost the check it needs in
> > __put_user().
> 
> Can we follow the lead of MIPS (which this was originally copied
> from I think) and kill the pointless __get/put_user_check wrapper
> that just obsfucate the code?

Is it possible to make all these architectures fall back to
a common definition somewhere?

Maybe they need to define ACCESS_OK_USER_LIMIT - which can be
different from TASK_SIZE.

There'll be a few special cases, but most architectures have
kernel addresses above userspace ones.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

