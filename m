From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jan 2019 10:10:37 -0800
Subject: [OpenRISC] [PATCH] arch/openrisc: Fix issues with access_ok()
In-Reply-To: <20190108131516.27903-1-shorne@gmail.com>
References: <20190108131516.27903-1-shorne@gmail.com>
Message-ID: <CAHk-=whR9UX8wG0CKp87sNQkNdtMPVmAmi-gjGRwWTYYAJ9v_w@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jan 8, 2019 at 5:15 AM Stafford Horne <shorne@gmail.com> wrote:
>
> The commit 594cc251fdd0 ("make 'user_access_begin()' do 'access_ok()'")
> exposed incorrect implementations of access_ok() macro in several
> architectures.  This change fixes 2 issues found in OpenRISC.

Looks good to me. Should I apply this directly, or expect a pull
request with it later?

             Linus
