From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 15 Feb 2017 10:42:07 -0500
Subject: [OpenRISC] [PATCH v2 4/6] sim: or1k: add or1k target to sim
In-Reply-To: <20170215132222.GA1603@lianli.shorne-pla.net>
References: <cover.1484967575.git.shorne@gmail.com>
 <92c04bd768b66a48e03850af185e975d01605435.1484967575.git.shorne@gmail.com>
 <20170214185208.GJ28432@vapier>
 <20170215132222.GA1603@lianli.shorne-pla.net>
Message-ID: <20170215154207.GN28432@vapier>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 15 Feb 2017 22:24, Stafford Horne wrote:
> Before, we get started I just want to point out that some of these
> issues seem pretty obvious, but this code had been sitting in the
> openrisc source repo's for some time.  I believe it was done on contract
> by the people mentioned in the cover letter, who may have worked at
> Cygnus.

i suspected it's an old port because it looks like it was copied from
another sim port, but before a lot of cleanups were done.  there has
been a bunch of fixups across the codebase to try and make things easy
for new ports.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170215/5833e4cd/attachment.sig>
