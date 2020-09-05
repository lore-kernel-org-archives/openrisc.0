From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sat, 5 Sep 2020 15:57:14 +0200
Subject: [OpenRISC] [PATCH v2 3/3] openrisc: Fix issue with get_user for
 64-bit values
In-Reply-To: <20200905131935.972386-4-shorne@gmail.com>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-4-shorne@gmail.com>
Message-ID: <20200905135714.74bsr5h423k7guw4@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Sep 05, 2020 at 10:19:35PM +0900, Stafford Horne wrote:

Hi,

The change for 64-bit get_user() looks good to me.
But I wonder, given that openrisc is big-endian, what will happen
you have the opposite situation:
	u32 *ptr;
	u64 val;
	...
	get_user(val, ptr);

Won't you end with the value in the most significant part of
the register pair?

-- Luc
