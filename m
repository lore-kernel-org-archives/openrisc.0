From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 26 Nov 2016 22:40:52 -0800
Subject: [OpenRISC] [PATCH v2 1/4] gdb: Add tdesc_find_register functions
In-Reply-To: <ffdc788c10996edca2b068acd5d43fda1592be01.1480216015.git.shorne@gmail.com>
References: <cover.1480216015.git.shorne@gmail.com>
 <ffdc788c10996edca2b068acd5d43fda1592be01.1480216015.git.shorne@gmail.com>
Message-ID: <20161127064052.GV21655@vapier.lan>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 27 Nov 2016 15:16, Stafford Horne wrote:
> +/* Search FEATURE for a register REGNO and return its name. */

GNU style puts two spaces after periods

> +char *
> +tdesc_find_register_name (const struct tdesc_feature *feature,
> +			   int regno)
> +char *
> +tdesc_find_register_group_name (const struct tdesc_feature *feature,
> +			   int regno)

seems like return values for both of these should be const
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20161126/03586987/attachment.sig>
