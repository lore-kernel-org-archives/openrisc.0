From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jan 2019 10:16:39 -0800
Subject: [OpenRISC] [PATCH] arch/openrisc: Fix issues with access_ok()
In-Reply-To: <CAHk-=whR9UX8wG0CKp87sNQkNdtMPVmAmi-gjGRwWTYYAJ9v_w@mail.gmail.com>
References: <20190108131516.27903-1-shorne@gmail.com>
 <CAHk-=whR9UX8wG0CKp87sNQkNdtMPVmAmi-gjGRwWTYYAJ9v_w@mail.gmail.com>
Message-ID: <CAHk-=wic8HES0M_KgB3Tfaufb36r42ZKw4a0t96Xq_efCoR02Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jan 8, 2019 at 10:10 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 8, 2019 at 5:15 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > The commit 594cc251fdd0 ("make 'user_access_begin()' do 'access_ok()'")
> > exposed incorrect implementations of access_ok() macro in several
> > architectures.  This change fixes 2 issues found in OpenRISC.
>
> Looks good to me. Should I apply this directly, or expect a pull
> request with it later?

Oh, and replying to myself with a quick note: it might also be a good
idea to just make it an inline function.

The only reason I did alpha and SH as those macros with a statement
expression was that because I don't have a cross-build environment,
continuing to do it as a macro was the safest thing from a build
standpoint.

One big difference between a macro and an inline function is that the
inline function requires everything to be declared at the point of the
function definition, while the macro can use things that get declared
only later (like "get_fs()"). So a macro can use functions and other
macros that aren't declared yet, but will be declared by the time the
macro is actually _used_.

So when changing the macro "blind", it was simply safer to just keep
it a macro and just make it a bit more complex. But since you can
build-test your changes, making (for example) __range_ok() be an
inline function might have been the cleaner solution to the "use
twice" issue.

But your existing patch looks fine to me too, so don't worry too much
about it. I just wanted to point out that the reason I did alpha and
SH the way I did was not some "macros are better", but rather "Linus
is weak and lazy".

               Linus
