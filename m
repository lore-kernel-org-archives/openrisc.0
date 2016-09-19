From: Stefan Wallentowitz <stefan@wallentowitz.de>
Date: Mon, 19 Sep 2016 16:59:02 +0200
Subject: [OpenRISC] [PATCH 5/7] openrisc: Support both old (or32) and
 new (or1k) toolchain
In-Reply-To: <57DFF797.7090400@southpole.se>
References: <1474036985-20981-1-git-send-email-shorne@gmail.com>
 <1474036985-20981-6-git-send-email-shorne@gmail.com>
 <8ef63a71-81ed-2a0c-e204-666f7fba5e4c@roeck-us.net>
 <alpine.LFD.2.20.1609191459410.2354@lianli.shorne-pla.net>
 <94c3ee37-19f7-de94-9b61-bc1c06a84d72@roeck-us.net>
 <alpine.LFD.2.20.1609191807160.2352@lianli.shorne-pla.net>
 <e4b7075b-a1f7-74b1-ca62-4f3d2058fe97@roeck-us.net>
 <alpine.LFD.2.20.1609192247170.2352@lianli.shorne-pla.net>
 <57DFF797.7090400@southpole.se>
Message-ID: <10fbfffd-1e85-ffad-1b2d-f05759116c18@wallentowitz.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 19.09.2016 16:35, Jonas Bonn wrote:

> The bigger question I would have at this point is the value of the code
> remaining upstream...  Five years ago, there was a promise to try to get
> the toolchain upstream within a year or two; to this day, I don't know
> that much progress has been made there so this architecture still
> requires a hodge-podge of tools from various sources to build.

Actually, there has been progress. All but one copyright assignment have
been collected and the last one blocks everything. Don't know if there
was any progress on this since last ORCONF, but at least we have like
nearly up-to-date GCC for some time now.

Cheers,
Stefan



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160919/e77b16bd/attachment.sig>
