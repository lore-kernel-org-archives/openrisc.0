From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 7 Feb 2022 17:14:43 +0000
Subject: [OpenRISC] [PATCH] openrisc: remove CONFIG_SET_FS
In-Reply-To: <YgC/8ng5WX6Nt104@infradead.org>
References: <20220206013648.3491865-1-shorne@gmail.com>
 <YgC/8ng5WX6Nt104@infradead.org>
Message-ID: <3744dcbbf2874875b023548aacdd8b41@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig
> Sent: 07 February 2022 06:45
> 
> On Sun, Feb 06, 2022 at 10:36:47AM +0900, Stafford Horne wrote:
> > Remove the address space override API set_fs() used for User Mode Linux.
> 
> This ain't UML :)
> 
> > +	return size <= TASK_SIZE && addr <= (TASK_SIZE - size);
> 
> No need for the inner braces.

Since TASK_SIZE is actually an address wouldn't be better to
swap the condition around (in every architecture).

	return addr <= TASK_SIZE && size <= TASK_SIZE - addr;

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

