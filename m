From: Christoph Hellwig <hch@infradead.org>
Date: Sun, 6 Feb 2022 22:45:06 -0800
Subject: [OpenRISC] [PATCH] openrisc: remove CONFIG_SET_FS
In-Reply-To: <20220206013648.3491865-1-shorne@gmail.com>
References: <20220206013648.3491865-1-shorne@gmail.com>
Message-ID: <YgC/8ng5WX6Nt104@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Feb 06, 2022 at 10:36:47AM +0900, Stafford Horne wrote:
> Remove the address space override API set_fs() used for User Mode Linux.

This ain't UML :)

> +	return size <= TASK_SIZE && addr <= (TASK_SIZE - size);

No need for the inner braces.
