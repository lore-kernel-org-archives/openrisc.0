From: Kees Cook <keescook@chromium.org>
Date: Thu, 21 Oct 2021 09:02:04 -0700
Subject: [OpenRISC] [PATCH 02/20] exit: Remove calls of do_exit after
 noreturn versions of die
In-Reply-To: <20211020174406.17889-2-ebiederm@xmission.com>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-2-ebiederm@xmission.com>
Message-ID: <202110210858.41719190D2@keescook>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 20, 2021 at 12:43:48PM -0500, Eric W. Biederman wrote:
> On nds32, openrisc, s390, sh, and xtensa the function die never
> returns.  Mark die __noreturn so that no one expects die to return.
> Remove the do_exit calls after die as they will never be reached.

Maybe note that the "bust_spinlocks" calls are also redundant, since
they're in die(). I note that is a "mismatch" between the do_kill()
in die() (SIGSEGV) and after die() (SIGKILL). This patch makes no
behavioral change (the first caller would "win"), but I thought I'd note
it in case some architecture would prefer a different signal.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
