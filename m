From: Christoph Hellwig <hch@lst.de>
Date: Sat, 17 Aug 2019 09:32:27 +0200
Subject: [OpenRISC] generic ioremap (and lots of cleanups)
Message-ID: <20190817073253.27819-1-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all,

the last patches in this series add a generic ioremap implementation,
and switch our 3 most recent and thus most tidy architeture ports over
to use it.  With a little work and an additional arch hook or two the
implementation should be able to eventually cover more than half of
our ports.

The patches before that clean up various lose ends in the ioremap
and iounmap implementations.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git generic-ioremap

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-ioremap
