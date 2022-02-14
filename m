From: Christoph Hellwig <hch@lst.de>
Date: Mon, 14 Feb 2022 21:00:11 +0100
Subject: [OpenRISC] [PATCH 04/14] x86: use more conventional access_ok()
 definition
In-Reply-To: <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org> <YgqLFYqIqkIsNC92@infradead.org>
 <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
Message-ID: <20220214200011.GA3786@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 08:45:52PM +0100, Arnd Bergmann wrote:
> As Al pointed out, they turned out to be necessary on sparc64, but the only
> definitions are on sparc64 and x86, so it's possible that they serve a similar
> purpose here, in which case changing the limit from TASK_SIZE to
> TASK_SIZE_MAX is probably wrong as well.
> 
> So either I need to revert the original definition as I did on sparc64, or
> they can be removed completely. Hopefully Al or the x86 maintainers
> can clarify.

Looking at the x86 users I think:

 - valid_user_frame should go away and the caller should use get_user
   instead of __get_user
 - the one in copy_code can just go away, as there is another check
   in copy_from_user_nmi
 - copy_stack_frame should just use access_ok
 - as does copy_from_user_nmi

but yes, having someone who actually knows this code look over it
would be very helpful.
