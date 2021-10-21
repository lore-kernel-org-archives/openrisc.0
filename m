From: Eric W. Biederman <ebiederm@xmission.com>
Date: Thu, 21 Oct 2021 11:25:08 -0500
Subject: [OpenRISC] [PATCH 02/20] exit: Remove calls of do_exit after
 noreturn versions of die
In-Reply-To: <202110210858.41719190D2@keescook> (Kees Cook's message of "Thu, 
 21 Oct 2021 09:02:04 -0700")
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-2-ebiederm@xmission.com>
 <202110210858.41719190D2@keescook>
Message-ID: <87cznycpln.fsf@disp2133>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Oct 20, 2021 at 12:43:48PM -0500, Eric W. Biederman wrote:
>> On nds32, openrisc, s390, sh, and xtensa the function die never
>> returns.  Mark die __noreturn so that no one expects die to return.
>> Remove the do_exit calls after die as they will never be reached.
>
> Maybe note that the "bust_spinlocks" calls are also redundant, since
> they're in die(). I note that is a "mismatch" between the do_kill()
> in die() (SIGSEGV) and after die() (SIGKILL). This patch makes no
> behavioral change (the first caller would "win"), but I thought I'd note
> it in case some architecture would prefer a different signal.

If someone has some strong preferences in the matter of which signal a
wait on a processes that has oopsed should return please let me know.

My next step in cleaning up the uses of do_exit looks like it is going
to be getting all of the architectures to use the same signal for oopses
(aka die), and then introducing a helper (called something like
"make_task_dead" or "oops_task_exit" ) that will replace do_exit on the
oops path and not take a signal number at all.

That helper I can then remove the ptrace break point from and possibly
some of the coredump logic as well.  Ultimately it will be something
we can optimize for the case when we know there is a kernel bug and we
just want the task to exit so the rest of the system can limp along
as best as it can.

Eric
