From: Stefan Wallentowitz <stefan@wallentowitz.de>
Date: Fri, 2 Sep 2016 19:12:18 +0200
Subject: [OpenRISC] New OpTiMSoC release
Message-ID: <dcc5dd71-8fb6-c8d1-8b5d-48c60a4cdd36@wallentowitz.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all,

I am forwarding my announcement here as it is closely related to
OpenRISC (its the processor core in our manycore SoC) and we have
switched entirely to FuseSoC.

Hope it finds your interest!

Cheers,
Stefan

Announcement:

Hi folks,

it has been very quiet for some time now, but we finally released a new
OpTiMSoC version today: http://www.optimsoc.org/blog/2016/09/02/release.html

The delay is mainly because we cut out our debug infrastructure and
transfered the concepts to the more generic "Open SoC Debug" project
(opensocdebug.org). The projects got a fresh start with generalized
modules and better scalability. I was involved in supporting the same
infrastructure in the lowRISC project (lowrisc.org). So you can use the
same debug methodology with two open source SoCs now!

Beside that we added support for FuseSoC, which is a package manager for
hardware IP.

We are already planning the next release, so stay tuned for more board
support and more platform variants.

The OpTiMSoC team will be at ORCONF (orconf.org) as every year, this
time in Bologna from October 7-9. Would be great to meet you there!

Cheers,
Stefan





-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160902/afbcbd3b/attachment.sig>
