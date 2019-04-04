From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 4 Apr 2019 09:52:56 +0200 (CEST)
Subject: [OpenRISC] [PATCH 5/6 v3] syscalls: Remove start and number
 from syscall_get_arguments() args
In-Reply-To: <20190401134421.278590567@goodmis.org>
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.278590567@goodmis.org>
Message-ID: <alpine.DEB.2.21.1904040952280.1833@nanos.tec.linutronix.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, 1 Apr 2019, Steven Rostedt wrote:

> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
> function call syscall_get_arguments() implemented in x86 was horribly
> written and not optimized for the standard case of passing in 0 and 6 for
> the starting index and the number of system calls to get. When looking at
> all the users of this function, I discovered that all instances pass in only
> 0 and 6 for these arguments. Instead of having this function handle
> different cases that are never used, simply rewrite it to return the first 6
> arguments of a system call.
> 
> This should help out the performance of tracing system calls by ptrace,
> ftrace and perf.
> 
> Link: http://lkml.kernel.org/r/20161107213233.754809394 at goodmis.org

For x86:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
