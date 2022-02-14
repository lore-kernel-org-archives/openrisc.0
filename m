From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 14 Feb 2022 09:06:04 -0800
Subject: [OpenRISC] [PATCH 10/14] uaccess: remove most CONFIG_SET_FS
 users
In-Reply-To: <20220214163452.1568807-11-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-11-arnd@kernel.org>
Message-ID: <YgqL/NJ3YHEAhj4i@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 05:34:48PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On almost all architectures, there are no remaining callers
> of set_fs(), so CONFIG_SET_FS can be disabled, along with
> removing the thread_info field and any references to it.
> 
> This turns access_ok() into a cheaper check against TASK_SIZE_MAX.

Wouldn't it make more sense to just merge this into the last patch?
