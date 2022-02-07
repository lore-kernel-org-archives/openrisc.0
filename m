From: Stafford Horne <shorne@gmail.com>
Date: Mon, 7 Feb 2022 16:23:59 +0900
Subject: [OpenRISC] [PATCH] openrisc: remove CONFIG_SET_FS
In-Reply-To: <YgC/8ng5WX6Nt104@infradead.org>
References: <20220206013648.3491865-1-shorne@gmail.com>
 <YgC/8ng5WX6Nt104@infradead.org>
Message-ID: <YgDJD4jEA+f2hsHg@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Feb 06, 2022 at 10:45:06PM -0800, Christoph Hellwig wrote:
> On Sun, Feb 06, 2022 at 10:36:47AM +0900, Stafford Horne wrote:
> > Remove the address space override API set_fs() used for User Mode Linux.
> 
> This ain't UML :)

Yes, Geert also brought that up.  As I mentioned there I took the text from your
commit message in commit 8bb227ac34c0 ("um: remove set_fs").

I didn't realize arch/um is for User Model Linux, I always thought um was just
some other processor!  Next, I thought your comment 'used for User Mode Linux'
was just referring to userpsace.

Now I get it!

I will fix this up in v2.

> > +	return size <= TASK_SIZE && addr <= (TASK_SIZE - size);
> 
> No need for the inner braces.

You mean to just write as:

	return size <= TASK_SIZE && addr <= TASK_SIZE - size;

I prefer keeping the braces around (TASK_SIZE - size).

-Stafford
