From: Christoph Hellwig <hch@lst.de>
Date: Wed, 13 May 2020 08:23:18 +0200
Subject: [OpenRISC] [PATCH 19/31] riscv: use asm-generic/cacheflush.h
In-Reply-To: <mhng-8adbedbc-0f91-4291-9471-2df5eb7b802b@palmerdabbelt-glaptop1>
References: <20200510075510.987823-20-hch@lst.de>
 <mhng-8adbedbc-0f91-4291-9471-2df5eb7b802b@palmerdabbelt-glaptop1>
Message-ID: <20200513062318.GA24133@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 12, 2020 at 04:00:26PM -0700, Palmer Dabbelt wrote:
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> Were you trying to get these all in at once, or do you want me to take it into
> my tree?

Except for the small fixups at the beginning of the series this needs
to go in together.  I'll have to do at least another resend, and after
that I hope Andrew is going to pick it up.
