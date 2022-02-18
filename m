From: Christoph Hellwig <hch@lst.de>
Date: Fri, 18 Feb 2022 07:34:50 +0100
Subject: [OpenRISC] [PATCH v2 13/18] uaccess: generalize access_ok()
In-Reply-To: <20220216131332.1489939-14-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-14-arnd@kernel.org>
Message-ID: <20220218063450.GI22576@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

> +#include <asm-generic/access_ok.h>

Instead of the asm-generic games, shouldn't we just define access_ok in
<linux/uaccess.h> if not already defined by the architecture?
