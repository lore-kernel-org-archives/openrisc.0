From: Pedro Alves <palves@redhat.com>
Date: Tue, 11 Dec 2018 12:40:37 +0000
Subject: [OpenRISC] [RESEND PATCH] gdb/or1k: Add linux debugging support
In-Reply-To: <20181207063909.15365-1-shorne@gmail.com>
References: <20181207063909.15365-1-shorne@gmail.com>
Message-ID: <e1e54818-9a25-1cc3-c04d-86cfc0c485bf@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 12/07/2018 06:39 AM, Stafford Horne wrote:
> (Resend to include binutils list)
> 
> Up until now OpenRISC GDB only has supported bare metal debugging.  This
> patch adds linux userspace debugging and core dump analysis support.

Could you send a patch to documents this addition in the gdb/NEWS file?

https://sourceware.org/gdb/wiki/ContributionChecklist#Documentation

Thanks,
Pedro Alves
