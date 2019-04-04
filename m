From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 4 Apr 2019 17:06:08 -0400
Subject: [OpenRISC] [PATCH 5/6 v3] syscalls: Remove start and number
 from syscall_get_arguments() args
In-Reply-To: <20190404181758.GA8071@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.278590567@goodmis.org>
 <20190404181758.GA8071@altlinux.org>
Message-ID: <20190404170608.25cadc7d@gandalf.local.home>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, 4 Apr 2019 21:17:58 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:

> There are several places listed below where I'd prefer to see more readable
> equivalents, but feel free to leave it to respective arch maintainers.

I was going to do similar changes, but figured I'd do just that (let
the arch maintainers further optimize the code). I made this more about
fixing the interface and less about the optimization and clean ups that
it can allow.

-- Steve
