From: Stafford Horne <shorne@gmail.com>
Date: Sun, 6 Sep 2020 06:34:08 +0900
Subject: [OpenRISC] [PATCH v2 3/3] openrisc: Fix issue with get_user for
 64-bit values
In-Reply-To: <20200905135714.74bsr5h423k7guw4@ltop.local>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-4-shorne@gmail.com>
 <20200905135714.74bsr5h423k7guw4@ltop.local>
Message-ID: <20200905213408.GI3562056@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Sep 05, 2020 at 03:57:14PM +0200, Luc Van Oostenryck wrote:
> On Sat, Sep 05, 2020 at 10:19:35PM +0900, Stafford Horne wrote:
> 
> Hi,
> 
> The change for 64-bit get_user() looks good to me.
> But I wonder, given that openrisc is big-endian, what will happen
> you have the opposite situation:
> 	u32 *ptr;
> 	u64 val;
> 	...
> 	get_user(val, ptr);
> 
> Won't you end with the value in the most significant part of
> the register pair?

Hi Luc,

The get_user function uses the size of the ptr to determine how to do the load ,
so this case would not use the 64-bit pair register logic.  I think it should be
ok, the end result would be the same as c code:

  var = *ptr;

-Stafford
