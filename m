From: Stafford Horne <shorne@gmail.com>
Date: Fri, 5 Feb 2021 23:43:17 +0900
Subject: [OpenRISC] [PATCH v2] openrisc: use device tree to determine
 present cpus
In-Reply-To: <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
 <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
 <20210131212752.GG2002709@lianli.shorne-pla.net>
 <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
Message-ID: <20210205144317.GK2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 01, 2021 at 12:49:31PM +0100, Jan Henrik Weinstock wrote:
> Use the device tree to determine the present cpus instead of assuming all
> CONFIG_NRCPUS are actually present in the system.
> 
> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>

Hi Jan,

I cannot apply this patch, it seems you somehow sent it signed as a multipart
message via Thunderbird.

This causes errors when trying to apply, even after I tried to manually fix the
patch mail:

    Applying: openrisc: use device tree to determine present cpus
    error: sha1 information is lacking or useless (arch/openrisc/kernel/smp.c).
    error: could not build fake ancestor
    Patch failed at 0001 openrisc: use device tree to determine present cpus

Can you send this using 'git send-email?'

If not I can get it applied with some work, otherwise you can point me to a git
repo which I can pull it from.

-Stafford
