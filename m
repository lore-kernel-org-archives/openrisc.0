From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 4 Apr 2019 09:53:16 +0200 (CEST)
Subject: [OpenRISC] [PATCH 6/6 v3] syscalls: Remove start and number
 from syscall_set_arguments() args
In-Reply-To: <20190401134421.442323029@goodmis.org>
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.442323029@goodmis.org>
Message-ID: <alpine.DEB.2.21.1904040953040.1833@nanos.tec.linutronix.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, 1 Apr 2019, Steven Rostedt wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> After removing the start and count arguments of syscall_get_arguments() it
> seems reasonable to remove them from syscall_set_arguments(). Note, as of
> today, there are no users of syscall_set_arguments(). But we are told that
> there will be soon. But for now, at least make it consistent with
> syscall_get_arguments().
> 
> Link: http://lkml.kernel.org/r/20190327222014.GA32540 at altlinux.org

For x86:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
