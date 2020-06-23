From: Kees Cook <keescook@chromium.org>
Date: Mon, 22 Jun 2020 17:46:56 -0700
Subject: [OpenRISC] [PATCH 17/17] arch: rename copy_thread_tls() back to
 copy_thread()
In-Reply-To: <20200622234326.906346-18-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-18-christian.brauner@ubuntu.com>
Message-ID: <202006221745.5999CF5@keescook>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jun 23, 2020 at 01:43:26AM +0200, Christian Brauner wrote:
> Now that HAVE_COPY_THREAD_TLS has been removed, rename copy_thread_tls()
> back simply copy_thread(). It's a simpler name, and doesn't imply that only
> tls is copied here. This finishes an outstanding chunk of internal process
> creation work since we've added clone3().
> [...]
> -copy_thread_tls(unsigned long clone_flags, unsigned long user_stack_base,
> +copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
>  		    unsigned long user_stack_size, struct task_struct *p,
>  		    unsigned long tls)

Maybe clean up the arg indentation too? I'm not sure how strongly people
feel about that, but I think it'd be nice.

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
