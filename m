From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 4 Aug 2020 22:46:10 +0200
Subject: [OpenRISC] [PATCH 2/6] openrisc: uaccess: Fix sparse address
 space warnings
In-Reply-To: <20200804042354.3930694-3-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
 <20200804042354.3930694-3-shorne@gmail.com>
Message-ID: <20200804204610.mxzw6ahdnfw6yko2@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Aug 04, 2020 at 01:23:50PM +0900, Stafford Horne wrote:
> The OpenRISC user access functions put_user(), get_user() and
> clear_user() were missing proper sparse annotations.  This generated
> warnings like the below.
> 
> This patch adds the annotations to fix the warnings.
> 
> Example warnings:
> 
> net/ipv4/ip_sockglue.c:759:29: warning: incorrect type in argument 1 (different address spaces)
> net/ipv4/ip_sockglue.c:759:29:    expected void const volatile [noderef] __user *
> net/ipv4/ip_sockglue.c:759:29:    got int const *__gu_addr
> net/ipv4/ip_sockglue.c:764:29: warning: incorrect type in initializer (different address spaces)
> net/ipv4/ip_sockglue.c:764:29:    expected unsigned char const *__gu_addr
> net/ipv4/ip_sockglue.c:764:29:    got unsigned char [noderef] __user *
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Look good to me.

-- Luc
