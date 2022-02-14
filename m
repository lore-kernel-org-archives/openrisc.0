From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 14 Feb 2022 20:17:07 +0000
Subject: [OpenRISC] [PATCH 04/14] x86: use more conventional access_ok()
 definition
In-Reply-To: <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org>
 <YgqLFYqIqkIsNC92@infradead.org>
 <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
 <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
Message-ID: <Ygq4wy9fikDYmuHU@zeniv-ca.linux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 12:01:05PM -0800, Linus Torvalds wrote:
> On Mon, Feb 14, 2022 at 11:46 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > As Al pointed out, they turned out to be necessary on sparc64, but the only
> > definitions are on sparc64 and x86, so it's possible that they serve a similar
> > purpose here, in which case changing the limit from TASK_SIZE to
> > TASK_SIZE_MAX is probably wrong as well.
> 
> x86-64 has always(*) used TASK_SIZE_MAX for access_ok(), and the
> get_user() assembler implementation does the same.
> 
> I think any __range_not_ok() users that use TASK_SIZE are entirely
> historical, and should be just fixed.

IIRC, that was mostly userland stack trace collection in perf.
I'll try to dig in archives and see what shows up - it's been
a while ago...
