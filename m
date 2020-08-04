From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 4 Aug 2020 22:50:36 +0200
Subject: [OpenRISC] [PATCH 6/6] openrisc: uaccess: Add user address
 space check to access_ok
In-Reply-To: <20200804042354.3930694-7-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
 <20200804042354.3930694-7-shorne@gmail.com>
Message-ID: <20200804205036.vgy7h3mmojzmjihs@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Aug 04, 2020 at 01:23:54PM +0900, Stafford Horne wrote:
> Now that __user annotations are fixed for openrisc uaccess api's we can
> add checking to the access_ok macro.  This patch adds the __chk_user_ptr
> check, on normal builds the added check is a nop.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Look good to me.

-- Luc
