From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 14 Feb 2022 20:40:07 +0100
Subject: [OpenRISC] [PATCH 10/14] uaccess: remove most CONFIG_SET_FS
 users
In-Reply-To: <YgqL/NJ3YHEAhj4i@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-11-arnd@kernel.org>
 <YgqL/NJ3YHEAhj4i@infradead.org>
Message-ID: <CAK8P3a3eOw=QpxWFnODE61EFt8oGPJ7dcusfbPSD1vdEsUmekQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 6:06 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:48PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > On almost all architectures, there are no remaining callers
> > of set_fs(), so CONFIG_SET_FS can be disabled, along with
> > removing the thread_info field and any references to it.
> >
> > This turns access_ok() into a cheaper check against TASK_SIZE_MAX.
>
> Wouldn't it make more sense to just merge this into the last patch?

Yes, sounds good. I wasn't sure at first if there is enough buy-in to get
all architectures cleaned up, and I hadn't done the ia64 patch, so it
seemed more important to do this part early, but now it seems that it
will all go in at the same time, so doing this as part of a big removal
at the end makes sense.

        Arnd
