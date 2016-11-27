From: Stafford Horne <shorne@gmail.com>
Date: Sun, 27 Nov 2016 16:09:43 +0900 (JST)
Subject: [OpenRISC] [PATCH v2 1/4] gdb: Add tdesc_find_register functions
In-Reply-To: <20161127064052.GV21655@vapier.lan>
References: <cover.1480216015.git.shorne@gmail.com>
 <ffdc788c10996edca2b068acd5d43fda1592be01.1480216015.git.shorne@gmail.com>
 <20161127064052.GV21655@vapier.lan>
Message-ID: <alpine.LFD.2.20.1611271606070.29569@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


On Sat, 26 Nov 2016, Mike Frysinger wrote:

> On 27 Nov 2016 15:16, Stafford Horne wrote:
>> +/* Search FEATURE for a register REGNO and return its name. */
>
> GNU style puts two spaces after periods

Understood, sorry I didnt notice it it will be fixed in the next patch 
version.

>> +char *
>> +tdesc_find_register_name (const struct tdesc_feature *feature,
>> +			   int regno)
>> +char *
>> +tdesc_find_register_group_name (const struct tdesc_feature *feature,
>> +			   int regno)
>
> seems like return values for both of these should be const

Yes, of course, this will also be fixed.

I will check against the other patches too for any similar issues.

FYI, that patches to or1k-tdep.c have detailed function comments which 
dont seem to match the GNU style, any comment on that?

-Stafford

